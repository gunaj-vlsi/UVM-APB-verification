`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

class apb_test extends uvm_test;

  `uvm_component_utils(apb_test)

  apb_env env;

  function new(string name="apb_test",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    env = apb_env::type_id::create("env",this);

  endfunction

  task run_phase(uvm_phase phase);

    apb_sequence seq;

    phase.raise_objection(this);

    seq = apb_sequence::type_id::create("seq");

    `uvm_info("TEST","Starting Sequence",UVM_LOW)

    seq.start(env.agent.seqr);

    repeat(30)
      @(posedge env.agent.drv.vif.PCLK);

    `uvm_info("TEST","Sequence Completed",UVM_LOW)

    phase.drop_objection(this);

  endtask

endclass