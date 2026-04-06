//-------------------------------------------------------------------------
//						www.verificationguide.com
//-------------------------------------------------------------------------

//tranzactiile din acest text se genereaza complet aleatoriu (singura constrangere fiind in fisierul transaction.sv, aceasta asigurand functionalitatea corecta a DUT-ului)
`include "environment.sv"
program test(interface_in intf_in, interface_out intf_out);
  
  //declaring environment instance
  environment env;
  
  initial begin
    //creating environment
    env = new( intf_in, intf_out);
    
    //setting the repeat count of generator as 4, means to generate 4 packets
    env.gen_i.repeat_count = 100;
    env.gen_o[0].repeat_count = 100;
    env.gen_o[1].repeat_count = 100;
    env.gen_o[2].repeat_count = 100;
    env.gen_o[3].repeat_count = 100;

    
    //calling run of env, it interns calls generator and driver main tasks.
    env.run();
  end
endprogram
