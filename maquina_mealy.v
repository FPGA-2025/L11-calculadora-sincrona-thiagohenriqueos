module maquina_mealy (
    input  wire clk,
    input  wire reset,
    input  wire [2:0] codigo,

    output reg load_AcReg,
    output reg load_SaidaReg,
    output reg clr_AcReg,
    output reg clr_SaidaReg,
    output reg Sel0,
    output reg Sel1
);

parameter EST_RESET             = 3'b000;
parameter EST_MOSTRA_ENTRADA    = 3'b001;
parameter EST_SOMA              = 3'b010;
parameter EST_SUBTRAI           = 3'b011;
parameter EST_MOSTRA_ACUMULADOR = 3'b100;

reg [2:0] estado_atual, proximo_estado;

    always @(posedge clk or posedge reset) begin
        if (reset)
            estado_atual <= EST_RESET;
        else
            estado_atual <= proximo_estado;
    end

    always @(*) begin
        proximo_estado = estado_atual; // default

        case (estado_atual)
            EST_RESET: begin
                if (codigo == 3'b000)
                    proximo_estado = EST_MOSTRA_ENTRADA;
                else if (codigo == 3'b001)
                    proximo_estado = EST_SOMA;
                else if (codigo == 3'b010)
                    proximo_estado = EST_SUBTRAI;
                else if (codigo == 3'b011)
                    proximo_estado = EST_MOSTRA_ACUMULADOR;
            end

            EST_MOSTRA_ENTRADA: begin
                if (codigo == 3'b000)
                    proximo_estado = EST_MOSTRA_ENTRADA;
                else if (codigo == 3'b001)
                    proximo_estado = EST_SOMA;
                else if (codigo == 3'b010)
                    proximo_estado = EST_SUBTRAI;
                else if (codigo == 3'b011)
                    proximo_estado = EST_MOSTRA_ACUMULADOR;
            end

            EST_SOMA: begin
                if (codigo == 3'b000)
                    proximo_estado = EST_MOSTRA_ENTRADA;
            end

            EST_SUBTRAI: begin
                if (codigo == 3'b000)
                    proximo_estado = EST_MOSTRA_ENTRADA;
            end

            EST_MOSTRA_ACUMULADOR: begin
                if (codigo == 3'b000)
                    proximo_estado = EST_MOSTRA_ENTRADA;
            end

            default: proximo_estado = EST_RESET;
        endcase
    end

    // 3º bloco: lógica de saída Mealy
    always @(*) begin
        load_AcReg     = 0;
        load_SaidaReg  = 0;
        clr_AcReg      = 0;
        clr_SaidaReg   = 0;
        Sel0           = 0;
        Sel1           = 0;

        if (estado_atual == EST_RESET) begin
            if (codigo == 3'b000) begin
                load_SaidaReg  = 1;
                Sel1           = 1;
            end else if (codigo == 3'b001) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
            end else if (codigo == 3'b010) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
                Sel0           = 1;
            end else if (codigo == 3'b011) begin
                load_SaidaReg   = 1;
            end 
        end else if (estado_atual == EST_MOSTRA_ENTRADA) begin
            if (codigo == 3'b000) begin
                load_SaidaReg  = 1;
                Sel1           = 1;
            end else if (codigo == 3'b001) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
            end else if (codigo == 3'b010) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
                Sel0           = 1;
            end else if (codigo == 3'b011) begin
                load_SaidaReg   = 1;
            end 
        end else if (estado_atual == EST_SOMA) begin
            if (codigo == 3'b000) begin
                load_SaidaReg  = 1;
                Sel1           = 1;
            end else if (codigo == 3'b001) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
            end else if (codigo == 3'b010) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
                Sel0           = 1;
            end else if (codigo == 3'b011) begin
                load_SaidaReg   = 1;
            end 
        end else if (estado_atual == EST_SUBTRAI) begin
            if (codigo == 3'b000) begin
                load_SaidaReg  = 1;
                Sel1           = 1;
            end else if (codigo == 3'b001) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
            end else if (codigo == 3'b010) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
                Sel0           = 1;
            end else if (codigo == 3'b011) begin
                load_SaidaReg   = 1;
            end 
        end else if (estado_atual == EST_MOSTRA_ACUMULADOR) begin
            if (codigo == 3'b000) begin
                load_SaidaReg  = 1;
                Sel1           = 1;
            end else if (codigo == 3'b001) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
            end else if (codigo == 3'b010) begin
                load_AcReg     = 1;
                clr_SaidaReg   = 1;
                Sel0           = 1;
            end else if (codigo == 3'b011) begin
                load_SaidaReg   = 1;
            end 
        end
    end

endmodule
