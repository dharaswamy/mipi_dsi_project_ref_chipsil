interface disp_ahb_if(input bit clk);
 logic HWRITE;
  logic [31:0] HWDATA;
  logic [31:0] HADDR;
  logic [2:0] HSIZE;
  logic [3:0] HPROT;
  logic [1:0] HRESP;
  logic [2:0] HBURST;
  logic [1:0] HTRANS;
  logic  HREADY;
  
  clocking ahb_drv_cb@(posedge clk);
    default input #1 output #1;
    output HWRITE;
    output HWDATA;
    output HADDR;
    output HPROT;
    output HSIZE;
    output HBURST;
    output HTRANS;
    input  HRESP;
    input  HREADY;
  endclocking
  
  clocking ahb_mon_cb@(posedge clk);
    default input #1 output #1;
    input HWRITE;
    input HWDATA;
    input HADDR;
    input HPROT;
    input HSIZE;
    input HBURST;
    input  HRESP;
    input  HREADY;
    input HTRANS;
  endclocking
  
  modport ahb_drv_mp(clocking ahb_drv_cb);
  modport ahb_mon_mp(clocking ahb_mon_cb);
  
endinterface