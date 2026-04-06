//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------

//in mediul de verificare se instantiaza toate componentele de verificare
`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV


`include "input_transaction.sv"
`include "output_transaction.sv"

`include "input_generator.sv"
`include "output_generator.sv"

`include "input_driver.sv"
`include "output_driver.sv"

`include "input_monitor.sv"
`include "output_monitor.sv"

`include "coverage.sv"
//`include "scoreboard.sv"

class environment;
  
  input_generator  gen_i;
  output_generator gen_o[4];
  
  input_driver     driv_i;
  output_driver    driv_o[4];
  
  input_monitor		mon_i;
  output_monitor 	mon_o[4];

  mailbox gen2driv;      
  mailbox gen2driv_o[4];
  
  mailbox mon2scb;
  mailbox mon2scb_o [4];
  
  event gen_ended;
  event gen_ended_o[4];
  
  virtual interface_in    	intf_in;
  virtual interface_out 	intf_out;
  
  function new(virtual interface_in intf_in, virtual interface_out intf_out);

  this.intf_in  = intf_in;
  this.intf_out = intf_out;

  gen2driv = new();
  mon2scb  = new();

  gen_i  = new(gen2driv, gen_ended);
  driv_i = new(intf_in, gen2driv);
  mon_i	 = new(intf_in, mon2scb);

  for (int i = 0; i < 4; i++) begin
    gen2driv_o[i] = new();

    gen_o[i]  = new(gen2driv_o[i], gen_ended_o[i]);
    driv_o[i] = new(intf_out, gen2driv_o[i], i);
    mon_o[i]  = new(intf_out, mon2scb, i);
  end

endfunction
  task pre_test();
    fork
    driv_i.reset();
      //de adugat apelul functiei reset pentru celelalte drivere
    join
  endtask
  
  task test();
    fork
      gen_i.main();
      driv_i.main();
      begin
        for (int i = 0; i < 4; i++) begin
          fork
            automatic int idx = i;
            gen_o[idx].main();
            driv_o[idx].main();
          join_none
        end
      end
    join_any
  endtask
  
  task post_test();
    wait(gen_ended.triggered);
    wait(gen_i.repeat_count == driv_i.no_transactions);
  endtask
  
  task run;
    pre_test();
    test();
   //post_test();
    #2000ns;
    $finish;
  endtask

endclass

`endif
