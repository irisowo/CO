`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Additional Comments:0616086
//////////////////////////////////////////////////////////////////////////////////

module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire   [32-1:0] cout_; 	// for carry out through 1 bit ALU
wire   [32-1:0] result_; 	// temporary store for result
wire		set; 	 	       // check if slt is set
wire    overflow_;


alu_top a0(.src1(src1[0]), 
           .src2(src2[0]), 
            .less(set), 
           .A_invert(ALU_control[3]), 
           .B_invert(ALU_control[2]), 
           .cin(ALU_control[2]), 
           .operation(ALU_control[1:0]), 
           .result(result_[0]), 
           .cout(cout_[0]));

alu_top a1(src1[ 1], src2[ 1], 1'b0, ALU_control[3], ALU_control[2], cout_[ 0], ALU_control[1:0], result_[ 1], cout_[ 1]),
        a2(src1[ 2], src2[ 2], 1'b0, ALU_control[3], ALU_control[2], cout_[ 1], ALU_control[1:0], result_[ 2], cout_[ 2]),
        a3(src1[ 3], src2[ 3], 1'b0, ALU_control[3], ALU_control[2], cout_[ 2], ALU_control[1:0], result_[ 3], cout_[ 3]),
        a4(src1[ 4], src2[ 4], 1'b0, ALU_control[3], ALU_control[2], cout_[ 3], ALU_control[1:0], result_[ 4], cout_[ 4]),
        a5(src1[ 5], src2[ 5], 1'b0, ALU_control[3], ALU_control[2], cout_[ 4], ALU_control[1:0], result_[ 5], cout_[ 5]),
        a6(src1[ 6], src2[ 6], 1'b0, ALU_control[3], ALU_control[2], cout_[ 5], ALU_control[1:0], result_[ 6], cout_[ 6]),
        a7(src1[ 7], src2[ 7], 1'b0, ALU_control[3], ALU_control[2], cout_[ 6], ALU_control[1:0], result_[ 7], cout_[ 7]),
        a8(src1[ 8], src2[ 8], 1'b0, ALU_control[3], ALU_control[2], cout_[ 7], ALU_control[1:0], result_[ 8], cout_[ 8]),
        a9(src1[ 9], src2[ 9], 1'b0, ALU_control[3], ALU_control[2], cout_[ 8], ALU_control[1:0], result_[ 9], cout_[ 9]),
        a10(src1[10], src2[10], 1'b0, ALU_control[3], ALU_control[2], cout_[ 9], ALU_control[1:0], result_[10], cout_[10]),
        a11(src1[11], src2[11], 1'b0, ALU_control[3], ALU_control[2], cout_[10], ALU_control[1:0], result_[11], cout_[11]),
        a12(src1[12], src2[12], 1'b0, ALU_control[3], ALU_control[2], cout_[11], ALU_control[1:0], result_[12], cout_[12]),
        a13(src1[13], src2[13], 1'b0, ALU_control[3], ALU_control[2], cout_[12], ALU_control[1:0], result_[13], cout_[13]),
        a14(src1[14], src2[14], 1'b0, ALU_control[3], ALU_control[2], cout_[13], ALU_control[1:0], result_[14], cout_[14]),
        a15(src1[15], src2[15], 1'b0, ALU_control[3], ALU_control[2], cout_[14], ALU_control[1:0], result_[15], cout_[15]),
        a16(src1[16], src2[16], 1'b0, ALU_control[3], ALU_control[2], cout_[15], ALU_control[1:0], result_[16], cout_[16]),
        a17(src1[17], src2[17], 1'b0, ALU_control[3], ALU_control[2], cout_[16], ALU_control[1:0], result_[17], cout_[17]),
        a18(src1[18], src2[18], 1'b0, ALU_control[3], ALU_control[2], cout_[17], ALU_control[1:0], result_[18], cout_[18]),
        a19(src1[19], src2[19], 1'b0, ALU_control[3], ALU_control[2], cout_[18], ALU_control[1:0], result_[19], cout_[19]),
        a20(src1[20], src2[20], 1'b0, ALU_control[3], ALU_control[2], cout_[19], ALU_control[1:0], result_[20], cout_[20]),
        a21(src1[21], src2[21], 1'b0, ALU_control[3], ALU_control[2], cout_[20], ALU_control[1:0], result_[21], cout_[21]),
        a22(src1[22], src2[22], 1'b0, ALU_control[3], ALU_control[2], cout_[21], ALU_control[1:0], result_[22], cout_[22]),
        a23(src1[23], src2[23], 1'b0, ALU_control[3], ALU_control[2], cout_[22], ALU_control[1:0], result_[23], cout_[23]),
        a24(src1[24], src2[24], 1'b0, ALU_control[3], ALU_control[2], cout_[23], ALU_control[1:0], result_[24], cout_[24]),
        a25(src1[25], src2[25], 1'b0, ALU_control[3], ALU_control[2], cout_[24], ALU_control[1:0], result_[25], cout_[25]),
        a26(src1[26], src2[26], 1'b0, ALU_control[3], ALU_control[2], cout_[25], ALU_control[1:0], result_[26], cout_[26]),
        a27(src1[27], src2[27], 1'b0, ALU_control[3], ALU_control[2], cout_[26], ALU_control[1:0], result_[27], cout_[27]),
        a28(src1[28], src2[28], 1'b0, ALU_control[3], ALU_control[2], cout_[27], ALU_control[1:0], result_[28], cout_[28]),
        a29(src1[29], src2[29], 1'b0, ALU_control[3], ALU_control[2], cout_[28], ALU_control[1:0], result_[29], cout_[29]),
        a30(src1[30], src2[30], 1'b0, ALU_control[3], ALU_control[2], cout_[29], ALU_control[1:0], result_[30], cout_[30]);

alu_bottom a31(.src1(src1[31]), 
               .src2(src2[31]), 
               .less(1'b0),  
               .A_invert(ALU_control[3]), 
               .B_invert(ALU_control[2]), 
               .cin(cout_[30]), 
               .operation(ALU_control[1:0]),
               .result(result_[31]), 
               .cout(cout_[31]),
               .set(set),
               .overflow(overflow_));

always@( posedge clk or negedge rst_n) 
begin
	if(!rst_n) begin
		result    <= 1'b0;
  		zero      <= 1'b0;
		cout      <= 1'b0;
    	overflow  <= 1'b0;
	end
	else begin
		result <= result_;
        zero <= (result_ == 0)?1:0;
		overflow <= overflow_;
		cout <= ((ALU_control == 4'b0010) || (ALU_control == 4'b0110))?cout_[31]:0;
	end
end


endmodule
