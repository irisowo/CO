`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Additional Comments: 0616086
//////////////////////////////////////////////////////////////////////////////////

module alu_bottom(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
               set,
               overflow
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
output        set;
output        overflow;

reg           a;
reg           b;
reg           result;
reg           cout;
reg           set;
reg           overflow;


always@(*)begin
    a = src1 ^ A_invert;
    b = src2 ^ B_invert;

    {cout, result} = a+b+cin;
    set = result;
    overflow = 0;

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
            if ( a==b && result!=1)
                overflow = 1;
            else if ( a==0 && b==0 && result!=0)
                 overflow = 1;
            else
                 overflow = 0;
	 end
	 2'b11:
	 begin
	    result = less;
	 end 
    endcase 


end

endmodule
