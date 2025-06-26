class cnt_driver extends uvm_driver #(cnt_transaction);
	`uvm_component_utils(cnt_driver)
	virtual disp_cnt_if.cnt_drv_mp dcif;
  
  
  uvm_analysis_port#(cnt_transaction) cnt_drv;
	disp_cnt_config cnt_cfg;

	extern function new(string name="cnt_driver",uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
      extern task send_to_dut(cnt_transaction cnt_xtn);

endclass



function cnt_driver::new(string name="cnt_driver",uvm_component parent);
	super.new(name,parent);
endfunction

function void cnt_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
  cnt_drv=new("drv",this);
  if(!uvm_config_db #(disp_cnt_config)::get(this,"","disp_cnt_cfg",cnt_cfg))
          `uvm_fatal("cnt_DRV","cannot get cnt_cfg")

endfunction

function void cnt_driver::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	dcif=cnt_cfg.dcif;
endfunction


task cnt_driver::run_phase(uvm_phase phase);
    
	forever
	begin
		seq_item_port.get_next_item(req);
		send_to_dut(req);
		seq_item_port.item_done();
	end
endtask



task cnt_driver::send_to_dut(cnt_transaction cnt_xtn);
  begin
   bit [23:0] val=0;
   dcif.cnt_drv_cb.temp<=cnt_xtn.temp;
   dcif.cnt_drv_cb.no_pixel<=cnt_xtn.no_pixel;
   repeat(cnt_xtn.no_frames)
   begin
    @(dcif.cnt_drv_cb);
	dcif.cnt_drv_cb.VSYNC<=1;
    @(dcif.cnt_drv_cb);
    repeat(cnt_xtn.no_lane)
      begin
       dcif.cnt_drv_cb.VSYNC<=0;
       dcif.cnt_drv_cb.HSYNC<=1;
       @(dcif.cnt_drv_cb);
       dcif.cnt_drv_cb.HSYNC<=0;
        repeat(cnt_xtn.hbp)
        @(dcif.cnt_drv_cb);
        repeat(cnt_xtn.no_pixel)
         begin
           dcif.cnt_drv_cb.DATA_ENABLE<=1;
           dcif.cnt_drv_cb.DATA<=cnt_xtn.arry[val];
           val++;
           @(dcif.cnt_drv_cb);
         end
          dcif.cnt_drv_cb.DATA_ENABLE<=0;
          dcif.cnt_drv_cb.DATA<=0;
          repeat(cnt_xtn.hfp)
           @(dcif.cnt_drv_cb);      
      end
   end
     
  end
  cnt_drv.write(cnt_xtn);
//`uvm_info("cnt_DRV",$sformatf("printing from cnt_driver \n %s", cnt_xtn.sprint()),UVM_LOW) 
	
	
endtask

