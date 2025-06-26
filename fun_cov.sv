class fun_cov extends uvm_subscriber #(cnt_transaction) ;
  `uvm_component_utils(fun_cov)
  uvm_tlm_analysis_fifo #(cnt_transaction) cov_port;
   cnt_transaction cov_xtn,cov_xtn1;
  
  covergroup cg ;
    option.per_instance=1;
    a:coverpoint cov_xtn.hsync{bins cnt_hysnc={0,1};}
    b:coverpoint cov_xtn.vsync{bins cnt_vsync={0,1};}
    c:coverpoint cov_xtn.data_enable{bins cnt_data_enable={0,1};}
    d:coverpoint cov_xtn.hfp{bins cnt_hfp={0,1};}
    e:coverpoint cov_xtn.hbp{bins cnt_hbp={0,1};}
    f:coverpoint cov_xtn.res{bins cnt_reso={0};}
  endgroup
  
  function new(string name = "coverage", uvm_component parent);
    super.new(name, parent);
    this.cg = new();
    
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_port = new("cov_port");
  endfunction
  
  virtual function void write(cnt_transaction t);
  endfunction 

  task run_phase(uvm_phase phase);
    forever 
      begin
        cov_xtn= cnt_transaction::type_id::create("cov_xtn");
       cov_port.get(cov_xtn);
        $display("------------------------------coverageeeeeeeeeeeeeeee-------------------------------");
        cov_xtn.print();
        $display("------------------------------coverageeeeeeeeeeeeeeee-------------------------------");
     // cov_xtn = new cov_xtn1;
      cg.sample();
      $display(".................Coverage model ...............");
        $display("cov_xtn[%0d]=%0d ",cov_xtn);
    end
  endtask
endclass
  