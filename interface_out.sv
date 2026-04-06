//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
`ifndef INTERFACE_OUT_SV
`define INTERFACE_OUT_SV

interface interface_out #(int N=4)(input logic clk, reset);
  //declaring the signals
  logic[7:0] data_rd_o[N];
  logic req_rd_i[N];
  logic ack_rd_o[N];
  
  //semnalele din clocking block sunt sincrone cu frontul crescator de ceas
  //driver clocking block
  clocking driver_cb @(posedge clk);
    //semnalele de intrare sunt citite o unitate de timp inainte frontului de ceas, iar semnalele de iesire sunt citite o unitate de timp dupa frontul de ceas; astfel se elimina situatiile in care se fac scrieri sau citiri in acelasi timp
    default input #1 output #1;
    output req_rd_i;
    input data_rd_o;
    input  ack_rd_o;  
  endclocking
  
  //monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input data_rd_o;
    input req_rd_i;
    input ack_rd_o;  
  endclocking
  
  //driver modport
  modport DRIVER  (clocking driver_cb,input clk,reset);
  
  //monitor modport  
  modport MONITOR (clocking monitor_cb,input clk,reset);
  
endinterface
    `endif
