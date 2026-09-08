module TB ();
// TOP
reg clk,rst_n,ss_n;
reg MOSI;
wire MISO;

reg tx_valid,rx_valid;
reg [9:0]din;
reg [7:0]dout;
//instaniate TOP
TOP DUT (.clk(clk),
     .rst_n(rst_n),
     .ss_n(ss_n),
     .MOSI(MOSI),
     .MISO(MISO)
     );
    

//task for command check 
task send_bit;
    input  command;
    begin
            MOSI = command;
            @(negedge clk);
        end
endtask
// task for address & data
task send_word;
    input [7:0] word;
    integer i;
    begin
        for (i = 7;i>=0 ;i = i - 1 ) begin
            MOSI = word[i];
            @(negedge clk);
        end 
    end
    endtask
    //clk
    initial begin
    clk = 0;
    forever 
    #1 clk = ~clk;
end
initial begin
    // verify reset
    rst_n=0;
    $readmemh ("mem.dat",DUT.ram.mem);
    ss_n=0;
    MOSI=0;
    repeat(4) @(negedge clk);
    rst_n=1;

//======================================================
// BATCH 1
// WRITE 19 -> 5
// READ  19 -> 5
//======================================================

// WRITE ADDRESS = 19
ss_n = 0;
send_bit(0);
send_bit(0);
send_word(8'd19);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// WRITE DATA = 5
ss_n = 0;
send_bit(0);
send_bit(1);
send_word(8'd5);
ss_n = 1;
@(negedge clk);

// READ ADDRESS = 19
ss_n = 0;
send_bit(1);
send_bit(0);
send_word(8'd19);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// READ DATA
ss_n = 0;
send_bit(1);
send_bit(1);
send_word(8'd5);
repeat (10) @(negedge clk);
ss_n = 1;
@(negedge clk);

//======================================================
// BATCH 2
// WRITE 18 -> 10
// READ  18 -> 10
//======================================================

// WRITE ADDRESS = 18
ss_n = 0;
send_bit(0);
send_bit(0);
send_word(8'd18);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// WRITE DATA = 10
ss_n = 0;
send_bit(0);
send_bit(1);
send_word(8'd10);
ss_n = 1;
@(negedge clk);

// READ ADDRESS = 18
ss_n = 0;
send_bit(1);
send_bit(0);
send_word(8'd18);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// READ DATA
ss_n = 0;
send_bit(1);
send_bit(1);
send_word(8'd10);
repeat (10) @(negedge clk);
ss_n = 1;
@(negedge clk);

//======================================================
// BATCH 3
// WRITE 17 -> 15
// READ  17 -> 15
//======================================================

// WRITE ADDRESS = 17
ss_n = 0;
send_bit(0);
send_bit(0);
send_word(8'd17);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// WRITE DATA = 15
ss_n = 0;
send_bit(0);
send_bit(1);
send_word(8'd15);
ss_n = 1;
@(negedge clk);

// READ ADDRESS = 17
ss_n = 0;
send_bit(1);
send_bit(0);
send_word(8'd17);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// READ DATA
ss_n = 0;
send_bit(1);
send_bit(1);
send_word(8'd15);
repeat (10) @(negedge clk);
ss_n = 1;
@(negedge clk);

//======================================================
// BATCH 4
// WRITE 16 -> 20
// READ  16 -> 20
//======================================================

// WRITE ADDRESS = 16
ss_n = 0;
send_bit(0);
send_bit(0);
send_word(8'd16);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// WRITE DATA = 20
ss_n = 0;
send_bit(0);
send_bit(1);
send_word(8'd20);
ss_n = 1;
@(negedge clk);

// READ ADDRESS = 16
ss_n = 0;
send_bit(1);
send_bit(0);
send_word(8'd16);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// READ DATA
ss_n = 0;
send_bit(1);
send_bit(1);
send_word(8'd20);
repeat (10) @(negedge clk);
ss_n = 1;
@(negedge clk);

//======================================================
// BATCH 5
// WRITE 15 -> 25
// READ  15 -> 25
//======================================================

// WRITE ADDRESS = 15
ss_n = 0;
send_bit(0);
send_bit(0);
send_word(8'd15);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// WRITE DATA = 25
ss_n = 0;
send_bit(0);
send_bit(1);
send_word(8'd25);
ss_n = 1;
@(negedge clk);

// READ ADDRESS = 15
ss_n = 0;
send_bit(1);
send_bit(0);
send_word(8'd15);
ss_n = 1;
@(negedge clk);
@(negedge clk);

// READ DATA
ss_n = 0;
send_bit(1);
send_bit(1);
send_word(8'd25);
repeat (10) @(negedge clk);
ss_n = 1;
#20;
$stop;
$display("communication is finshed");
end
initial begin
    $monitor(
        "TIME=%0t | ss_n=%b | rst_n=%b | MOSI=%b | MISO=%b ",
        $time,
        ss_n,
        rst_n,
        MOSI,
        MISO
    );
end
endmodule //TB