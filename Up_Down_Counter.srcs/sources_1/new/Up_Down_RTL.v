//Port List with Port Declaration and DataTypes
module n_bitUp_DownCounter #(parameter IN_WIDTH=5)
(
    input wire [IN_WIDTH-1:0] IN,
    input wire Load,UP,DOWN,
    input wire CLK,
    output wire HIGH,LOW,
    output reg [IN_WIDTH-1:0]Counter);
  //Single Always Block for Sequential and Combinational logic
always @(posedge CLK)
begin
  //1 Two_Input MUX
  if(Load)
  begin
    // n D-FlipFlops 
    Counter<=IN;
  end
  //1 Two_Input MUX , 1 Two_Input AND Gate,1 Not Gate
  else if(DOWN &&(LOW==0))
  begin
    //1 n_Bit Subtractor
    Counter=Counter-5'b1;
  end
  //1 Two_Input MUX ,1 Three_Input AND Gate,2 Not Gates
  else if(UP &&(HIGH==0)&&(!DOWN))
  begin 
    //1 n_Bit Adder
    Counter=Counter+5'b1;
  end
end
// Assign Statements for HIGH and LOW signals
//1 n_Bit Compartor
assign HIGH=(Counter==5'b11111);
//1 Five_Input NOR Gate
assign LOW=(Counter==5'b00000);
endmodule