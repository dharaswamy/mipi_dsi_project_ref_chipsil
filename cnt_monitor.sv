class cnt_monitor extends uvm_monitor;
   `uvm_component_utils(cnt_monitor)
  
  uvm_analysis_port#(cnt_transaction) cnt_mon;
 // uvm_analysis_port#(bit [23:]) q_mon;
  
  
  bit [23:0] q[$];
  int i=0;
  virtual disp_cnt_if.cnt_mon_mp dcif;
  
  disp_cnt_config cnt_cfg;
  
  
  extern function new(string name="cnt_monitor",uvm_component parent);
  extern function void build_phase (uvm_phase phase);
  extern function void connect_phase (uvm_phase phase);  
  extern task run_phase(uvm_phase phase); 
  extern task collect_data();
  
endclass 
    
    
function cnt_monitor::new(string name="cnt_monitor",uvm_component parent);
super.new(name,parent); 
endfunction

function void cnt_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
    cnt_mon=new("cnt_mon",this);
   // q_mon=new("q_mon",this);
   
  if(!uvm_config_db #(disp_cnt_config)::get(this,"","disp_cnt_cfg",cnt_cfg))
    `uvm_fatal("cnt_mon","cannot get cnt_cfg")
endfunction

function void cnt_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	dcif=cnt_cfg.dcif;
endfunction

task cnt_monitor::run_phase(uvm_phase phase);

  forever
    collect_data();
endtask

task cnt_monitor::collect_data();
 begin
  bit [23:0] val;
  cnt_transaction cnt_mxtn;
  cnt_mxtn=cnt_transaction::type_id::create("cnt_mxtn");
  
   val=dcif.cnt_mon_cb.temp;
   cnt_mxtn.arry=new[val];
   
  
   while(dcif.cnt_mon_cb.DATA_ENABLE!==1)
    @(dcif.cnt_mon_cb);
   
   cnt_mxtn.no_pixel=3;
   
   
   foreach(cnt_mxtn.arry[i])
     begin
        while(dcif.cnt_mon_cb.DATA_ENABLE!==1)
          @(dcif.cnt_mon_cb);
          cnt_mxtn.arry[i]=dcif.cnt_mon_cb.DATA;
          q.push_back(cnt_mxtn.arry[i]);
          @(dcif.cnt_mon_cb);
       
     end
  
   
   
   
      
  // $display("arry=%0p",cnt_mxtn.arry);
      
  
 //`uvm_info("cnt_MON",$sformatf("printing from cnt_monitor \n %s", cnt_mxtn.sprint()),UVM_LOW) 
   // cnt_mon.write(cnt_mxtn);
   // q_mon.write(q[$]);
 end
  
endtask
    

  
 