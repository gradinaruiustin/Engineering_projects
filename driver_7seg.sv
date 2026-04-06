module driver_7seg #(
  parameter NO_DISPLAYS = 6
)(
  input 	logic 									row,
  input 	logic [$clog2(NO_DISPLAYS)-1:0] 	col,
  output logic [(NO_DISPLAYS*8)-1:0] 		HEX_out
);

logic [7:0] seg_pattern;

always_comb begin
  if(~row) seg_pattern = 8'b10011100;
  else     seg_pattern = 8'b10100011;
end

always_comb begin
  HEX_out = '1;
  HEX_out[8*col +: 8] = seg_pattern;
end

endmodule