//-------------------------------------------------------------------------
//				www.verificationguide.com   testbench.sv
//-------------------------------------------------------------------------
//tbench_top or testbench top, this is the top most file, in which DUT(Design Under Test) and Verification environment are connected. 
//-------------------------------------------------------------------------

//including interfcae and testcase files
`include "interface_in.sv"
`include "interface_out.sv"

//-------------------------[NOTE]---------------------------------
//Particular testcase can be run by uncommenting, and commenting the rest
`include "random_test.sv"
//`include "wr_rd_test.sv"
//`include "default_rd_test.sv"
//----------------------------------------------------------------


module testbench;
  
  //clock and reset signal declaration
  bit clk;
  bit rst_n;
  
  //clock generation
  always #5 clk = ~clk;
  
  //reset Generation
  initial begin
    rst_n = 0;
    #15 rst_n =1;
  end
  
  
  //creatinng instance of interface, inorder to connect DUT and testcase
  interface_in intf_in(clk,rst_n);
  interface_out #(4) intf_out(intf_in.clk,intf_in.rst_n);
  
  //Testcase instance, interface handle is passed to test as an argument
  test t1(intf_in, intf_out);
  
  //DUT instance, interface signals are connected to the DUT ports
 switch #(
    .DATA_WIDTH(8),
    .DEPTH(6)
) DUT (
  .clk        (intf_in.clk),
  .rst_n      (intf_in.rst_n),

  .req_wr_i   (intf_in.req_wr_i),
  .data_wr_i  (intf_in.data_wr_i),
  .ack_wr_o   (intf_in.ack_wr_o),

   .req_rd_i   ({intf_out.req_rd_i[3], intf_out.req_rd_i[2], intf_out.req_rd_i[1], intf_out.req_rd_i[0]}),
   .data_rd_o  ({intf_out.data_rd_o[3], intf_out.data_rd_o[2], intf_out.data_rd_o[1], intf_out.data_rd_o[0]}),
   .ack_rd_o   ({intf_out.ack_rd_o[3], intf_out.ack_rd_o[2], intf_out.ack_rd_o[1], intf_out.ack_rd_o[0]})
);
  
  //enabling the wave dump
  initial begin 
    $dumpfile("dump.vcd"); $dumpvars;
  end
endmodule
