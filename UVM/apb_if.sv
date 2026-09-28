interface apb_if;

    logic PCLK;
    logic PRESETn;
    logic PSEL;
    logic PENABLE;
    logic PWRITE;
    logic [7:0] PADDR;
    logic [31:0] PWDATA;
    logic [31:0] PRDATA;
    logic PREADY;

    
    // APB Assertions
    
    // Assertion 1:
    // PENABLE should only be HIGH when PSEL is HIGH
    property p_enable_after_psel;
        @(posedge PCLK)
        PENABLE |-> PSEL;
    endproperty

    ASSERT_ENABLE_AFTER_PSEL:
    assert property(p_enable_after_psel)
    else
        $error("APB ASSERTION FAILED : PENABLE asserted without PSEL");


    // Assertion 2:
    // PREADY should not be HIGH during reset
    property p_ready_reset;
        @(posedge PCLK)
        !PRESETn |-> !PREADY;
    endproperty

    ASSERT_READY_RESET:
    assert property(p_ready_reset)
    else
        $error("APB ASSERTION FAILED : PREADY HIGH during RESET");


    // Assertion 3:
    // Address should remain stable during transfer
    property p_addr_stable;
        @(posedge PCLK)
        (PSEL && PENABLE) |-> $stable(PADDR);
    endproperty

    ASSERT_ADDR_STABLE:
    assert property(p_addr_stable)
    else
        $error("APB ASSERTION FAILED : Address changed during transfer");

endinterface