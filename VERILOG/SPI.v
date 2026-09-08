module SPI (
input  clk,rst_n,ss_n, 
input  [7:0]tx_data, 
input  tx_valid,
input  MOSI,
output MISO,
output reg [9:0]rx_data,
output reg rx_valid 
);
// ------------------------STATES------------------------------- 
// ------------------------BINARY-------------------------------                           
localparam [2:0] IDLE = 3'b000, CHK_CMD = 3'b001, WRITE = 3'b010,
                READ_ADD = 3'b011, READ_DATA = 3'b100;
reg [2:0]ns,cs;


// internal sifnal FF for dalay one cycle 
reg cmd_first;
// block 3 SIPO counter 
reg [3:0]cnt;
// block 4 PISO counter 
reg [7:0] tx_shift_reg;
reg [3:0]cnt_r;



//--------------------current state FIRST BLOCK--------------------- 
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
        cs<=IDLE;
        else  
        cs <= ns;
    end

// -----------------next state SECOND BLOCK-------------------------- 
always @(*) begin
    ns = cs;
    case (cs)

    // IDLE
    IDLE: 
    if(ss_n)
    ns = IDLE;
    else  
    ns = CHK_CMD;
    // CHECK COMMAND
    CHK_CMD: begin

    if (ss_n)
        ns = IDLE;

    else if (cmd_first == 1'b0 && MOSI == 1'b0)
        ns = WRITE;    // 00
    else if (cmd_first == 1'b0 && MOSI == 1'b1)
        ns = WRITE;       // 01
    else if (cmd_first == 1'b1 && MOSI == 1'b0)
        ns = READ_ADD;   // 10
    else if (cmd_first == 1'b1 && MOSI == 1'b1)
        ns = READ_DATA;    // 11

end
    // WRITE 
    WRITE: begin
    if (!ss_n)
    ns = WRITE;
    else 
    ns = IDLE;
    end

    // READ ADDRESS
    READ_ADD:
    if(!ss_n)
    ns = READ_ADD;
    else  
    ns = IDLE;

    // READ DATA 
    READ_DATA:
    if (!ss_n)
    ns = READ_DATA;
    else  
    ns =IDLE;
    default:
    ns = IDLE;
    endcase
end 

// ------------------- OUTPUT THIRD BLOCK------------------

// --WRITE OPERATION--READ ADDRESS--READ DATA--  

// SIPO
always @(posedge clk) begin
    if (!rst_n) begin
        rx_data  <= 10'd0;
        cnt      <= 4'd0;
        rx_valid <= 1'b0;
    end

    else if (ss_n) begin
        // Transaction finished
        rx_data  <= 10'd0;
        cnt      <= 4'd0;
        rx_valid <= 1'b0;
    end

    else begin
        // Receiving
        rx_valid <= 1'b0;

        if (cnt < 4'd10) begin
            rx_data <= {rx_data[8:0], MOSI}; // shift left 
            if (cnt == 4'd9) begin
                
                rx_valid <= 1'b1;
                cnt <= 4'd10;
            end
            else begin
                cnt <= cnt + 1'b1; // COUNT FOR DATA INPUT 
            end
        end
        end
        end
    // command first (cmd)
    always @(negedge clk) begin
    if (!rst_n)
        cmd_first <= 1'b0;

    else if (ss_n)
        cmd_first <= 1'b0;

    else if (cs == CHK_CMD) 
        cmd_first <= MOSI;  // load mosi 
end

//-------- PISO ----

always @(negedge clk ) begin
    if (!rst_n) begin // reset
        tx_shift_reg <= 8'd0;
        cnt_r <= 4'd0;
    end

    else if (ss_n) begin // transaction finished
        tx_shift_reg <= 8'd0;
        cnt_r <= 4'd0;
    end
    else if (tx_valid && (cs == READ_DATA)) begin
      tx_shift_reg <= tx_data;  // load data
        cnt_r        <= 4'd0;
    end

    else if ((cs == READ_DATA) && (cnt_r < 4'd8)) begin
        tx_shift_reg <= {tx_shift_reg[6:0], 1'b0}; // shift left 
        cnt_r        <= cnt_r + 1'b1; // count for read data
    end
end

assign MISO = (!ss_n && (cs == READ_DATA))?  tx_shift_reg[7] : 1'b0; // miso output serial data
endmodule //SPI 