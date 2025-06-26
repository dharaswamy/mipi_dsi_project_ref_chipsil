class disp_cnt_config extends uvm_object;
  `uvm_object_utils(disp_cnt_config)
    
  virtual disp_cnt_if dcif;
  
  uvm_active_passive_enum is_active=UVM_PASSIVE;
  
  function new(string name="disp_cnt_config");
    super.new(name);
  endfunction
  
endclass