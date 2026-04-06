//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------
//monitorul urmareste traficul de pe interfetele DUT-ului, preia datele verificate si recompune tranzactiile (folosind obiecte ale clasei transaction); in implementarea de fata, datele preluate de pe interfete sunt trimise scoreboardului pentru verificare
//Samples the interface signals, captures into transaction packet and send the packet to scoreboard.

//in macro-ul MON_IF se retine blocul de semnale de unde monitorul extrage datele
`define OUTPUT_MON_IF output_vif.MONITOR.monitor_cb

class output_monitor;
  
  //creating virtual interface handle
  virtual interface_out output_vif;
  
  //se creaza portul prin care monitorul trimite scoreboardului datele colectate de pe interfata DUT-ului sub forma de tranzactii 
  //creating mailbox handle
  mailbox mon2scb;
  
  //identificatorul canalului monitorizat (0, 1, 2 sau 3)
  int ch_index;
  
  //constructor
  function new(virtual interface_out output_vif, mailbox mon2scb, int ch_index);
    //getting the interface
    this.output_vif  = output_vif;
    //getting the mailbox handles from environment 
    this.mon2scb  = mon2scb;
    this.ch_index = ch_index;
  endfunction
  
  //Samples the interface signal and send the sample packet to scoreboard
  task main;
    forever begin
      //se declara si se creaza obiectul de tip tranzactie care va contine datele preluate de pe interfata
      output_transaction trans;
      trans = new();

      //datele sunt citite pe frontul de ceas, informatiile preluate de pe semnale fiind retinute in oboiectul de tip tranzactie
      while(`OUTPUT_MON_IF.req_rd_i[ch_index] == 0)begin
      @(posedge output_vif.MONITOR.clk);
        //incrementez delayul din tranzactie
        trans.delay++;
      end
     
        
      
      // Protocol Request-Acknowledge: Transferul are loc cand REQ si ACK sunt ambele 1
      wait( `OUTPUT_MON_IF.ack_rd_o[ch_index] == 1);
      
        // Capturam datele de 8 biti (fara adresa, aceasta a fost eliminata de DUT)
        trans.data_o = `OUTPUT_MON_IF.data_rd_o[ch_index];
        
      $display("[MONITOR OUTPUT CH%0d] Date capturate = %0h", ch_index, trans.data_o);
          
      // dupa ce s-au retinut informatiile referitoare la o tranzactie, continutul obiectului trans se trimite catre scoreboard
        mon2scb.put(trans);
      end
  endtask
  
endclass
