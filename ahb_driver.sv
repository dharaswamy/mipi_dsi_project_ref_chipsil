class ahb_driver extends uvm_driver #(ahb_transaction);
	`uvm_component_utils(ahb_driver)
	virtual disp_ahb_if.ahb_drv_mp daif;
  
	disp_ahb_config ahb_cfg;

	extern function new(string name="ahb_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
    extern task send_to_dut(ahb_transaction ahb_xtn);

endclass



function ahb_driver::new(string name="ahb_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void ahb_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
  if(!uvm_config_db #(disp_ahb_config)::get(this,"","disp_ahb_cfg",ahb_cfg))
    `uvm_fatal("cfg_DRV","cannot get ahb_cfg")

endfunction

function void ahb_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	daif=ahb_cfg.daif;
endfunction


task ahb_driver::run_phase(uvm_phase phase);
   while(daif.ahb_drv_cb.HREADY!==1)
      @(daif.ahb_drv_cb);
    
	forever
	begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
endtask



task ahb_driver::send_to_dut(ahb_transaction ahb_xtn);
  
    daif.ahb_drv_cb.HWRITE<=ahb_xtn.hwrite;
    daif.ahb_drv_cb.HADDR<=ahb_xtn.haddr;
    daif.ahb_drv_cb.HSIZE<=ahb_xtn.hsize;
    daif.ahb_drv_cb.HPROT<=ahb_xtn.hprot;
    daif.ahb_drv_cb.HBURST<=ahb_xtn.hburst;
    daif.ahb_drv_cb.HTRANS<=ahb_xtn.htrans;
  
    @(daif.ahb_drv_cb);
    
   while(daif.ahb_drv_cb.HREADY!==1)
     @(daif.ahb_drv_cb);
      
    daif.ahb_drv_cb.HWDATA<=ahb_xtn.hwdata;
    
 
//`uvm_info("ahb_DRV",$sformatf("printing from ahb_driver \n %s", ahb_xtn.sprint()),UVM_LOW) 
	
	
endtask
