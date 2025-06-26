class disp_md_agent extends uvm_agent;
  `uvm_component_utils(disp_md_agent)
  
  disp_md_config disp_md_cfg;
  md_monitor md_monh;
  md_driver md_drvh;
  md_sequencer md_seqrh;
 
  function new(string name="disp_md_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(disp_md_config)::get(this,"","disp_md_cfg",disp_md_cfg))
      `uvm_fatal("md","md_agent_config")
    
      md_monh=md_monitor::type_id::create("md_monh",this);
    if(disp_md_cfg.is_active==UVM_ACTIVE)
      begin
        md_drvh=md_driver::type_id::create("md_drvh",this);
        md_seqrh=md_sequencer::type_id::create("md_seqrh",this);
      end
  endfunction

endclass  