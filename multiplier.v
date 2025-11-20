`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/12/2025 10:15:21 AM
// Design Name: 
// Module Name: multiplier_seq
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


module multiplier_seq(input clk, rst, input [3:0]a, b, output reg [7:0]p);

reg [3:0]operand, shift_count;    //shift count 4 when done
reg [7:0]partial_product, multiplicand; //multiplicand stores value
reg [1:0]PS,NS;

parameter IDLE = 2'b00;
parameter ADD = 2'b01;
parameter SHIFT = 2'b10;
parameter DONE = 2'b11;

//sequential present state updates
always @(posedge clk) begin
	if(rst) begin
		PS <= IDLE;
    end else
        PS <= NS;
end

//combinational next state updates
always @(*) begin
    case(PS)
        IDLE: NS = ADD;
        ADD: NS = SHIFT;
        SHIFT: NS = (shift_count < 4) ? ADD : DONE;  //multiply until 4 shifts occur
        DONE: NS = IDLE;
        default:NS = IDLE;      
    endcase
end

always @(posedge clk) begin
    if(rst) begin
        multiplicand <= 0;
        operand <= 0;
        partial_product <= 0;
        shift_count <= 0;
        p <= 0;
    end else begin
        case(PS)
            IDLE: begin
                multiplicand <= {4'b0, a};   //initialize with extra space to store shifts
                operand <= b;    //initialize to b
                partial_product <= 0;
                shift_count <= 0;
            end
            ADD: begin
                if(operand[0])    //if LSB = 1
                    partial_product <= partial_product + multiplicand;
            end
            SHIFT: begin
                multiplicand <= multiplicand << 1;
                operand <= operand >> 1;
                shift_count <= shift_count + 1; 
            end
            DONE: begin
                p <= partial_product;
            end
        endcase
    end
end
endmodule


module multiplier_comb(input [3:0]a, b, output [7:0]p);

    wire [3:0]pp0;
    wire [4:0]pp1;
    wire [5:0]pp2;
    wire [6:0]pp3;
    
    assign pp0 = b[0] ? a : 0;  //partial product 0 is a when b[0] = 1, 0 else
    assign pp1 = b[1] ? (a << 1) : 0; //partial product 1 is (a << 1) when b[1] = 1, 0 else
    assign pp2 = b[2] ? (a << 2) : 0; //partial product 2 is (a << 2) when b[2] = 1, 0 else
    assign pp3 = b[3] ? (a << 3) : 0; //partial product 3 is (a << 3) when b[3] = 1, 0 else
    assign p = pp0 + pp1 + pp2 + pp3; //sum partial products

endmodule
