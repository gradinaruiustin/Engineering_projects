//-------------------------------------------------------------------------
// interface.sv - Interfata de INTRARE (Scriere)
//-------------------------------------------------------------------------
`ifndef INTERFACE_IN_SV
`define INTERFACE_IN_SV

interface interface_in(input logic clk, rst_n);
  
  // Semnalele de intrare (1 canal)
  logic       req_wr_i;   // Indica cererea unei noi scrieri
  logic [9:0] data_wr_i;  // Pachetul de date (2 biți adresa + 8 biți date)
  logic       ack_wr_o;   // Confirma ca datele se afla in memorie
  
  // driver clocking block
  clocking driver_cb @(posedge clk);
    default input #1 output #1;
    output req_wr_i;
    output data_wr_i;
    input  ack_wr_o;
  endclocking
  
  // monitor clocking block
  clocking monitor_cb @(posedge clk);
    default input #1 output #1;
    input req_wr_i;
    input data_wr_i;
    input ack_wr_o;
  endclocking
  
  modport DRIVER  (clocking driver_cb, input clk, rst_n);
  modport MONITOR (clocking monitor_cb, input clk, rst_n);
    
//Asertii
    /*
  // Presupunem ca reset este activ high și rst_n este activ low
  wire rst_active = (!rst_n);

  property p_req_no_xz;
    @(posedge clk) disable iff (rst_active)
    !$isunknown(req_wr_i);
  endproperty
  assert_req_no_xz: assert property(p_req_no_xz) 
    else $error("req_wr_i are valoarea X sau Z");

  property p_ack_no_xz;
    @(posedge clk) disable iff (rst_active)
    !$isunknown(ack_wr_o);
  endproperty
  assert_ack_no_xz: assert property(p_ack_no_xz) 
    else $error("ack_wr_o are valoarea X sau Z");


  property p_data_valid_on_req;
    @(posedge clk) disable iff (rst_active)
    req_wr_i |-> !$isunknown(data_wr_i);
  endproperty
  assert_data_valid_on_req: assert property(p_data_valid_on_req)
    else $error("data_wr_i contine valori X sau Z in timpul requestului!");
//////////
    
  property p_req_ack_handshake;
    @(posedge clk) disable iff (rst_active)
    (req_wr_i && ack_wr_o) |=> ~ack_wr_o;
  endproperty
  assert_req_ack_handshake: assert property(p_req_ack_handshake)
    else $error("ack_wr_o nu s a resetat dupa completarea tranzactiei");

  property p_data_stable_until_ack;
    @(posedge clk) disable iff (rst_active)
    (req_wr_i && !ack_wr_o) |-> $stable(data_wr_i) && $stable(req_wr_i);
  endproperty
  assert_data_stable_until_ack: assert property(p_data_stable_until_ack)
    else $error("datele sau request ul s au schimbat inainte de a primi ACK");
    
//eroare de dut req 0 si ack 1
    //daca req e 0 si acum e 1 ; ack 0
    property p_new_req_ack_is_zero;
      @(posedge clk) disable iff (rst_active)
      $rose(req_wr_i) |->!ack_wr_o;
    endproperty
    assert_new_req_ack_is_zero: assert property(p_new_req_ack_is_zero)
      else $error("La inceperea unui request nou (req din 0 in 1), ack este deja 1!");
    
    property p_no_ack_without_req;
      @(posedge clk) disable iff (rst_active)
    !req_wr_i |->!ack_wr_o;
    endproperty
      assert_no_ack_without_req: assert property(p_no_ack_without_req)
        else $error("ack_wr_o este activ (1) in timp ce req_wr_i este inactiv (0)!");
    
//cand coboara req sa coboare si ack 
//cand coboara ack sa fie si Req 0 
//$fell(valid)|->$past(req ==1)

property p_req_to_ack;
  @(posedge clk) disable iff (rst_active)
  $rose(req_wr_i) |-> ##[1:10] $rose(ack_wr_o);
endproperty
assert_req_to_ack: assert property(p_req_to_ack)
  else $error("req a urcat, dar ack nu a raspuns in decurs de 10 cicluri!");
  

property p_req_stable;
  @(posedge clk) disable iff (rst_active)
  (req_wr_i && !ack_wr_o) |=> req_wr_i;
endproperty
assert_req_stable: assert property(p_req_stable)
  else $error("req a coborat la 0 inainte de a primi ack");
  

property p_no_spurious_ack;
  @(posedge clk) disable iff (rst_active)
  $rose(ack_wr_o) |-> req_wr_i; 
endproperty
assert_no_spurious_ack: assert property(p_no_spurious_ack)
  else $error("ack a urcat, dar nu exista niciun 'req' activ!");
  */
endinterface
  `endif
