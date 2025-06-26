class disp_md_top extends uvm_env;
  `uvm_component_utils(disp_md_top)
  
  env_config cfg;
  
  disp_md_agent disp_md_agt[];
  
  disp_md_config disp_md_cfg[];
  
  function new(string name="disp_md_top",uvm_component parent=null);
    super.new(name,parent);
   endfunction
  
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(env_config)::get(this,"","env_cfg",cfg))
      `uvm_fatal("disp_md","disp_md_config")
      
    disp_md_agt=new[cfg.no_of_disp_md];
    disp_md_cfg=new[cfg.no_of_disp_md];
    foreach(disp_md_agt[i])
      begin
        disp_md_agt[i]=disp_md_agent::type_id::create($sformatf("disp_md_agt[%0d]",i),this);

        disp_md_cfg[i]=disp_md_config::type_id::create($sformatf("disp_md_cfg[%0d]",i));
        disp_md_cfg[i]=cfg.disp_md_cfg[i];
        uvm_config_db #(disp_md_config)::set(this,$sformatf("disp_md_agt[%0d]*",i),"disp_md_cfg",disp_md_cfg[i]);
       
      end
  endfunction

endclass