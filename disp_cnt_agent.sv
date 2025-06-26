class disp_cnt_agent extends uvm_agent;
  `uvm_component_utils(disp_cnt_agent)
  
  disp_cnt_config disp_cnt_cfg;
  cnt_monitor cnt_monh;
  cnt_driver cnt_drvh;
  cnt_sequencer cnt_seqrh;
 
  function new(string name="disp_cnt_agent",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(!uvm_config_db #(disp_cnt_config)::get(this,"","disp_cnt_cfg",disp_cnt_cfg))
      `uvm_fatal("cnt","cnt_agent_config")
    
      cnt_monh=cnt_monitor::type_id::create("cnt_monh",this);
    if(disp_cnt_cfg.is_active==UVM_ACTIVE)
      begin
        cnt_drvh=cnt_driver::type_id::create("cnt_drvh",this);
        cnt_seqrh=cnt_sequencer::type_id::create("cnt_seqrh",this);
      end
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(disp_cnt_cfg.is_active==UVM_ACTIVE)
      begin
        cnt_drvh.seq_item_port.connect(cnt_seqrh.seq_item_export);
      end
  endfunction

endclass  