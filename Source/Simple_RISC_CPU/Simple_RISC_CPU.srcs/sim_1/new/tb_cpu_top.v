`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 08:29:30 PM
// Design Name: 
// Module Name: tb_cpu_top
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


module tb_cpu_top;

    // Khai b�o t�n hi?u ki?m tra
    reg clk;
    reg reset;

    // Kh?i t?o module cpu_top
    cpu_top uut (
        .clk(clk),
        .reset(reset)
    );

    // T?o t�n hi?u clock v?i chu k? 10ns
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Kh?i t?o reset v� ?i?u khi?n th?i gian m� ph?ng
    initial begin
        // �p ??t reset ban ??u ?? kh?i t?o to�n b? c�c module
        reset = 1;
        #10;
        reset = 0;
        
        // Cho ph�p m� ph?ng ch?y trong m?t kho?ng th?i gian nh?t ??nh,
        // v� d?: 200ns, sau ?� d?ng m� ph?ng.
        #1500;
        $finish;
    end

//     initial begin
//         $monitor("Time=%0t | PC=%b | Instruction=%b | ACC=%b | Halt=%b",
//                  $time, uut.pc_inst.pc_out, uut.ir_inst.instr_out, uut.acc_inst.acc_out, uut.ctrl_inst.halt);
//     end

    always @(posedge uut.ctrl_inst.sel) begin
        $display("[%0t ns] >>> SELECT SIGNAL -- PC=%0d | OPCODE=%03b | INSTR=%02h | ACC=%02h | ALU_RESULT=%02h",
             $time, uut.pc_inst.pc_out, uut.opcode, uut.ir_inst.instr_out, uut.acc_inst.acc_out, uut.alu_inst.result);
    end

endmodule
