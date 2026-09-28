`ifndef APB_SCOREBOARD_SV
`define APB_SCOREBOARD_SV

`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

class apb_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(apb_scoreboard)

  // Analysis implementation port
  uvm_analysis_imp #(apb_transaction, apb_scoreboard) sb_port;

  // Reference memory
  bit [31:0] mem [0:255];

  function new(string name = "apb_scoreboard",
               uvm_component parent = null);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    sb_port = new("sb_port", this);

    // Initialize memory
    foreach(mem[i])
      mem[i] = 32'h0;

  endfunction

  // Receives transactions from monitor
  function void write(apb_transaction tr);

    // ---------------- WRITE ----------------
    if(tr.PWRITE) begin

      mem[tr.PADDR] = tr.PWDATA;

      `uvm_info("SCOREBOARD",
        $sformatf("WRITE PASS : ADDR=%0h DATA=%0h",
                  tr.PADDR,
                  tr.PWDATA),
        UVM_LOW)

    end

    // ---------------- READ ----------------
    else begin

      if(mem[tr.PADDR] == tr.PRDATA) begin

        `uvm_info("SCOREBOARD",
          $sformatf("READ PASS : ADDR=%0h DATA=%0h",
                    tr.PADDR,
                    tr.PRDATA),
          UVM_LOW)

      end
      else begin

        `uvm_error("SCOREBOARD",
          $sformatf("READ FAIL : ADDR=%0h Expected=%0h Actual=%0h",
                    tr.PADDR,
                    mem[tr.PADDR],
                    tr.PRDATA))

      end

    end

  endfunction

  function void check_phase(uvm_phase phase);

    `uvm_info("SCOREBOARD",
              "Scoreboard Verification Completed",
              UVM_LOW)

  endfunction

endclass

`endif