`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_transaction extends uvm_sequence_item;

    rand bit        PWRITE;
    rand bit [7:0]  PADDR;
    rand bit [31:0] PWDATA;  


    bit [31:0] PRDATA;

    `uvm_object_utils(apb_transaction)

    function new(string name = "apb_transaction");
        super.new(name);
    endfunction

endclass