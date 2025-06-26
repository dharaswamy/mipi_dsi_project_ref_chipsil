class md_sequencer extends uvm_sequencer;
  `uvm_component_utils(md_sequencer)
  
  function new(string name="md_sequencer",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
endclass