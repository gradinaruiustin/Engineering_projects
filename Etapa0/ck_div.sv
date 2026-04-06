module ck_div #(
  parameter Timer = 5000000
)(
  input 	logic clk,
  input 	logic rst_n,
  output logic tick
);

logic [$clog2(Timer)-1:0] count;

always_ff @(posedge clk or negedge rst_n) begin
  if(~rst_n) count <= 0;
  else if(count == Timer-1) count <= 0;
  else count <= count + 1;
end

assign tick = (count == Timer-1);

endmodule