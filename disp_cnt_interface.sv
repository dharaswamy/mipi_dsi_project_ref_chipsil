interface disp_cnt_if(input bit clk,input bit rst);
  logic VSYNC;
  logic HSYNC;
  logic DATA_ENABLE;
  logic [23:0] DATA;
  logic [23:0] temp;
  logic [5:0] no_pixel;

  
  clocking cnt_drv_cb@(posedge clk);
    default input #1 output #1;
    output VSYNC;
    output HSYNC;
    output DATA_ENABLE;
    output DATA;
    output temp;
    output no_pixel;
 
  endclocking
  
  clocking cnt_mon_cb@(posedge clk);
    default input #1 output #1;
    input VSYNC;
    input HSYNC;
    input DATA_ENABLE;
    input DATA;
    input temp;
    input no_pixel;

  endclocking
  
  modport cnt_drv_mp(clocking cnt_drv_cb);
    modport cnt_mon_mp(clocking cnt_mon_cb);
  
endinterface