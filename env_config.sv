

class env_config extends uvm_object;
`uvm_object_utils(env_config)

  function new(string name="env_config");
    super.new(name);
  endfunction
  
  disp_cnt_config disp_cnt_cfg[];
  disp_md_config disp_md_cfg[];
  disp_ahb_config disp_ahb_cfg[];
  
  int has_sb;
  int has_disp_cnt;
  int has_disp_md;
  int has_disp_ahb;
  
  int no_of_disp_cnt;
  int no_of_disp_md;
  int no_of_disp_ahb;
  
endclass
