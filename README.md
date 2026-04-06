# 4-Channel Request-Acknowledge Switch (Request-ACK Interface)

## 2.1 Block Diagram
The block diagram shows a **Switch module** with a **FIFO memory** handling the **MEM_ARRAY**.

## 2.2 General DUT Functionality
The switch module distributes data packets received on a single input interface to four independent output ports, using a **buffered architecture**. Data flow is managed via an internal shared memory and a **FIFO (First-In-First-Out) control mechanism**.

### Operation:
1. **Write Stage:** Input data—composed of a 2-bit channel address and 8-bit payload—is saved in internal memory if space is available.
2. **Read & Distribution Stage:** The control logic examines the FIFO at the read pointer (`rd_ptr`). Based on the destination bits in the packet, it identifies the target output port. Data transfer occurs only when the selected port asserts a request signal (`req_rd_i`) and is validated via a **request-acknowledge protocol**.

**Note:** The module exhibits **Head-of-Line (HOL) Blocking**, meaning packets are processed in strict arrival order. If the packet at the top is destined for a channel that does not request it, subsequent packets are stalled even if their channels are requesting.

## 2.3 DUT Interfaces

### Parameters

| Parameter | Description |
|-----------|-------------|
| DATA_WIDTH | Packet data length |
| DEPTH | Number of memory locations in the stack |

### Input Interface

| Signal | Bits | Direction | Description |
|--------|------|-----------|-------------|
| clk | 1 | Input | Clock signal |
| rst_n | 1 | Input | Active-low reset |
| req_wr_i | 1 | Input | Indicates a write request |
| data_wr_i | DATA_WIDTH + 2 | Input | Packet to write: 2-bit address + 8-bit payload |
| ack_wr_o | 1 | Output | Confirms data is written to memory |

### FIFO Module Interface

| Signal | Bits | Direction | Description |
|--------|------|-----------|-------------|
| clk | 1 | Input | Clock |
| rst_n | 1 | Input | Active-low reset |
| req_rd_o | 4 | Input | Read request per channel (1 = active) |
| data_rd_o | 4 × DATA_WIDTH | Output | Output data matrix (8-bit per channel) |
| ack_rd_i | 4 | Output | Confirms channel can accept data |

## 2.4 DUT Functionalities

### 2.4.1 Write Interface & Memory Management
- **Condition for write:** `req_wr_i = 1`, `ack_wr_o = 0`, and FIFO not full (`!full_internal`)  
- **Storing:** Writes data to `mem_array` at `wr_ptr`  
- **FIFO Synchronization:** Generates `fifo_push_cmd` to increment FIFO pointers  
- **Acknowledgement:** `ack_wr_o` pulses high for one clock cycle  

### 2.4.2 Read Interface & Routing
- **Destination Identification:** Extract top 2 bits (`current_packet_dest`) from FIFO  
- **Transaction Validation:** Transfer occurs only if FIFO not empty (`!empty_internal`) and channel requests data (`req_rd_i[current_packet_dest]`)  
- **Data Transfer Steps:**
  1. Copy packet to `data_buffer`  
  2. Pulse `fifo_pop_cmd`  
  3. Assert `ack_rd_o` for one clock cycle  
  4. Output data present only while `req` active; other channels output `0`  
  5. Reset channel data to `0` after transfer  

## 2.5 Edge Cases

1. **FIFO Full:** Ignore write requests; `ack_wr_o` stays `0`, `wr_ptr` unchanged  
2. **Head-of-Line Blocking:** If top packet's channel is inactive, no other channels are served  
3. **Back-to-Back Write:** Ensure a minimum dead cycle between ACK pulses; both packets stored at consecutive addresses  
4. **Full Throughput:** Simultaneous write/read increments both pointers; `no_elements` constant  
5. **FIFO Empty:** Read requests ignored; output data `0`; `ack_rd_o = 0`  

## 2.6 Truth Tables

### 2.6.1 ack_wr_o (Write Interface)

| rst_n | req_wr_i | fifo_full | ack_wr_o(Tn) | ack_wr_o(Tn+1) | Description |
|-------|----------|-----------|--------------|----------------|-------------|
| 0 | X | X | X | 0 | Reset |
| 1 | 0 | X | 0 | 0 | Idle |
| 1 | 1 | 1 | 0 | 0 | Full: reject |
| 1 | 1 | 0 | 0 | 1 | Accept |
| 1 | 1 | X | 1 | 0 | Auto-reset after 1 cycle |

### 2.6.2 ack_rd_o (Read Interface)

| rst_n | req_rd_i[k] | fifo_empty | Packet Dest | ack_rd_o[k](Tn) | ack_rd_o[k](Tn+1) | Description |
|-------|-------------|------------|------------|----------------|-----------------|-------------|
| 0 | X | X | X | X | 0 | Reset |
| 1 | 0 | X | X | 0 | 0 | Idle |
| 1 | 1 | 1 | X | 0 | 0 | Underflow |
| 1 | 1 | 0 | != k | 0 | 0 | Blocking |
| 1 | 1 | 0 | == k | 0 | 1 | Transfer & POP |
| 1 | 1 | X | X | 1 | 0 | Auto-reset |

### 2.6.3 FIFO Pointer Evolution

| ack_wr_o | ack_rd_o | FIFO Action | Pointer Effect |
|----------|----------|-------------|----------------|
| 0 | 0 | None | Pointers unchanged |
| 1 | 0 | PUSH | `wr_ptr++`, `no_elements++` |
| 0 | 1 | POP | `rd_ptr++`, `no_elements--` |
| 1 | 1 | PUSH & POP | Both pointers increment; `no_elements` constant |

## 2.7 Waveforms

1. **Normal Write:** Packet `aa` written to channel 0  
2. **Normal Read:** Packet `aa` read from channel 0  
3. **Back-to-Back Writes:** `cc` to channel 3, immediately followed by `dd` to channel 2  
4. **Back-to-Back Reads:** `cc` read from channel 3, then `dd` from channel 2 (rd_ptr order preserved)  
5. **Write Until Full:** Writing 7 elements when `DEPTH = 6`; only first 6 stored  
