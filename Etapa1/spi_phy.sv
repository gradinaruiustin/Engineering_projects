module spi_phy (
    input        rst_ni,
    input        clk_i,
    input        spi_clk_i,

    input        req_i,
    input        rw_ni,
    input  [5:0] addr_i,
    input  [7:0] wr_data_i,
    output logic ack_o,
    output [7:0] rd_data_o,

    output       spi_cs_no,
    output       spi_clk_o,
    output       spi_data_o,
    input        spi_data_i,
    output       spi_oe_o
);

localparam SHREG_WIDTH = 16;

logic [SHREG_WIDTH-1 : 0] shift_reg;
logic [SHREG_WIDTH-1 : 0] shift_cnt;
logic wr_op, req;

assign req = req_i && ~ack_o;

always_ff @ (posedge clk_i or negedge rst_ni) begin
    if (~rst_ni)
        shift_cnt <= 'b0;
    else if (req && spi_cs_no)
        shift_cnt <= {SHREG_WIDTH{1'b1}};
    else
        shift_cnt <= shift_cnt >> 1;
end

always_ff @ (posedge clk_i or negedge rst_ni) begin
    if (~rst_ni)
        wr_op <= 1'b0;
    else if (req)
        wr_op <= ~rw_ni;
end

assign spi_cs_no = ~shift_cnt[0];
assign spi_clk_o = spi_cs_no ? 1'b1 : spi_clk_i;
assign spi_oe_o  = shift_cnt[8] || (wr_op && ~spi_cs_no);

always_ff @ (posedge clk_i or negedge rst_ni) begin
    if (~rst_ni)
        shift_reg <= 'b0;
    else if (~spi_cs_no)
        shift_reg <= (shift_reg << 1) | spi_data_i;
    else if (req)
        shift_reg <= {rw_ni, 1'b0, addr_i, wr_data_i};
end

assign spi_data_o = shift_reg[SHREG_WIDTH-1];
assign rd_data_o  = shift_reg[7:0];

always_ff @ (posedge clk_i or negedge rst_ni) begin
    if (~rst_ni)
        ack_o <= 1'b0;
    else
        ack_o <= shift_cnt[1:0] == 2'b01;
end

endmodule