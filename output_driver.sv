//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
//driverul preia datele de la generator, la nivel abstract, si le trimite DUT-ului conform protocolului de comunicatie pe interfata respectiva
//gets the packet from generator and drive the transaction paket items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 

//se declara macro-ul DRIV_IF care va reprezenta interfata pe care driverul va trimite date DUT-ului
`define OUTPUT_DRIV_IF output_vif.DRIVER.driver_cb

class output_driver;
  
  //used to count the number of transactions
  int no_transactions;
  
  //identificatorul canalului (0, 1, 2 sau 3)
  int ch_index;

  //creating virtual interface handle
  virtual interface_out output_vif;
  
  //se creaza portul prin care driverul primeste datele la nivel abstract de la generator
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual interface_out output_vif, mailbox gen2driv, int ch_index);
    //cand se creaza driverul, interfata pe care acesta trimite datele este conectata la interfata reala a DUT-ului
    //getting the interface
    this.output_vif  = output_vif;
    //getting the mailbox handles from environment 
    this.gen2driv = gen2driv;
    this.ch_index = ch_index;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(!output_vif.reset);
    $display("--------- [DRIVER OUTPUT CH%0d] Reset Started ---------", ch_index);
    // La iesire, initializam semnalul de confirmare (Acknowledge) pe 0
    `OUTPUT_DRIV_IF.req_rd_i[ch_index] <= 0; 
    wait(output_vif.reset);
    $display("--------- [DRIVER OUTPUT CH%0d] Reset Ended ---------", ch_index);
  endtask
  
  //drives the transaction items to interface signals
  task drive;
      output_transaction trans;
      
      //daca nu are date de la generator, driverul ramane cu executia la linia de mai jos, pana cand primeste respectivele date
      gen2driv.get(trans);
      
      $display("--------- [DRIVER OUTPUT CH%0d-TRANSFER: %0d] ---------", ch_index, no_transactions);
      
    //se intarzie activarea requestului conform campului delay
    // delay configurabil (numar de cicluri de clock)
    repeat(trans.delay) @(posedge output_vif.clk);
    
    // activam request pe canal
    `OUTPUT_DRIV_IF.req_rd_i[ch_index] <= 1;
    
    // asteptam acknowledge de la DUT
    wait(`OUTPUT_DRIV_IF.ack_rd_o[ch_index] == 1);
     
    // sincronizare pe clock dupa ACK
    @(posedge output_vif.DRIVER.clk);
    
    // dezactivam request (REQ trebuie sa fie puls)
    `OUTPUT_DRIV_IF.req_rd_i[ch_index] <= 0;
      
      $display("-------------------------------------------------------");
      no_transactions++;
  endtask
  
  //Cele doua fire de executie de mai jos ruleaza in paralel. Dupa ce primul dintre ele se termina al doilea este intrerupt automat. Daca se activeaza reset-ul, nu se mai transmit date. 
  task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(!output_vif.reset);
        end
        //Thread-2: Calling drive task
        begin
          forever
            drive();
        end
      join_any
      disable fork;
        reset();
    end
  endtask
        
endclass
