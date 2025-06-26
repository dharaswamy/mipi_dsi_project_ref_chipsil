class disp_md_config extends uvm_object;
  `uvm_object_utils(disp_md_config)
    
  virtual disp_md_if dmif;
  
  uvm_active_passive_enum is_active=UVM_PASSIVE;
  
  function new(string name="disp_md_config");
    super.new(name);
  endfunction
  
endclass