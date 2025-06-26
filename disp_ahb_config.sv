class disp_ahb_config extends uvm_object;
  
  `uvm_object_utils(disp_ahb_config)
    
  virtual disp_ahb_if daif;
  
  uvm_active_passive_enum is_active=UVM_PASSIVE;
  
  function new(string name="disp_ahb_config");
    super.new(name);
  endfunction
  
endclass