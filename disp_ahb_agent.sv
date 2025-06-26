class disp_ahb_agent extends uvm_agent;
  
  `uvm_component_utils(disp_ahb_agent)
  
  disp_ahb_config disp_ahb_cfg;
  ahb_monitor ahb_monh;
  ahb_driver ahb_drvh;
  ahb_sequencer ahb_seqrh;
 
  function new(string name="disp_ahb_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  function void connect_phase (uvm_phase phase);
    if(disp_ahb_cfg.is_active==UVM_ACTIVE)
      begin
        ahb_drvh.seq_item_port.connect(ahb_seqrh.seq_item_export);
      end
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(disp_ahb_config)::get(this,"","disp_ahb_cfg",disp_ahb_cfg))
      `uvm_fatal("ahb","ahb_agent_config")
    
      ahb_monh=ahb_monitor::type_id::create("ahb_monh",this);
    if(disp_ahb_cfg.is_active==UVM_ACTIVE)
      begin
        ahb_drvh=ahb_driver::type_id::create("ahb_drvh",this);
        ahb_seqrh=ahb_sequencer::type_id::create("ahb_seqrh",this);
      end
  endfunction


endclass  