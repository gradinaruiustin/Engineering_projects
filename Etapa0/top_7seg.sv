module top_7seg (
  input 	logic 			clk,
  input 	logic 			rst_n,
  output logic [47:0] 	HEX_out
);

logic 		tick;
logic 		row;
logic [2:0] col;

ck_div #(
.Timer(5000000)
) ck (
  .clk(clk),
  .rst_n(rst_n),
  .tick(tick)
);

walking_7seg 
	walking (
  .clk(clk),
  .rst_n(rst_n),
  .tick(tick),
  .row(row),
  .col(col)
);

driver_7seg 
	driver (
  .row(row),
  .col(col),
  .HEX_out(HEX_out)
);

endmodule