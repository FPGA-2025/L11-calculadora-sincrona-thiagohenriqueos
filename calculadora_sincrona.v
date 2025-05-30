module calculadora_sincrona (
    input wire clk,
    input wire reset,
    input wire [2:0] codigo,
    input wire [7:0] entrada,
    output wire [7:0] saida
);

    wire load_AcReg;
    wire load_SaidaReg;
    wire clr_AcReg;
    wire clr_SaidaReg;
    wire Sel0;
    wire Sel1;

    maquina_mealy controle (
        .clk(clk),
        .reset(reset),
        .codigo(codigo),
        .load_AcReg(load_AcReg),
        .load_SaidaReg(load_SaidaReg),
        .clr_AcReg(clr_AcReg),
        .clr_SaidaReg(clr_SaidaReg),
        .Sel0(Sel0),
        .Sel1(Sel1)
    );

    bloco_operacional datapath (
        .clk(clk),
        .reset(reset),   
        .clr_AcReg(clr_AcReg),
        .clr_SaidaReg(clr_SaidaReg),
        .load_AcReg(load_AcReg),
        .load_SaidaReg(load_SaidaReg),
        .Sel0(Sel0),
        .Sel1(Sel1),
        .entrada(entrada),
        .saida(saida)
    );

endmodule
