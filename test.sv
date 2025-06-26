class test extends uvm_test;
  `uvm_component_utils(test)
  
  function new(string name="test",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  env e;
  env_config cfg;
  
  
  int has_disp_cnt=1;
  int has_disp_md=1;
  int has_disp_ahb=1;
  int has_sb=1;
  
  
  int no_of_disp_cnt=1;
  int no_of_disp_md=1;
  int no_of_disp_ahb=1;
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    e=env::type_id::create("e",this);
   
    cfg=env_config::type_id::create("cfg");
    
    cfg.disp_ahb_cfg=new[no_of_disp_ahb];
    cfg.disp_cnt_cfg=new[no_of_disp_cnt];
    cfg.disp_md_cfg=new[no_of_disp_md];
        
    foreach(cfg.disp_cnt_cfg[i])
      begin
        cfg.disp_cnt_cfg[i]=disp_cnt_config::type_id::create($sformatf("disp_cnt_cfg[%0d]",i));
        
        if(!uvm_config_db #(virtual disp_cnt_if)::get(this,"",$sformatf("dcif[%0d]",i),cfg.disp_cnt_cfg[i].dcif))
          `uvm_fatal("disp_cnt_config","not getting")
           //cfg.disp_cnt_cfg[i].is_active=UVM_ACTIVE;
      end
    
    //cfg.disp_cnt_cfg[0].is_active=UVM_ACTIVE;

    foreach(cfg.disp_md_cfg[i])
      begin
        cfg.disp_md_cfg[i]=disp_md_config::type_id::create($sformatf("disp_md_cfg[%0d]",i));
        
        if(!uvm_config_db #(virtual disp_md_if)::get(this,"",$sformatf("dmif[%0d]",i),cfg.disp_md_cfg[i].dmif))
          `uvm_fatal("disp_md_config","not getting")
    
      end
          
    foreach(cfg.disp_ahb_cfg[i])
      begin
        cfg.disp_ahb_cfg[i]=disp_ahb_config::type_id::create($sformatf("disp_ahb_cfg[%0d]",i));
        
        if(!uvm_config_db #(virtual disp_ahb_if)::get(this,"",$sformatf("daif[%0d]",i),cfg.disp_ahb_cfg[i].daif))
          `uvm_fatal("disp_ahb_config","not getting")
    
      end
      
        
  cfg.has_sb=has_sb;
  cfg.has_disp_cnt=has_disp_cnt;
  cfg.has_disp_md=has_disp_md;
  cfg.has_disp_ahb=has_disp_ahb;
  
  cfg.no_of_disp_cnt=no_of_disp_cnt;
  cfg.no_of_disp_md=no_of_disp_md;
  cfg.no_of_disp_ahb=no_of_disp_ahb;
        
        cfg.disp_cnt_cfg[0].is_active=UVM_ACTIVE;
        cfg.disp_md_cfg[0].is_active=UVM_PASSIVE;
        cfg.disp_ahb_cfg[0].is_active=UVM_ACTIVE;
 
    uvm_config_db#(env_config)::set(this,"*","env_cfg",cfg);
    
  endfunction
        
function void end_of_elaboration_phase(uvm_phase phase);
 uvm_top.print_topology();
endfunction
 
          
endclass
        
class small_res extends test;
  `uvm_component_utils(small_res)


  QQVGA Q;
  ahb_seq1 sq1;

function new(string name="small_res",uvm_component parent);
super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
super.build_phase(phase);
endfunction

task run_phase(uvm_phase phase);
begin
phase.raise_objection(this);
Q=QQVGA::type_id::create("Q");
sq1=ahb_seq1::type_id::create("sq1");
fork
Q.start(e.dc_a_t.disp_cnt_agt[0].cnt_seqrh);
sq1.start(e.da_a_t.disp_ahb_agt[0].ahb_seqrh);

join
#2000;
phase.drop_objection(this);
end
endtask

endclass
