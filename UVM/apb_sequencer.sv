`include "uvm_macros.svh"
import uvm_pkg::*;
import apb_pkg::*;
`ifndef APB_SEQUENCER_SV
`define APB_SEQUENCER_SV

class apb_sequencer extends uvm_sequencer #(apb_transaction);

  `uvm_component_utils(apb_sequencer)

  function new(string name = "apb_sequencer", uvm_component parent = null);
    super.new(name, parent);
  endfunction

endclass

`endif