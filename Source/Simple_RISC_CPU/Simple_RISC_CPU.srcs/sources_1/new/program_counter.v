`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2025 10:57:15 AM
// Design Name: 
// Module Name: program_counter
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
// Module: Program Counter (PC)
// Function: Stores the current address of the program.
// It has the ability to reset, load new values (for jumping) and increment (increment).
// Width: 5-bit
// =============================================================
module program_counter (
    input wire clk,                 // Clock 
    input wire reset,               // Reset signal
    input wire load,               	// If load = 1, pc = data_in
	input wire inc,               	// If inc = 1, pc = pc + 1
    input wire [4:0] data_in,      	// Adress from IR
    output reg [4:0] pc_out        	// Output pc
);
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            pc_out <= 5'd0;             // Initialization
        end
        else if (load) begin
            pc_out <= data_in;          // Load data_in to pc_out 
        end
        else if (inc) begin
            if(pc_out < 5'd31) begin
                pc_out <= pc_out + 1;  // Increase pc when have inc signal
            end
        end
    end
endmodule
