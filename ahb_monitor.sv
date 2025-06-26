class ahb_monitor extends uvm_monitor;
   `uvm_component_utils(ahb_monitor)
  
   function new(string name="ahb_monitor",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
endclass 