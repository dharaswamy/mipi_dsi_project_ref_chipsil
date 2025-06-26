interface disp_md_if(input bit ppi_clk);
  logic [7:0]	PPI_DATA_LANE0;
  logic [7:0]	PPI_DATA_LANE1;
  logic [7:0]	PPI_DATA_LANE2;
  logic [7:0]	PPI_DATA_LANE3;
  logic			PPI_LANE0_EN;
  logic 		PPI_LANE1_EN;
  logic			PPI_LANE2_EN;
  logic			PPI_LANE3_EN;
  

  
  clocking md_mon_cb@(posedge ppi_clk);
   default input#1 output#1;
    input 	PPI_DATA_LANE0;
    input 	PPI_DATA_LANE1;
    input 	PPI_DATA_LANE2;
    input 	PPI_DATA_LANE3;
    input	PPI_LANE0_EN;
    input 	PPI_LANE1_EN;
    input	PPI_LANE2_EN;
    input	PPI_LANE3_EN;   
  endclocking
  
  
 // modport md_drv_mp(clocking md_drv_cb);
  modport md_mon_mp(clocking md_mon_cb);
  
endinterface
  