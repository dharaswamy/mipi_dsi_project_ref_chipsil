class cnt_seq extends uvm_sequence #(cnt_transaction);

  `uvm_object_utils(cnt_seq)
	

  extern function new(string name="cnt_seq");

endclass

function cnt_seq::new(string name="cnt_seq");
  super.new(name);
endfunction
//////////////////////////////////////////////////////////////////

class QQVGA extends cnt_seq;

  `uvm_object_utils(QQVGA)

  
  extern function new(string name="QQVGA");
  extern task body();
endclass

function QQVGA::new(string name="QQVGA");
	super.new(name);
endfunction


task QQVGA::body();
	req=cnt_transaction::type_id::create("req");
	start_item(req);
    `uvm_info("GEN","Data send to Driver", UVM_NONE);  
  assert(req.randomize() with {res==0;no_frames==1;hbp==1;hfp==1;});
    `uvm_info("GEN","Data send to Driver", UVM_NONE);  
	finish_item(req);
  
endtask
      
      
