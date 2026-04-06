module req_ack (
    input        clk,
    input        rst_n,
    input  [7:0] rd_data,
    input        read_ack,
    output [7:0] last_value,
    output       req_ack
);

logic [7:0] value_reg;

always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n)
        value_reg <= 8'b0;
    else if (read_ack)
        value_reg <= rd_data;
end

assign last_value = value_reg;
assign req_ack    = read_ack;

endmodule