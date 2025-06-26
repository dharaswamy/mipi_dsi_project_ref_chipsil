class md_transaction extends uvm_sequence_item;

  `uvm_object_utils(md_transaction)
  
  bit [7:0]	ppi_data_lane0;
  bit [7:0]	ppi_data_lane1;
  bit [7:0]	ppi_data_lane2;
  bit [7:0]	ppi_data_lane3;
  bit ppi_lane0_en;
  bit ppi_lane1_en;
  bit ppi_lane2_en;
  bit ppi_lane3_en;
  bit [23:0] data[$];
      
  
   
	
    extern function void do_print(uvm_printer printer);

    extern function new(string name="md_transaction");

endclass

function md_transaction::new(string name="md_transaction");
super.new(name);
endfunction
    
function void md_transaction::do_print(uvm_printer printer);
  printer.print_field( "ppi_data_lane0",this.ppi_data_lane0,8,UVM_HEX);
  printer.print_field( "ppi_data_lane1",this.ppi_data_lane1,8,UVM_HEX);
  printer.print_field( "ppi_data_lane2",this.ppi_data_lane2,8,UVM_HEX);
  printer.print_field( "ppi_data_lane3",this.ppi_data_lane3,8,UVM_HEX);
  
  printer.print_field( "ppi_lane0_en",this.ppi_lane0_en,1,UVM_DEC);
  printer.print_field( "ppi_lane1_en",this.ppi_lane1_en,1,UVM_DEC);
  printer.print_field( "ppi_lane2_en",this.ppi_lane2_en,1,UVM_DEC);
  printer.print_field( "ppi_lane3_en",this.ppi_lane3_en,1,UVM_DEC);
  foreach(data[i])
    printer.print_field($sformatf("data[%0d]",i),this.data[i],24,UVM_HEX);	
  
endfunction
