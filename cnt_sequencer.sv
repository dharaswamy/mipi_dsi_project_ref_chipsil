class cnt_sequencer extends uvm_sequencer#(cnt_transaction);
  `uvm_component_utils(cnt_sequencer)
  
  function new(string name="cnt_sequencer",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
endclass