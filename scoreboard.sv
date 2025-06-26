class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
  
  uvm_tlm_analysis_fifo#(cnt_transaction) cnt_mon_1;
  uvm_tlm_analysis_fifo#(md_transaction) md_mon_1;
  
  
  extern function new(string name="scoreboard",uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
    extern task compare();
    cnt_transaction cnt_sco_xtn;
    md_transaction md_sco_xtn;
    
      int k=0;
      bit [23:0] temp [$];
    
endclass
  
function scoreboard::new(string name="scoreboard",uvm_component parent=null);
super.new(name,parent);
endfunction
      
  

function void scoreboard::build_phase(uvm_phase phase);
  super.build_phase(phase);
  cnt_mon_1=new("cnt_mon_1",this);
  md_mon_1=new("md_mon_1",this);

endfunction
    
task scoreboard::run_phase(uvm_phase phase);
  forever
    begin
      $display("collnj0000000000000000000000000000000000000000000000000000000000000000000000000000000000000eeeeeeevls");
      
      cnt_mon_1.get(cnt_sco_xtn);
      md_mon_1.get(md_sco_xtn);
      
       compare();
      `uvm_info("sco",$sformatf("printing from scoreboard \n %s", md_sco_xtn.sprint()),UVM_LOW) 
      `uvm_info("sco",$sformatf("printing from scoreboard \n %s", cnt_sco_xtn.sprint()),UVM_LOW) 
    
    end
 
      
endtask
    
task scoreboard::compare();
  for(int i=0;i<cnt_sco_xtn.no_pixel;i++)
   begin
     temp.push_back(cnt_sco_xtn.arry[i]);
    end
  
  
  if(temp==md_sco_xtn.data)
    $display(" data pixel match");
  else
    $display(" data pixel not match");
  
  
  
endtask
    

    
   
