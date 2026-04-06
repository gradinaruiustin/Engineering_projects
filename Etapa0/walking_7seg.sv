module walking_7seg (
  input 	logic 		clk,
  input 	logic 		rst_n,
  input 	logic 		tick,
  output logic 		row,
  output logic [2:0] col
);

logic dir;
logic hit_left;
logic hit_right;

assign hit_left  = ((~row) && (col == 3'd5));
assign hit_right = (row && (col == 3'd0));

always_ff @(posedge clk or negedge rst_n) begin
  if(~rst_n) dir <= 1;
  else if(tick)
    if(hit_left) dir <= 0;
    else if(hit_right) dir <= 1;
end

always_ff @(posedge clk or negedge rst_n) begin
  if(~rst_n) row <= 0;
  else if(tick)
    if(hit_left || hit_right) row <= ~row;
end

always_ff @(posedge clk or negedge rst_n) begin
  if(~rst_n) col <= 3'd0;
  else if(tick)
    if(hit_left || hit_right) col <= col;
    else if(dir) col <= col + 1;
    else col <= col - 1;
end

endmodule