//-------------------------------------------------------------------------
//						www.verificationguide.com 
//-------------------------------------------------------------------------

//aici se declara tipul de data folosit pentru a stoca datele vehiculate intre generator si driver; monitorul, de asemenea, preia datele de pe interfata, le recompune folosind un obiect al acestui tip de data, si numai apoi le proceseaza
class input_transaction;
  //se declara atributele clasei
  //campurile declarate cu cuvantul cheie rand vor primi valori aleatoare la aplicarea functiei randomize()
  rand bit [1:0] addr;
  // rand bit [1:0] req_wr_i; sters de Dinu
   rand bit [7:0] data_wr_i;
   rand int delay;
  
  constraint delay_c{delay>=0;delay <=10;}; 
  
  //constrangerile reprezinta un tip de membru al claselor din SystemVerilog, pe langa atribute si metode
  //aceasta constrangere specifica faptul ca se executa fie o scriere, fie o citire
  //constrangerile sunt aplicate de catre compilator atunci cand atributele clasei primesc valori aleatoare in urma folosirii functiei randomize
  
  
  //aceasta functie este apelata dupa aplicarea functiei randomize() asupra obiectelor apartinand acestei clase
  //aceasta functie afiseaza valorile aleatorizate ale atributelor clasei
  function void post_randomize();
    $display("--------- [Trans] post_randomize ------");
    //$display("\t addr  = %0h",addr);
    $display(" \t addr  = %0h\t data_wr_i = %0h\t delay=%0h/t" , addr, data_wr_i, delay);
   
    $display("-----------------------------------------");
  endfunction
  
  //operator de copiere a unui obiect intr-un alt obiect (deep copy)
  function input_transaction do_copy();
    input_transaction trans;
    trans = new();
    trans.addr  = this.addr;
    trans.data_wr_i = this.data_wr_i;
    trans.delay = this.delay;
    return trans;
  endfunction
endclass
