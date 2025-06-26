class virtual_sequence extends uvm_sequence #(uvm_sequence_item);
`uvm_object_utils(virtual_sequence)

function new(string name="virtual_sequence");
super.new(name);
endfunction

endclass