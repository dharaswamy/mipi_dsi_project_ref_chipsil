class disp_cnt_top extends uvm_env;
  `uvm_component_utils(disp_cnt_top)
  
  env_config cfg;
  
  disp_cnt_agent disp_cnt_agt[];
  
  disp_cnt_config disp_cnt_cfg[];
  
  
   function new(string name="disp_cnt_top",uvm_component parent=null);
    super.new(name,parent);
   endfunction
  
  
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
  
    if(!uvm_config_db #(env_config)::get(this,"","env_cfg",cfg))
      `uvm_fatal("disp_cnt_top","cnt_top_config")
  
     disp_cnt_agt=new[cfg.no_of_disp_cnt];
     disp_cnt_cfg=new[cfg.no_of_disp_cnt];
    foreach(disp_cnt_agt[i])
      begin
        disp_cnt_agt[i]=disp_cnt_agent::type_id::create($sformatf("disp_cnt_agt[%0d]",i),this);
      
        disp_cnt_cfg[i]=disp_cnt_config::type_id::create($sformatf("disp_cnt_cfg[%0d]",i));
        disp_cnt_cfg[i]=cfg.disp_cnt_cfg[i];
        uvm_config_db #(disp_cnt_config)::set(this,$sformatf("disp_cnt_agt[%0d]*",i),"disp_cnt_cfg",disp_cnt_cfg[i]);
          
      end
  endfunction

endclass