`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

class apb_driver extends uvm_driver #(apb_transaction);

  `uvm_component_utils(apb_driver)

  virtual apb_if vif;

  function new(string name="apb_driver",
               uvm_component parent=null);
    super.new(name,parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal("NOVIF","Virtual Interface not found")
  endfunction

  task run_phase(uvm_phase phase);

    apb_transaction tr;

    forever begin

      seq_item_port.get_next_item(tr);

      `uvm_info("DRIVER",
        $sformatf("Driving WRITE=%0b ADDR=%0h DATA=%0h",
        tr.PWRITE,tr.PADDR,tr.PWDATA),
        UVM_LOW)

      // Setup Phase
      @(posedge vif.PCLK);

      vif.PSEL    <= 1'b1;
      vif.PENABLE <= 1'b0;
      vif.PWRITE  <= tr.PWRITE;
      vif.PADDR   <= tr.PADDR;
      vif.PWDATA  <= tr.PWDATA;

      // Enable Phase
      @(posedge vif.PCLK);

      vif.PENABLE <= 1'b1;

      // Wait for Ready
      @(posedge vif.PCLK);

      wait(vif.PREADY==1);

      seq_item_port.item_done();

      // Idle State
      @(posedge vif.PCLK);

      vif.PSEL    <= 0;
      vif.PENABLE <= 0;

    end

  endtask

endclass