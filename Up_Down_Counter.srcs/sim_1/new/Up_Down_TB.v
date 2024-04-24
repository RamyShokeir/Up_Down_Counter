`timescale 1ns/1ps
module UP_DOWN_Counter_TB #(parameter IN_WIDTH=5);
//Declare TestBench Signals
reg[IN_WIDTH-1:0] IN_TB;
reg Load_TB,UP_TB,DOWN_TB;
reg CLK_TB;
wire[IN_WIDTH-1:0] Counter_TB;
wire HIGH_TB,LOW_TB;
parameter CLK_PERIOD=10;
//DUT Instantiation
n_bitUp_DownCounter DUT(
.IN (IN_TB),
.Load(Load_TB),
.UP (UP_TB),
.DOWN(DOWN_TB),
.CLK(CLK_TB),
.Counter(Counter_TB),
.HIGH(HIGH_TB),
.LOW(LOW_TB));
//Clock Generation
always #(CLK_PERIOD/2) CLK_TB=~CLK_TB;
//Initial Block
initial
 begin
  $dumpvars;
    initialize;
  //Testing if LOAD signal works
  $display ("Test case 1");
  #(2*CLK_PERIOD) Load_TB=1'b1;
  #(CLK_PERIOD) if(Counter_TB=='b01010)
  $display("Test case 1 Passed");
      else
  $display("Test case 1 Failed");
//Testing if UP signal works
  $display("Test case 2");
  #(2*CLK_PERIOD) Load_TB=1'b0;
  UP_TB=1'b1;
  #(CLK_PERIOD) if(Counter_TB=='b01011)
  $display("Test case 2 Passed");
  else
  $display("Test case 2 Failed");
//Testing if Counter reached to its max value(31 in decimal) then HIGH signal should be high
  $display("Test case 3");
  #(23*CLK_PERIOD) if(HIGH_TB==1'b1)
  $display("Test case 3 Passed");
  else
  $display("Test case 3 Failed");
//Testing if DOWN signal works
  $display("Test case 4");
  #(2*CLK_PERIOD) UP_TB=1'b0;
  DOWN_TB=1'b1;
  #(CLK_PERIOD) if(Counter_TB=='b11110)
  $display("Test case 4 Passed");
  else
  $display("Test case 4 Failed");
  DOWN_TB=1'b0;
  //Testing if DOWN Signal has a higher priority than UP Signal
  $display("Test case 5");
  #(2*CLK_PERIOD) UP_TB=1'b1;
      DOWN_TB=1'b1;
  #(CLK_PERIOD) if(Counter_TB=='b11101)
  $display("Test case 5 Passed");
  else
  $display("Test case 5 Failed");
//Testing if Counter reached zero so that LOW signal should be high
  $display("Test case 6");
  #(30*CLK_PERIOD) if(LOW_TB==1'b1)
  $display("Test case 6 Passed");
  else
  $display("Test case 6 Failed");

//Testing if Load has the highest priority 
  $display("Test case 7 ");
  #(2*CLK_PERIOD) Load_TB=1'b1;
  #(CLK_PERIOD) if(Counter_TB=='b01010)
   $display("Test case 7 Passed");
   else
   $display("Test case 7 Failed");
  #(10*CLK_PERIOD) $finish;
 end
 task initialize;
 begin 
   //intialization all inputs to zero
 CLK_TB=1'b0;
 Load_TB=1'b0;
 UP_TB=1'b0;
 DOWN_TB=1'b0;
 IN_TB='b 01010;
 end
 endtask
endmodule
