module bloco_operacional (
    input wire clk,
    input wire reset,
    input wire clr_AcReg,
    input wire clr_SaidaReg,
    input wire load_AcReg,
    input wire load_SaidaReg,
    input wire Sel0,
    input wire Sel1,
    input wire [7:0] entrada,
    output reg [7:0] saida
);

    reg [7:0] AcReg;
    reg [7:0] SaidaReg;

    always @(posedge clk or posedge reset) begin
            if (reset)
                AcReg <= 8'd0;
            else if (clr_AcReg)
                AcReg <= 8'd0;
            else if (load_AcReg)
                AcReg <= (Sel0 == 1'b0) ? (AcReg + entrada) : (AcReg - entrada);
        end

        always @(posedge clk or posedge reset) begin
            if (reset)
                SaidaReg <= 8'd0;
            else if (clr_SaidaReg)
                SaidaReg <= 8'd0;
            else if (load_SaidaReg)
                SaidaReg <= (Sel1 == 1'b0) ? AcReg : entrada;
        end

    always @(*) begin
        saida = SaidaReg;
    end

endmodule