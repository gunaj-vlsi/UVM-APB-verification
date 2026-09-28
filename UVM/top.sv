`timescale 1ns/1ps

`include "uvm_macros.svh"

import uvm_pkg::*;
import apb_pkg::*;

module top;

  // APB Interface
  apb_if vif();

  // DUT Instantiation
  apb_slave dut (
      .PCLK    (vif.PCLK),
      .PRESETn (vif.PRESETn),
      .PSEL    (vif.PSEL),
      .PENABLE (vif.PENABLE),
      .PWRITE  (vif.PWRITE),
      .PADDR   (vif.PADDR),
      .PWDATA  (vif.PWDATA),
      .PRDATA  (vif.PRDATA),
      .PREADY  (vif.PREADY)
  );

  // Clock Generation
  initial begin
    vif.PCLK = 0;
  end

  always #5 vif.PCLK = ~vif.PCLK;

  // Reset Generation
  initial begin
    vif.PRESETn = 0;

    // Initialize APB signals
    vif.PSEL    = 0;
    vif.PENABLE = 0;
    vif.PWRITE  = 0;
    vif.PADDR   = 0;
    vif.PWDATA  = 0;

    #20;
    vif.PRESETn = 1;
  end

  // UVM Configuration and Test Start
  initial begin

    uvm_config_db#(virtual apb_if)::set(
      null,
      "*",
      "vif",
      vif
    );

    run_test("apb_test");

  end

endmodule