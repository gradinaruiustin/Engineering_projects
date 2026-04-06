//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
//driverul preia datele de la generator, la nivel abstract, si le trimite DUT-ului conform protocolului de comunicatie pe interfata respectiva
//gets the packet from generator and drive the transaction paket items into interface (interface is connected to DUT, so the items driven into interface signal will get driven in to DUT) 


//se declara macro-ul DRIV_IF care va reprezenta interfata pe care driverul va trimite date DUT-ului
`define INPUT_DRIV_IF input_vif.DRIVER.driver_cb
class input_driver;

  //used to count the number of transactions
  int no_transactions;
  
  //creating virtual interface handle
  virtual interface_in input_vif;
  
  //se creaza portul prin care driverul primeste datele la nivel abstract de la DUT
  //creating mailbox handle
  mailbox gen2driv;
  
  //constructor
  function new(virtual interface_in input_vif,mailbox gen2driv);
    //cand se creaza driverul, interfata pe care acesta trimite datele este conectata la interfata reala a DUT-ului
    //getting the interface
    this.input_vif = input_vif;
    //getting the mailbox handles from  environment 
    this.gen2driv = gen2driv;
  endfunction
  
  //Reset task, Reset the Interface signals to default/initial values
  task reset;
    wait(!input_vif.rst_n);
    $display("--------- [DRIVER] Reset Started ---------");
    `INPUT_DRIV_IF.data_wr_i <= 0; //schimba semnalele
    `INPUT_DRIV_IF.req_wr_i	 <= 0;
    
            
    wait(input_vif.rst_n);
    $display("--------- [DRIVER] Reset Ended ---------");
  endtask
  
  //drives the transaction items to interface signals
  task drive;
      input_transaction trans;
      
    //se asteapta ca modulul sa iasa din reset
    wait(input_vif.rst_n);//linie valabila daca resetul este activ in 0
    //wait(!input_vif.reset);//linie valabila daca resetul este activ in 1
    
    //daca nu are date de la generator, driverul ramane cu executia la linia de mai jos, pana cand primeste respectivele date
      gen2driv.get(trans);
    
    $display("--------- [DRIVER-TRANSFER: %0d] ---------",no_transactions);
    
   repeat(trans.delay) @(posedge input_vif.DRIVER.clk); //cate tact-uri asteapta
    
 
    
    `INPUT_DRIV_IF.req_wr_i <= 1;
    `INPUT_DRIV_IF.data_wr_i <= {trans.addr, trans.data_wr_i};
    
    $display("\t addr  = %0h\t data_wr_i = %0h\t", trans.addr, trans.data_wr_i);
    
  do begin  
  @(posedge input_vif.DRIVER.clk);
end while (!`INPUT_DRIV_IF.ack_wr_o);

`INPUT_DRIV_IF.req_wr_i <= 0;
//@(posedge input_vif.DRIVER.clk);
    
    $display("-----------------------------------------");
    no_transactions++;
    
  endtask
  
    
  //Cele doua fire de executie de mai jos ruleaza in paralel. Dupa ce primul dintre ele se termina al doilea este intrerupt automat. Daca se activeaza reset-ul, nu se mai transmit date. 
  task main;
    forever begin
      fork
        //Thread-1: Waiting for reset
        begin
          wait(!input_vif.rst_n);//linie valabila daca resetul este activ in 0
          //wait(input_vif.reset);//linie valabila daca resetul este activ in 1
        end
        //Thread-2: Calling drive task
        begin
          //transmiterea datelor se face permanent, dar este conditionta de primirea datelor de la monitor.
          forever
            drive();
        end
      join_any //iese cand se termina de executat unul din ele
      disable fork;
        reset();
    end
  endtask
        
endclass
