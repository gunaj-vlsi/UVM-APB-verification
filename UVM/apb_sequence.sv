`include "uvm_macros.svh"


import uvm_pkg::*;
import apb_pkg::*;

class apb_sequence extends uvm_sequence #(apb_transaction);

  `uvm_object_utils(apb_sequence)

  function new(string name="apb_sequence");
    super.new(name);
  endfunction

  task body();

    apb_transaction tr;

    `uvm_info("SEQ","Sequence Started",UVM_LOW)

    // WRITE 1
    tr = apb_transaction::type_id::create("tr1");
    start_item(tr);
    tr.PWRITE = 1;
    tr.PADDR  = 8'h10;
    tr.PWDATA = 32'h12345678;
    finish_item(tr);

    // WRITE 2
    tr = apb_transaction::type_id::create("tr2");
    start_item(tr);
    tr.PWRITE = 1;
    tr.PADDR  = 8'h20;
    tr.PWDATA = 32'hAAAAAAAA;
    finish_item(tr);

    // WRITE 3
    tr = apb_transaction::type_id::create("tr3");
    start_item(tr);
    tr.PWRITE = 1;
    tr.PADDR  = 8'h30;
    tr.PWDATA = 32'h55555555;
    finish_item(tr);

    // READ 1
    tr = apb_transaction::type_id::create("tr4");
    start_item(tr);
    tr.PWRITE = 0;
    tr.PADDR  = 8'h10;
    tr.PWDATA = 32'h0;
    finish_item(tr);

    // READ 2
    tr = apb_transaction::type_id::create("tr5");
    start_item(tr);
    tr.PWRITE = 0;
    tr.PADDR  = 8'h20;
    tr.PWDATA = 32'h0;
    finish_item(tr);

    `uvm_info("SEQ","Sequence Completed",UVM_LOW)

  endtask

endclass