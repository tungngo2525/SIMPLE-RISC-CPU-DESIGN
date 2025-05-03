`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 05:07:23 PM
// Design Name: 
// Module Name: alu
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


// =============================================================
// Module: ALU (Arithmetic Logic Unit)
// Function: Perform arithmetic and logical operations.
// Inputs:
// - inA: usually the value of the Accumulator (8-bit)
// - inB: reading from Memory (8-bit)
// - opcode: 3-bit (definition of command to be executed)
// Output:
// - result: 8-bit result
// - is_zero: asynchronous signal, equal to 1 if result = 0
// =============================================================
module alu (
    input wire [7:0] inA,
    input wire [7:0] inB,
    input wire ext,                             // If extend = 1, Alu using extend function mul and div
    input wire [2:0] opcode,
    output reg [7:0] result,
    output reg overflow,
    output wire is_zero
);
    reg [15:0] result_tmp;
    
    always @(*) begin
        overflow =  0;
    
        if (ext) begin
            case (opcode)
                3'b000: result = inA;               // HLT: did not perform the math, kept the inA
                3'b001: result = inA;               // SKZ: not calculating, using the inA result to check the is_zero
                3'b010: begin
                    result_tmp = inA * inB;         // MUL: inA * inB
                    if (result_tmp > 255) begin
                        overflow = 1;
                        result = 255;
                    end
                    else begin
                        result = inA * inB;
                    end
                end         
                3'b011: result = inA / inB;         // DIV: inA // inB
                3'b100: result = inA ^ inB;         // XOR: XOR
                3'b101: result = inB;               // LDA: retrieve data from Memory (inB)
                3'b110: result = inA;               // STO: puts data from ACC (inA) out to write to Memory
                3'b111: result = inA;               // JMP: no calculation, only use operand to load the PC
                default: begin
                    overflow = 0;
                    result = 8'b0;
                end
            endcase
        end
        else begin
            case (opcode)
                3'b000: result = inA;               // HLT: did not perform the math, kept the inA
                3'b001: result = inA;               // SKZ: not calculating, using the inA result to check the is_zero
                3'b010: begin
                    result_tmp = inA + inB;         // ADD: plus inA and inB
                    if (result_tmp > 255) begin
                        overflow = 1;
                        result = 255;
                    end
                    else begin
                        result = inA + inB;
                    end
                end
                3'b011: result = inA & inB;         // AND: AND
                3'b100: result = inA ^ inB;         // XOR: XOR
                3'b101: result = inB;               // LDA: retrieve data from Memory (inB)
                3'b110: result = inA;               // STO: puts data from ACC (inA) out to write to Memory
                3'b111: result = inA;               // JMP: no calculation, only use operand to load the PC
                default: begin
                    overflow = 0;
                    result = 8'b0;
                end
            endcase
        end
    end
    assign is_zero = (result == 8'b0);
endmodule
