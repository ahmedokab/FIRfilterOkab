`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2025 09:40:08 PM
// Design Name: 
// Module Name: testbench1
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


module testbench1(

    );
    
//fir coefficient word length
parameter width1 = 8;

//input bit length
parameter width2 = 16;

//output bit length
parameter width3 = 24;

reg clk;
reg reset; //use registers instead of input in testbench
reg enable; //need to observe their change based on time


reg [width2-1: 0] input_data;
// THIS array stores input samples from the file
reg [width2-1: 0] data[199:0];



//output data
wire[width3-1: 0] outputData;
wire [width3-1: 0] sampleT;


fir_filter unitUnderTest ( .input_data(input_data), .outputData(outputData), .clk(clk), .reset(reset), .enable(enable), .sampleT(sampleT)); // connecting ports to test_bench

integer k; // used in  for loop
integer f1; //file after the data 
//has been filtered

//clock has a pulse width of 12 ns;

initial clk = 0;
always #12 clk = ~clk;

initial
begin
    k = 0; //denotes rows of file
    
    $readmemb("input.data", data);
    
    f1 = $fopen("saved.data", "w");
   
   clk = 0;
   #24
   // reset the filter, coefficients to 0
   reset = 1'b1;
   #48
   // enable filter again
   reset = 1'b0; //blocking statements used
   enable = 1'b1;
   
   input_data <= data[0]; //input data will be set, but not used until the rising edge of clock bc of fir_filter.v having always @ posedge
   #12
   for (k = 1; k < 200; k= k + 1)
   begin
        @(posedge clk);
        $fdisplay(f1, "%b", outputData);
        input_data <= data[k];
        if (k == 199)
        $fclose(f1);
    end
   
end

endmodule
