
//eda link : https://edaplayground.com/x/MSJM 

// ( swamy ) please copy the code but don't change/modify the code here.

//======================================================================================================================================
// Project Name: MIPI-DSI PROJECT REFERENCE FROM EDA PLAYGORUND

// language and methodlogy:sv & uvm.
//======================================================================================================================================


module top;
  
  import uvm_pkg::*;
  
  `include "uvm_macros.svh"
  
  
  `include "disp_cnt_interface.sv"
  `include "disp_md_interface.sv"
  `include "disp_ahb_interface.sv"
   
  
   `include "disp_cnt_config.sv"
   `include "disp_md_config.sv" 
   `include "disp_ahb_config.sv" 
   `include "env_config.sv"
   
  
    
   `include "cnt_transaction.sv"
   `include "cnt_sequence.sv"
   `include "cnt_driver.sv" 
   `include "cnt_monitor.sv" 
   `include "cnt_sequencer.sv" 
   `include "disp_cnt_agent.sv"
   `include "dc_agt_top.sv" 
  
  
   `include "md_transaction.sv"
   `include "md_driver.sv" 
   `include "md_monitor.sv" 
   `include "md_sequencer.sv" 
   `include "disp_md_agent.sv" 
   `include "dm_agt_top.sv"
  
  
   `include "ahb_transaction.sv"
   `include "ahb_sequence.sv" 
   `include "ahb_driver.sv" 
   `include "ahb_monitor.sv" 
   `include "ahb_sequencer.sv" 
   `include "disp_ahb_agent.sv"
   `include "da_agt_top.sv"
   
   `include "scoreboard.sv"
  `include "fun_cov.sv"
   `include "env_tb.sv" 
   `include "test.sv" 
    
  
  
  
   bit clock,dsi_rst;
   always #12 clock = !clock;
   bit dsi_clk;

  
  initial 
    begin
      #10 dsi_rst = 1'b0;
       dsi_rst = 1'b1;
    end
  
 
    

    
  disp_cnt_if dcif(clock,dsi_rst);
  disp_md_if dmif(dsi_clk);
  disp_ahb_if daif(clock);

  


  dsi#(8,10) dut(
  .haddr(daif.HADDR),
  .hwrite(daif.HWRITE),
  .hsize(daif.HSIZE),
  .hburst(daif.HBURST),
  .htrans(daif.HTRANS),
  .hwdata(daif.HWDATA),
  .hprot(daif.HPROT),
  .hresp(daif.HRESP),
  .hready(daif.HREADY),
  
  .pixel_data(dcif.DATA),
  .data_valid(dcif.DATA_ENABLE),
  .hsync(dcif.HSYNC),
  .vsync(dcif.VSYNC),
  
    .pclk(clock),
    .dsi_rst(dsi_rst),
    
    .dsi_clk(dsi_clk),
    
  .ppi_data_lane0(dmif.PPI_DATA_LANE0),
  .ppi_data_lane1(dmif.PPI_DATA_LANE1),
  .ppi_data_lane2(dmif.PPI_DATA_LANE2),
  .ppi_data_lane3(dmif.PPI_DATA_LANE3),
  .ppi_lane0_en(dmif.PPI_LANE0_EN),
  .ppi_lane1_en(dmif.PPI_LANE1_EN),
  .ppi_lane2_en(dmif.PPI_LANE2_EN),
  .ppi_lane3_en(dmif.PPI_LANE3_EN)
  );
  
  
           
    
	
  initial begin
  $dumpfile("dump.vcd");
  $dumpvars;
  #10000
  $finish;
  end
  
    initial
      begin
        uvm_config_db#(virtual disp_cnt_if)::set(null,"*","dcif[0]",dcif);
        uvm_config_db#(virtual disp_md_if)::set(null,"*","dmif[0]",dmif);
        uvm_config_db#(virtual disp_ahb_if)::set(null,"*","daif[0]",daif);
        run_test("small_res");
      end
  
endmodule