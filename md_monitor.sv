class md_monitor extends uvm_monitor;
   `uvm_component_utils(md_monitor)
  
  
   int k=0;
  bit [7:0] q0[$];
  bit [7:0] q1[$];
  bit [7:0] q2[$];
  bit [7:0] q3[$];
  bit [7:0] payload[];
  reg [7:0] sp1[$];
  reg [7:0] sp2[$];
  reg [7:0] sp3[$];
  reg [7:0] lng_l_s[$];
  reg [15:0] wc;
  reg [7:0] data_id;
  reg [7:0] l_ecc;
  bit [3:0] val;
  reg [15:0] crc;
 // bit [23:0] data[$];
  
  uvm_analysis_port#(md_transaction) md_mon;
  int i=0;
  
  //bit [7:0] arr[*];
  virtual disp_md_if.md_mon_mp dmif;

  
   disp_md_config md_cfg;
  

  
  extern function new(string name="md_monitor",uvm_component parent);
  extern function void build_phase (uvm_phase phase);
  extern function void connect_phase (uvm_phase phase);  
  extern task run_phase(uvm_phase phase); 
  extern task collect_data();
  extern task collect_lane0();
  extern task collect_lane0_1();
  extern task collect_lane0_1_2();
  extern task collect_lane0_1_2_3();
  extern task lane0_en();
  extern task lane1_en();
  extern task lane2_en();
  extern task lane3_en();
  
     
endclass 
    
    
function md_monitor::new(string name="md_monitor",uvm_component parent);
super.new(name,parent); 
endfunction

function void md_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
    md_mon=new("md_mon",this);
  if(!uvm_config_db #(disp_md_config)::get(this,"","disp_md_cfg",md_cfg))
    `uvm_fatal("md_mon","cannot get md_cfg")
   
endfunction

function void md_monitor::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	dmif=md_cfg.dmif;
endfunction

task md_monitor::run_phase(uvm_phase phase);
  $display("md ============================================================================================monitor");
 while((dmif.md_mon_cb.PPI_DATA_LANE0 && dmif.md_mon_cb.PPI_DATA_LANE1)!==1)
  @(dmif.md_mon_cb);
  repeat(1)
      collect_data();
    /*forever begin
      fork
        begin
          lane0_en;
        end
        begin
          lane1_en;
        end
        begin
          lane2_en;
        end
        begin
          lane3_en;
        end
      join_any*/
      
endtask
      
/* task md_monitor::lane0_en();
    forever begin
      @(dmif.md_mon_cb);
      if(dmif.md_mon_cb.PPI_LANE0_EN==1)
        break;
    end
  endtask
      
      
 task md_monitor::lane1_en();
    forever begin
      @(dmif.md_mon_cb);
      if(dmif.md_mon_cb.PPI_LANE1_EN==1)
        break;
    end
  endtask
      
      
  task md_monitor::lane2_en();
    forever begin
      @(dmif.md_mon_cb);
      if(dmif.md_mon_cb.PPI_LANE2_EN==1)
        break;
    end
  endtask
      
  task md_monitor::lane3_en();
    forever begin
     @(dmif.md_mon_cb);
      if(dmif.md_mon_cb.PPI_LANE2_EN==1)
        break;
    end
  endtask*/

task md_monitor::collect_data();
  begin
    
    $display("md ==========================ccccccccccccccccccccccccccccccccccccccc==============================monitor");
 // md_transaction md_mxtn;
  //md_mxtn=md_transaction::type_id::create("md_mxtn");
  
  while((dmif.md_mon_cb.PPI_DATA_LANE0 && dmif.md_mon_cb.PPI_DATA_LANE1)!==1)
    @(dmif.md_mon_cb);
    
    $display("md ==========================ccccccccccccccccccccccccccccccccccccccc==============================monitor");
    
    
   // val={dmif.md_mon_cb.PPI_LANE3_EN,dmif.md_mon_cb.PPI_LANE2_EN,dmif.md_mon_cb.PPI_LANE1_EN,dmif.md_mon_cb.PPI_LANE0_EN};
    
    $display("lane value_0=%0d",dmif.md_mon_cb.PPI_LANE0_EN);
    $display("lane value_1=%0d",dmif.md_mon_cb.PPI_LANE1_EN);
    
    if((dmif.md_mon_cb.PPI_LANE0_EN) && ((dmif.md_mon_cb.PPI_LANE1_EN!==1)&&(dmif.md_mon_cb.PPI_LANE2_EN!==1)&&(dmif.md_mon_cb.PPI_LANE3_EN!==1)))
      val=4'b0001;
    else
      if((dmif.md_mon_cb.PPI_LANE0_EN && dmif.md_mon_cb.PPI_LANE1_EN) &&(dmif.md_mon_cb.PPI_LANE2_EN!==1 && dmif.md_mon_cb.PPI_LANE3_EN!==1))
      val=4'b0011;
    else
      if((dmif.md_mon_cb.PPI_LANE0_EN && dmif.md_mon_cb.PPI_LANE1_EN  && dmif.md_mon_cb.PPI_LANE2_EN) && (dmif.md_mon_cb.PPI_LANE3_EN!==1))
       val=4'b0111;
    else
      if(dmif.md_mon_cb.PPI_LANE0_EN && dmif.md_mon_cb.PPI_LANE1_EN && dmif.md_mon_cb.PPI_LANE2_EN && dmif.md_mon_cb.PPI_LANE3_EN )
       val=4'b1111;
    
    
    $display("val=%0b",val);
  
    //casex({dmif.md_mon_cb.PPI_LANE0_EN,dmif.md_mon_cb.PPI_LANE1_EN,dmif.md_mon_cb.PPI_LANE2_EN,dmif.md_mon_cb.PPI_LANE3_EN})
    case(val)
      4'b0001:begin
        $display("md ==========collect_laneo-------------monitor");
        collect_lane0();
      end
      4'b0011:begin
        $display("md ==========collect_laneo and 1-------------monitor");
        collect_lane0_1();
      end
       4'b0111:begin
        collect_lane0_1_2();
      end
       4'b1111:begin
        collect_lane0_1_2_3();
      end
    endcase
          
 //`uvm_info("md_MON",$sformatf("printing from md_monitor \n %s", md_mxtn.sprint()),UVM_LOW) 
  end
  

 
  //$display("arry=%0p",arr);
