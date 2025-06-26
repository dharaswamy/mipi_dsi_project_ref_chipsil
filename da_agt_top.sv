class disp_ahb_top extends uvm_env;
  `uvm_component_utils(disp_ahb_top)
  
  env_config cfg;
  
  disp_ahb_agent disp_ahb_agt[];
  
  disp_ahb_config disp_ahb_cfg[];
  
  function new(string name="disp_ahb_top",uvm_component parent);
    super.new(name,parent);
   endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(env_config)::get(this,"","env_cfg",cfg))
      `uvm_fatal("disp_ahb","disp_ahb_config")
      
    disp_ahb_agt=new[cfg.no_of_disp_ahb];
    disp_ahb_cfg=new[cfg.no_of_disp_ahb];
    
    foreach(disp_ahb_agt[i])
      begin
        disp_ahb_agt[i]=disp_ahb_agent::type_id::create($sformatf("disp_ahb_agt[%0d]",i),this);

        disp_ahb_cfg[i]=disp_ahb_config::type_id::create($sformatf("disp_ahb_cfg[%0d]",i));
        
        disp_ahb_cfg[i]=cfg.disp_ahb_cfg[i];
        uvm_config_db #(disp_ahb_config)::set(this,$sformatf("disp_ahb_agt[%0d]*",i),"disp_ahb_cfg",disp_ahb_cfg[i]);
       
      end
  endfunction

endclass