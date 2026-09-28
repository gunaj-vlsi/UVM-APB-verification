`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

class apb_monitor extends uvm_monitor;

  `uvm_component_utils(apb_monitor)

  virtual apb_if vif;

  // Analysis port
  uvm_analysis_port #(apb_transaction) mon_ap;

  function new(string name="apb_monitor",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);

    super.build_phase(phase);

    if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal("NOVIF","Virtual Interface not found")

    mon_ap = new("mon_ap", this);

  endfunction

  task run_phase(uvm_phase phase);

    apb_transaction tr;

    forever begin

      @(posedge vif.PCLK);

     if(vif.PSEL && vif.PENABLE && vif.PREADY) begin

    // Wait one delta cycle so PRDATA gets updated
    #1;

    tr = apb_transaction::type_id::create("tr");

    tr.PWRITE = vif.PWRITE;
    tr.PADDR  = vif.PADDR;
    tr.PWDATA = vif.PWDATA;
    tr.PRDATA = vif.PRDATA;

    mon_ap.write(tr);

        `uvm_info("MONITOR",
          $sformatf("WRITE=%0b ADDR=%0h DATA=%0h READY=%0b",
                    tr.PWRITE,
                    tr.PADDR,
                    tr.PWDATA,
                    vif.PREADY),
          UVM_LOW)

      end

    end

  endtask

endclass