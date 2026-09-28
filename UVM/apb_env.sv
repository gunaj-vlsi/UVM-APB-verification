`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

class apb_env extends uvm_env;

  `uvm_component_utils(apb_env)

  apb_agent      agent;
  apb_scoreboard sb;
       

  function new(string name="apb_env",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    agent = apb_agent::type_id::create("agent", this);
    sb    = apb_scoreboard::type_id::create("sb", this);
   

  endfunction

  function void connect_phase(uvm_phase phase);

    super.connect_phase(phase);

    // Monitor -> Scoreboard
    agent.mon.mon_ap.connect(sb.sb_port);

   

  endfunction

endclass