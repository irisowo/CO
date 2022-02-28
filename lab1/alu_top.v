`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Additional Comments: 0616086
//////////////////////////////////////////////////////////////////////////////////

module alu_top(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout       //1 bit carry out(output)
               );

input         src1;
input         src2;
input         less;
input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output        cout;

reg           result;
reg           cout;
reg           a;
reg           b;


always@(*)
begin
    a = src1 ^ A_invert;
    b = src2 ^ B_invert;

	case(operation)
	   2'b00:
	   begin
	      result = a&b;
	      cout = 0;
	   end
	   2'b01:
	   begin
	      result = a|b;
	      cout = 0;
	   end
	   2'b10:
	   begin
	      {cout, result} = a+b+cin;
	   end
	   2'b11:
	   begin
	      result = less;
	      cout = (a&b) | (a&cin) | (b&cin); 
	   end 
	endcase

end
endmodule
