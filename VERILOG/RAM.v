module RAM #(parameter MEM_DEPTH = 256,parameter ADD_SIZE = 8)(
input  clk,rst_n,
input  [9:0]din,
input  rx_valid,
output reg [7:0]dout,
output reg tx_valid
);
reg [7:0] mem [MEM_DEPTH-1:0]; // memory decleration
reg [ADD_SIZE-1:0]w_add,r_add;     // addresses read - write

// pending operation 
reg tx_pending; //  tx operation 
reg flag_read;
reg flag_write;

always @(posedge clk ) begin
    if(!rst_n)begin // reset all signals
    dout<=8'd0;
    w_add<=8'd0;
    r_add<=8'd0;
    tx_valid<=1'b0;
    flag_read<=0;
    flag_write<=0;
    end
    else begin  
        tx_valid<=0;
        if(tx_pending) begin 
            tx_valid<=1;
            tx_pending<=0;
        end 
        if(rx_valid) begin
    case ({din[9],din[8]})
    2'b00: begin        // 00 write address
            if(!flag_write)begin
            w_add <= din[7:0];  
            flag_write<=1;
            end
        end
    2'b01: begin       // 01 write data
            if(flag_write)begin
            mem[w_add] <= din[7:0];
            flag_write<=0;
            end
        end
    2'b10: begin       // read address
            if(!flag_read)begin
            r_add <= din[7:0];
            flag_read<=1;
            end
        end
    2'b11:begin        // read data
            if(flag_read) begin
            dout <= mem[r_add];
            flag_read<=0;
            tx_pending<=1'b1;
            
            end
    end
    endcase
    end
    end
end
endmodule //RAM