endtask
    

task md_monitor::collect_lane0();
forever
  begin
    q0.push_back(dmif.md_mon_cb.PPI_DATA_LANE0);
     @(dmif.md_mon_cb);
    if(dmif.md_mon_cb.PPI_LANE0_EN==0)
       break;
  end
endtask

    
task md_monitor::collect_lane0_1();
   md_transaction md_mxtn;
   md_mxtn=md_transaction::type_id::create("md_mxtn");
begin
  $display("disp playing from collect_1");
  
forever
  begin
    q0.push_back(dmif.md_mon_cb.PPI_DATA_LANE0);
    q1.push_back(dmif.md_mon_cb.PPI_DATA_LANE1);
    $display("value of lane0=%0h",dmif.md_mon_cb.PPI_DATA_LANE0);
    $display("value of lane1=%0h",dmif.md_mon_cb.PPI_DATA_LANE1);
     @(dmif.md_mon_cb);
    if(dmif.md_mon_cb.PPI_LANE0_EN==0 && dmif.md_mon_cb.PPI_LANE1_EN==0)
      begin
        $display("after-------breaking------------------- collect_1");
       break;
      end
   end
  
  
    
  for(int i=0;i<8;i=i+2)
    begin
      sp1[i]=q0.pop_front();
      sp1[i+1]=q1.pop_front();
    end
    
  for(int i=0;i<8;i=i+2)
    begin
      sp2[i]=q0.pop_front();
      sp2[i+1]=q1.pop_front();
    end
  
     
  for(int i=0;i<8;i=i+2)
    begin
      sp3[i]=q0.pop_front();
      sp3[i+1]=q1.pop_front();
    end
    
   for(int i=0;i<2;i=i+2)
     begin
       lng_l_s[i]=q0.pop_front();
       lng_l_s[i+1]=q1.pop_front();
     end
    
    for(int i=0;i<2;i=i+2) 
      begin
        data_id=q0.pop_front();
        wc[7:0]=q1.pop_front();
      end
    
    for(int i=0;i<2;i=i+2)
      begin
        wc[15:8]=q0.pop_front();
        l_ecc=q1.pop_front();
      end
        wc=wc-16;
  
  
      payload =new[wc];
      for(int i=0;i<wc;i=i+2)
      begin
        payload[i]   = q0.pop_front();
        payload[i+1] = q1.pop_front();
      end
  
      
    for(int i=0;i<2;i=i+2) 
      begin
        crc[7:0]=q0.pop_front();
        crc[15:8]=q1.pop_front();
      end
  
   for(int i=0;i<8;i++)
    begin
      md_mxtn.data[i]={payload[k+2],payload[k+1],payload[k]};
     // $display("the value of the ppi monitor have take the value  data[%0d]=%0h",i,md_mxtn.data[i]);
      k=k+3;
    end
  
 /* for(int i=0;i<24;i+=3) begin 
      data[k]={payload[i+2],payload[i+1],payload[i]};
     $display("the value of the ppi monitor have take the value  q[%0d]=%0h",k,data[k]);
      k++;
    end*/
  
 /*data[0]={payload[2],payload[1],payload[0]};
  data[1]={payload[5],payload[4],payload[3]};
  data[2]={payload[8],payload[7],payload[6]};
  data[3]={payload[8],payload[7],payload[6]};
  data[4]={payload[8],payload[7],payload[6]};
  data[5]={payload[8],payload[7],payload[6]};
  data[6]={payload[8],payload[7],payload[6]};
  data[7]={payload[8],payload[7],payload[6]};*/
    
      
  
  
  
     $display("size=%0d",payload.size);
    
    $displayh("sp1=%0p",sp1);
    $displayh("sp2=%0p",sp2);
    $displayh("sp3=%0p",sp3);
    $displayh("lng=%0p",lng_l_s);
    
    $displayh("data_id=%0p",data_id);
    $display("wc=%0d",wc);
    $displayh("ecc=%0p",l_ecc);
    $displayh("payload=%0p",payload);
    $displayh("crc=%0p",crc);
  
    //$displayh("pixel sending data=%0p",data);
  
//  `uvm_info("md_mon",$sformatf("printing from scoreboard \n %s", md_mxtn.sprint()),UVM_LOW) 
  md_mon.write(md_mxtn);
    
  
end  
endtask

task md_monitor::collect_lane0_1_2();

endtask
    
task md_monitor::collect_lane0_1_2_3();

endtask
    
    
    

  
 