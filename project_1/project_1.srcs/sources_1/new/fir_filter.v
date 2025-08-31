`timescale 1ns / 1ps // precision of the simulation 1 nanoseconds

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Ahmed Okab
// 
// Create Date: 08/30/2025 05:52:21 PM
// Design Name: 
// Module Name: fir_filter
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
// my implementation of the FIR filter

module fir_filter( input_data, clk, reset, enable, outputData, sampleT);
//input data is data sent at k to filter
//clk = clock
// reset resets the filter :) sets all the tabs that store past inputs to 0 that store past values

//fir coefficient word length
parameter width1 = 8;

//input bit length
parameter width2 = 16;

//output bit length
parameter width3 = 24;

//after multiplication, bit size grows so need 32 bit output



// this array is used to store the coefficients
wire  signed [width1-1 : 0]  b [0:7] ; // bit length is 8 as shown by width1-0, number of values is 8 as shown by b[0:7]
//inputs can be negative, so declare as signed.

//filter coefficients, using 1/8
//8'b tells verilog that length of word is 8
assign b[0] = 8'b00010000;
assign b[1] = 8'b00010000;
assign b[2] = 8'b00010000;
assign b[3] = 8'b00010000;
assign b[4] = 8'b00010000;
assign b[5] = 8'b00010000;
assign b[6] = 8'b00010000;
assign b[7] = 8'b00010000;

//input data, define as input data port
input signed [width2-1: 0] input_data;

//output data sample
output signed [width3-1: 0] sampleT;

//clock, reset and enable as input ports
input clk;
input reset;
input enable;

//filtered data
output signed [width3-1: 0] outputData;

//register valuable used to store the output, needed for intermediate operation
reg signed [width3-1 : 0] outputDataRegister;

// array to store samples and shift them accordingly
reg signed [width2-1: 0] samples[0:6]; //storing past input samples uk uk-1 uk-2 uk-3 etc.


// using always block to execute something on every rising edge of the clock
always @(posedge clk)
begin
    if (reset == 1'b1)
        begin
            samples[0] <= 0;
            samples[1] <= 0;
            samples[2] <= 0;
            samples[3] <= 0;
            samples[4] <= 0;
            samples[5] <= 0;
            samples[6] <= 0;
            outputDataRegister <= 0;
            //non-blocking statements are used, executed at the same time at positive edge of clock
        end
     else if ((enable == 1'b1))
        begin
            outputDataRegister  <= (b[0] * input_data + b[1]*samples[0]
             + b[2]*samples[1] +b[3]*samples[2]
              + b[4]*samples[3] + b[5]*samples[4]
               + b[6]*samples[5] + b[7]*samples[6]) >>>7 ; // using formula to calculate output data based on current input data and previous input data
            // using values before the clock statement
            
            samples[0] <= input_data;
            samples[1] <= samples[0];
            samples[2] <= samples[1];
            samples[3] <= samples[2];
            samples[4] <= samples[3];
            samples[5] <= samples[4];
            samples[6] <= samples[5]; //shifts input data to make room for next input value
            
            //Using Nonblocking statement! all these lines executed at the same time, NOT sequentially
            
        end
end

assign  outputData = outputDataRegister;
assign sampleT = samples[0];

//complete FIR filter

endmodule
