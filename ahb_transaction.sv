class ahb_transaction extends uvm_sequence_item;

  `uvm_object_utils(ahb_transaction)
  
  rand bit  [31:0]	haddr;
  rand bit		hwrite; 
  rand bit  [2:0]	hsize;   
  rand bit  [2:0]	hburst;
  rand bit  [1:0]	htrans;
  rand bit  [31:0]	hwdata;
  rand bit  [3:0]	hprot;
  	   bit  [1:0]	hresp;
  	   bit			hready;
  
  
	
  extern function void do_print(uvm_printer printer);

  extern function new(string name="ahb_transaction");

endclass

function ahb_transaction::new(string name="ahb_transaction");
super.new(name);
endfunction
    
function void ahb_transaction::do_print(uvm_printer printer);
  printer.print_field( "HADDR",this.haddr,32,UVM_HEX);
  printer.print_field( "HWRITE",this.hwrite,1,UVM_DEC);
  printer.print_field( "HSIZE",this.hsize,3,UVM_DEC);
  printer.print_field( "HTRANS",this.htrans,2,UVM_DEC);
  printer.print_field( "HWDATA",this.hwdata,32,UVM_HEX);
  printer.print_field( "HPROT",this.hprot,4,UVM_DEC);
  printer.print_field( "HRESP",this.hresp,2,UVM_DEC);
  printer.print_field( "HREADY",this.hready,1,UVM_DEC);	
endfunction
