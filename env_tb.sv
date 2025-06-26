class env extends uvm_env;
  
  `uvm_component_utils(env)
    
  env_config cfg;
  
  scoreboard sb;
  disp_cnt_top dc_a_t;
  disp_md_top dm_a_t;
  disp_ahb_top da_a_t;
  fun_cov cov;
  
  function new(string name="env",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
   
  function void build_phase (uvm_phase phase);
    super.build_phase(phase);
    
    cov=fun_cov::type_id::create("cov",this);
   
    if(!uvm_config_db #(env_config)::get(this,"","env_cfg",cfg))
      `uvm_fatal("config env","not getting")
    
    if(cfg.has_sb==1)
      sb=scoreboard::type_id::create("sb",this);
    
    if(cfg.has_disp_cnt==1)
      dc_a_t=disp_cnt_top::type_id::create("dc_a_t",this);
    
    if(cfg.has_disp_md==1)
      dm_a_t=disp_md_top::type_id::create("dm_a_t",this);
    
    if(cfg.has_disp_ahb==1)
      da_a_t=disp_ahb_top::type_id::create("da_a_t",this);
    
  endfunction
  
function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  dc_a_t.disp_cnt_agt[0].cnt_drvh.cnt_drv.connect(sb.cnt_mon_1.analysis_export);
  //dc_a_t.disp_cnt_agt[0].cnt_monh.cnt_q.connect(sb.m_data.analysis_export);
   dc_a_t.disp_cnt_agt[0].cnt_drvh.cnt_drv.connect(cov.cov_port.analysis_export);
  dm_a_t.disp_md_agt[0].md_monh.md_mon.connect(sb.md_mon_1.analysis_export);
endfunction
endclass
