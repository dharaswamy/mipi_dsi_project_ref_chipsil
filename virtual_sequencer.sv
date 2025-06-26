class virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

    `uvm_component_utils(virtual_sequencer)

    cnt_sequencer cnt_seqrh[];

    env_config m_cfg;

    extern function new(string name = "virtual_sequencer" , uvm_component parent);
    extern function void build_phase(uvm_phase phase);

endclass

function virtual_sequencer::new(string name = "virtual_sequencer" , uvm_component parent);
	super.new(name,parent);
endfunction

function void virtual_sequencer::build_phase(uvm_phase phase);
	if(!uvm_config_db #(env_config)::get(this,"","env_config",m_cfg))
	    `uvm_fatal("CONFIG","Cannot get() from m_cfg, have you set()it?")

	super.build_phase(phase);

	ahb_seqrh = new[m_cfg.no_of_master];

endfunction