`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2025 10:16:44 AM
// Design Name: 
// Module Name: multiplier_seq_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module multiplier_seq_tb();

reg clk, rst;
reg [3:0]a, b;
wire [7:0]p;

multiplier_seq dut(.clk(clk), .rst(rst), .a(a), .b(b), .p(p));

initial begin
    clk = 0;
    rst = 1;
    a = 0;
    b = 0;
    #20 rst = 0;
end
always #5 clk = ~clk;

initial begin
    #20 a = 4; b = 12; wait (dut.PS == dut.DONE); wait (dut.PS == dut.IDLE);
    a = 6; b = 6; wait (dut.PS == dut.DONE); wait (dut.PS == dut.IDLE);
    a = 15; b = 15; wait (dut.PS == dut.DONE); wait (dut.PS == dut.IDLE);
    a = 0; b = 15; wait (dut.PS == dut.DONE); wait (dut.PS == dut.IDLE);
    a = 2; b = 4; wait (dut.PS == dut.DONE); wait (dut.PS == dut.IDLE);
    a = 1; b = 9; wait (dut.PS == dut.DONE); wait (dut.PS == dut.IDLE);
    #100 $finish;
end
endmodule




module multiplier_comb_tb();

reg [3:0]a, b;
wire [7:0]p;

multiplier_comb dut(.a(a), .b(b), .p(p));

initial begin
    a = 4; b = 12;
    #10 a = 6; b = 6;
    #10 a = 15; b = 15;
    #10 a = 0; b = 15;
    #10 a = 2; b = 4;
    #10 a = 1; b = 9;
    #10 $finish;
end
endmodule
