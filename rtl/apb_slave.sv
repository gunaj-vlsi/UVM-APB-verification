module apb_slave (
    input  logic        PCLK,
    input  logic        PRESETn,
    input  logic        PSEL,
    input  logic        PENABLE,
    input  logic        PWRITE,
    input  logic [7:0]  PADDR,
    input  logic [31:0] PWDATA,
    output logic [31:0] PRDATA,
    output logic        PREADY
);

logic [31:0] mem [0:255];

always_ff @(posedge PCLK or negedge PRESETn)
begin
    if(!PRESETn) begin
        PREADY <= 1'b0;
        PRDATA <= 32'd0;
    end
    else begin
        PREADY <= 1'b1;

        if(PSEL && PENABLE) begin
            if(PWRITE)
                mem[PADDR] <= PWDATA;
            else
                PRDATA <= mem[PADDR];
        end
    end
end

endmodule