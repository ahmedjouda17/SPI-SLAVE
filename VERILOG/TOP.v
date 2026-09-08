module TOP #(parameter MEM_DEPTH = 256 ,parameter ADD_SIZE = 8)(
input clk,rst_n,ss_n,
input MOSI,
output MISO 
);
wire [9:0]rx;
wire r_valid;
wire [7:0]tx;
wire t_valid;
//--------------*INSTANTIATION*----------------- 
// SPI 
SPI SPI_S (.clk(clk),
         .rst_n(rst_n),
         .ss_n(ss_n),
         .MOSI(MOSI),
         .MISO(MISO),
         .rx_data(rx),
         .rx_valid(r_valid),
         .tx_data(tx),
         .tx_valid(t_valid)); 

// RAM       
RAM #(.MEM_DEPTH(MEM_DEPTH),
      .ADD_SIZE(ADD_SIZE)
      )
ram (.clk(clk),
         .rst_n(rst_n),
         .din(rx),
         .rx_valid(r_valid),
         .dout(tx),
         .tx_valid(t_valid));   
endmodule //TOP