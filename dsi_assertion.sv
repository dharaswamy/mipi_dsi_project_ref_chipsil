module dsi_Assertion (
  input bit pixel_clk, 
  input bit rst, 
  input bit VSYNC_plus, 
  input bit  HSYNC_plus, 
  input bit DATA_ENB, 
  input bit  VSYNC, 
  input bit  HSYNC, 
  input int DATA
);
  
   sequence seq1;
    rst ##1 VSYNC_plus && HSYNC_plus && DATA_ENB && VSYNC && HSYNC && DATA ;
   endsequence 
 
  property reset;
    @(posedge pixel_clk) disable iff(rst)  rst |-> seq1;
  endproperty

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>vsync>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  
  
  sequence seq2;
    $fell(VSYNC) |-> throughout(HSYNC);
    endsequence
  property call_vsyn;
    @(posedge pixel_clk) $rose (VSYNC) [*4] |-> (VSYNC_plus[*3] && $fell(VSYNC));
  endproperty

  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>hsync>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  property call_hsy;
    @(posedge pixel_clk) 
    ($fell(VSYNC) ##4 (!VBP)[*4]  |=> if((HSYNC) [*4])
      (HSYNC_plus[*3])
      else if (!HSYNC_plus)
        (##6(!HBP) && data_p)
        else (HSYNC_plus==0)
          else(HSYNC==0);
       
         endproperty
  //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>data>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  property data_p;
    @(posedge pixel_clk) disable iff(!rst) ##1 $rose(DATA_ENB) |-> (DATA);
  endproperty
  //#################################################################

 
  

  assert property(reset)
    $info("reset********** SUCCESSFULL");
  else
    $info("reset ^^^^^^^^^ IS FAILED");
  assert property(call_vsyn)
    $info("vsync ****************SUCCESSFULL");
  else
    $info("vsync************** FAILED");
  assert property(call_hsy)
    $info("hsync*************** SUCCESSFULL");
  else
    $info("hsync ^^^^^^^^^^^^^^^^^^^ FAILED");
  assert property(data_p)
    $info("data******************** SUCCESSFULL");
  else
    $info("data ********************** FAILED");

endmodule
