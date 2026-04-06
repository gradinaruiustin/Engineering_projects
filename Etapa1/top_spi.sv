module top_spi (
    input        rst_n,
    input        clk,
    input        KEY1,
    input  [5:0] SW,
    output [7:0] LEDR,

    // SPI
    output       spi_cs_no,
    output       spi_clk_o,
    output       spi_data_o,
    output       spi_oe_o,
    input        spi_data_i,

    output       req_driv,
    output       req_ack
);

logic clk_spi;
logic [7:0] rd_data;
logic read_ack;
logic [7:0] last_value;

//----------------------
// PLL SPI
//----------------------
pll_spi pll_spi_inst (
    .areset(~rst_n),
    .inclk0(clk),
    .c0(),        // sistem
    .c1(clk_spi), // SPI
    .locked()
);

//----------------------
// Req Driver - front KEY1
//----------------------
req_driver rd_inst (
    .clk(clk),
    .rst_n(rst_n),
    .KEY1(KEY1),
    .req_driv(req_driv)
);

//----------------------
// SPI PHY
//----------------------
spi_phy spi_inst (
    .rst_ni(rst_n),
    .clk_i(clk_spi),
    .spi_clk_i(clk_spi),
    .req_i(req_driv),
    .rw_ni(1'b1),       // citire
    .addr_i(SW),
    .wr_data_i(8'b0),
    .ack_o(read_ack),
    .rd_data_o(rd_data),
    .spi_cs_no(spi_cs_no),
    .spi_clk_o(spi_clk_o),
    .spi_data_o(spi_data_o),
    .spi_data_i(spi_data_i),
    .spi_oe_o(spi_oe_o)
);

//----------------------
// Salvare valoare și req_ack
//----------------------
req_ack_reg ack_inst (
    .clk(clk),
    .rst_n(rst_n),
    .rd_data(rd_data),
    .read_ack(read_ack),
    .last_value(last_value),
    .req_ack(req_ack)
);

//----------------------
// LED-uri active-low
//----------------------
assign LEDR = ~last_value;

endmodule