class ahb_seq extends uvm_sequence #(ahb_transaction);

  `uvm_object_utils(ahb_seq)
	

  extern function new(string name="ahb_seq");

endclass

function ahb_seq::new(string name="ahb_seq");
  super.new(name);
endfunction
//////////////////////////////////////////////////////////////////


  
class ahb_seq1 extends ahb_seq;
  `uvm_object_utils(ahb_seq1)
  
  
  function new(string name="ahb_seq1");
    super.new(name);
  endfunction
  
  
  task body();
    
    `uvm_info("AHB","Data send to Driver", UVM_NONE);  
    
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0000;hwdata=='h0000_0000; hwrite==1; htrans==2; hburst==0; hsize==2;})//payload 
    finish_item(req);
    
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0020; hwdata=='h0000_0001; hwrite==1; htrans==2; hburst==0; hsize==2;})//long_packet
    finish_item(req);
    
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0024; hwdata=='h0000_0050; hwrite==1; htrans==2; hburst==0; hsize==2;})//word_count
    finish_item(req);
                               
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0028;hwdata=='h0000_0001; hwrite==1; htrans==2; hburst==0; hsize==2;})//no_of_lane
    finish_item(req);    
    
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_002c;hwdata=='h0000_0003; hwrite==1; htrans==2; hburst==0; hsize==2;})
    finish_item(req);    
                               
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0030;hwdata=='h0000_0003; hwrite==1; htrans==2; hburst==0; hsize==2;})
    finish_item(req);    
    
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0034;hwdata=='h0000_0003; hwrite==1; htrans==2; hburst==0; hsize==2;})
    finish_item(req);   
                             
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_0038;hwdata=='h000_0003; hwrite==1; htrans==2; hburst==0; hsize==2;})
    finish_item(req); 
                               
                              
    req=ahb_transaction::type_id::create("req");
    start_item(req);
    assert(req.randomize with {haddr=='h4000_003C;hwdata=='h0001_0004; hwrite==1; htrans==2; hburst==0; hsize==2;})//18bpp,vedio_mode
    finish_item(req); 
  endtask
  
endclass
