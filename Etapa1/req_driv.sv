module req_driver (
    input  clk,
    input  rst_n,
    input  KEY1,
    output req_driv
);

logic key1_d, key1_dd;

always_ff @(posedge clk or negedge rst_n) begin
    if (~rst_n) begin
        key1_d  <= 1'b0;
        key1_dd <= 1'b0;
    end else begin
        key1_d  <= KEY1;
        key1_dd <= key1_d;
    end
end

assign req_driv = key1_d & ~key1_dd;

endmodule