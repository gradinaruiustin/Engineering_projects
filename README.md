# Nexys Video + PCam 5C Real-Time Video Processing

## Project Description
This project demonstrates a complete real-time video capture and processing system on the **Nexys Video FPGA board** using the **Digilent PCam 5C (5MP fixed)** camera. The video stream from the camera is processed directly on the FPGA and displayed on a monitor via HDMI.  

### Key Features
- Capture high-resolution video (5MP) from the PCam 5C camera
- Real-time video processing on FPGA, including:
  - Scaling / resolution adjustment
  - Brightness and contrast control
  - Color manipulation: RGB, grayscale, black-and-white
- Display output via HDMI to monitor or laptop
- Parameter control in real-time via Vitis software

---

## System Architecture


### Video Processing Pipeline
The pipeline is modular and can be extended:
1. **Scaler / Resolution Adjuster** – Resize video frames to desired resolution (e.g., 1080p, 720p, 640x480)
2. **Brightness & Contrast Module** – Adjust frame brightness and contrast dynamically
3. **Color Processing Module** – Convert between RGB, grayscale, and black-and-white
4. **Frame Buffer (Optional)** – Temporary frame storage for advanced processing
5. **HDMI Output Controller** – Drives the video signal to HDMI output

---

## Hardware & Software Requirements

### Hardware
- Nexys Video (Xilinx Artix-7 XC7A200T)
- Digilent PCam 5C (5MP fixed camera)
- HDMI-compatible monitor or laptop
- FMC connector for camera

### Software
- **Vivado 2025.2** – FPGA design, IP integration, block design, synthesis
- **Vitis 2025.2** – Embedded software and runtime control
- Nexys Video board files from Digilent
- Digilent Video IP cores and drivers (e.g., `xvidc`, `video processing subsystem`)

---

## Installation and Setup

### 1. Vivado FPGA Project Setup
1. Open Vivado → **Create New Project** → Name: `Pcam5C_Display`
2. Select **RTL Project**, no sources
3. Choose target board: **Nexys Video (XC7A200T)**
4. Create **Block Design**:
   - **PCam 5C Camera Input Core** (AXI4-Stream interface)
   - **Video Processing Subsystem** (Brightness, Contrast, Color, Scaling)
   - **HDMI Output Controller**
   - **AXI Interconnect** and **Clocking Wizard** for timing and synchronization
5. Connect video stream:  
   `Camera AXI Stream → Video Processing → HDMI Output`
6. Validate, synthesize, implement, and generate bitstream
7. Export hardware with bitstream for Vitis

### 2. Vitis Software Project Setup
1. Create a **Platform Project** using the exported bitstream
2. Create **Application Project (C/C++)**
3. Initialize camera and HDMI output:
```c
PCam5C_Init();        // Initialize camera
VideoOut_Init();      // Initialize HDMI output
