//-------------------------------------------------------------------------
//						www.verificationguide.com 
//-------------------------------------------------------------------------

//aici se declara tipul de data folosit pentru a stoca datele vehiculate intre generator si driver; monitorul, de asemenea, preia datele de pe interfata, le recompune folosind un obiect al acestui tip de data, si numai apoi le proceseaza
class output_transaction;
  // se declara atributele clasei
  // campurile declarate cu cuvantul cheie rand vor primi valori aleatoare
  bit [7:0] data_o;      // Datele capturate de la iesirea DUT-ului
  rand int delay;        // Intarzierea intre cererile de citire
  
  constraint delay_c {delay inside {[1:10]};}
  
  // aceasta functie afiseaza valorile atributelor clasei
  function void post_randomize();
    $display("--------- [Trans-Output] post_randomize ------");
    $display("\t Delay = %0d", delay);
    $display("\t Data = %0d", data_o);
    $display("----------------------------------------------");
  endfunction
  
  // operator de copiere a unui obiect (deep copy)
  function output_transaction do_copy();
    output_transaction trans;
    trans = new();
    trans.data_o = this.data_o;
    trans.delay = this.delay;
    return trans;
  endfunction
endclass
