//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616086
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------


module Decoder( 
	instr_op_i, 
	RegWrite_o,	
	ALUOp_o, 
	ALUSrc_o, 
	RegDst_o,
	Branch_o, 
	MemRead_o, 
	MemWrite_o, 
	MemtoReg_o
);
     
//I/O ports
input	[6-1:0] instr_op_i;

output	[3-1:0] ALUOp_o;
output  RegDst_o, MemtoReg_o;
output  ALUSrc_o, RegWrite_o, Branch_o, MemRead_o, MemWrite_o;

//Internal Signals
reg	[3-1:0] ALUOp_o;
reg 	[2-1:0] BranchType_o;

//Main function
assign RegWrite_o = ~((instr_op_i==6'b101011) | (instr_op_i==6'b000010) | (instr_op_i==6'b000100));// R-type, lw=1
assign ALUSrc_o = (instr_op_i==6'b100011) | (instr_op_i==6'b101011) | (instr_op_i==6'b001000) | (instr_op_i==6'b001010); //lw sw addi slti
assign Branch_o = (instr_op_i==6'b000100);//beq
assign MemRead_o= (instr_op_i==6'b100011); //lw
assign MemWrite_o =(instr_op_i==6'b101011); //sw
assign MemtoReg_o = ((instr_op_i==6'b100011) ); //lw 
assign RegDst_o = (instr_op_i==6'b000000); //R-type choose 0  ; I-type choose 1


always@(*)begin
	case(instr_op_i)
		6'b000000://r-format
		begin
		   ALUOp_o<=3'b000;
		end
		6'b001000://addi
		begin
		   ALUOp_o<=3'b100;
		end
		6'b001010://slti	
		begin
		   ALUOp_o<=3'b010;
		end
		6'b100011://lw	
		begin
		   ALUOp_o<=3'b100;
		end
		6'b101011://sw	
		begin
	   	   ALUOp_o<=3'b100;
		end
		6'b000100://beq	
		begin
		   ALUOp_o<=3'b001;
		end
	endcase
end

endmodule