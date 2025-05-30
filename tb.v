module tb();

// Sinais gerais
reg   clk;
reg   rst;
reg   [7:0] entrada;
reg   [2:0] codigo;
wire  [7:0] saida;

reg [11:0] dados_arquivo [0:3];


calculadora_sincrona c(
    .clk(clk),
    .reset(rst),
    .entrada(entrada),
    .codigo(codigo),
    .saida(saida)
);

integer i;

always #1 clk = (clk===1'b0);

initial begin

  $readmemb("teste.txt", dados_arquivo); // le o arquivo de entrada e guarda em dados_arquivo

  $dumpfile("saida.vcd");
  $dumpvars(0, tb);

  $monitor("clk=%b, reset=%b, codigo=%b, entrada=%b, saida=%b", clk, rst, codigo, entrada, saida);
  
  for (i = 0; i < 4; i = i + 1) begin
    #1;
    rst       = dados_arquivo[i][11];
    codigo    = dados_arquivo[i][10:8];
    entrada   = dados_arquivo[i][7:0];
    #1;
  end
  
  $finish;
end

endmodule