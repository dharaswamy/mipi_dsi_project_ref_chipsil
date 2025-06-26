class cnt_transaction extends uvm_sequence_item;
  `uvm_object_utils(cnt_transaction)
  
  typedef enum{ SAMPLE, QQVGA, QVGA, VGA, SVGA, HD, FULL_HD} resolution;
  rand bit vsync;
  rand bit hsync;
  rand bit data_enable;
  rand bit [23:0] data;
  rand bit [5:0] no_lane;
  rand bit [5:0] no_pixel;
  rand bit [4:0] no_frames;
  rand bit [1:0] hbp;
  rand bit [1:0] hfp;
  rand int p_clk;
  bit [23:0] q[$];
  rand resolution res;
 
  rand bit [23:0] arry[];
  
  rand bit [23:0] temp;
  
  constraint c2{arry.size==no_pixel*no_lane*no_frames;}
  constraint c4{temp==arry.size;}
  constraint c1{data inside {[10:20]};}
  constraint c3{p_clk==5;}
  
  constraint c5{ 
   			 if(res==SAMPLE)
             {		no_lane==8;		
                    no_pixel==10;	}
       		 else if(res==QQVGA)
				{
                    no_lane==120;	
                    no_pixel==160;	}
   			 else if(res==QVGA)
             {	    no_lane==240;	
                    no_pixel==320;	}
			 else if(res==VGA)
				{	no_lane==480;	
                    no_pixel==640;	}
             else if(res==SVGA)
				{	no_lane==600;	
                    no_pixel==800;	}
             else if(res==HD)
				{	no_lane==720;	
                    no_pixel==1280;}
             else if(res==FULL_HD)
             {		no_lane==1080;	
                    no_pixel==1920;}
					}
	
  extern function void do_print(uvm_printer printer);

  extern function new(string name="cnt_transaction");

endclass

function cnt_transaction::new(string name="cnt_transaction");
super.new(name);
endfunction
    
function void cnt_transaction::do_print(uvm_printer printer);
  printer.print_field( "VSYNC",this.vsync,1,UVM_DEC);
  printer.print_field( "HSYNC",this.hsync,1,UVM_DEC);
  printer.print_field( "HBP",this.hbp,2,UVM_DEC);
  printer.print_field( "no_pixel",this.no_pixel,6,UVM_DEC);
  printer.print_field( "no_lane",this.no_lane,3,UVM_DEC);
  printer.print_field( "HFP",this.hfp,2,UVM_DEC);
  printer.print_field( "DATA_ENABLE",this.data_enable,1,UVM_DEC);
  printer.print_field( "DATA",this.data,24,UVM_DEC);	
  printer.print_field( "temp",this.temp,24,UVM_DEC);	
  foreach(arry[i])
    printer.print_field($sformatf("arry[%0d]",i),this.arry[i],24,UVM_HEX);
  foreach(q[i])
    printer.print_field($sformatf("q_data[%0d]",i),this.q[i],24,UVM_HEX);	
endfunction
