class md_driver extends uvm_driver;
   `uvm_component_utils(md_driver)
  
   function new(string name="md_driver",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
endclass 