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
	funct,
    Branch,
	MemToReg,
	BranchType,
	Jump,
	MemRead,
	MemWrite,
	ALUOp,
	ALUSrc,
	RegWrite,
	RegDest,
	JumpRegister
	);
     
//I/O ports
input  [5:0] 	instr_op_i;
input  [5:0] 	funct;

output         	Branch;
output	[1:0]	MemToReg;
output	[1:0]	BranchType;
output			Jump;
output			MemRead;
output			MemWrite;
output 	[2:0]	ALUOp;
output         	ALUSrc;
output         	RegWrite;
output	[1:0]  	RegDest; 
output			JumpRegister;


assign Branch = (instr_op_i==6'b000100);//beq

assign MemRead = (instr_op_i==6'b100011); //lw
assign MemWrite =(instr_op_i==6'b101011); //sw

assign RegWrite = ~((instr_op_i==6'b101011) | (instr_op_i==6'b000010) | (instr_op_i==6'b000100));// R-type, lw=1

assign MemToReg[1] =(instr_op_i==6'b000011); //jal choose 2(10)
assign MemToReg[0] = ((instr_op_i==6'b100011) );//| (instr_op_i==6'b001010)); //lw slti 

assign BranchType[1] = instr_op_i[4];   
assign BranchType[0] = instr_op_i[4];

//  R-type: 000 ; beq: 010 ; lw/sw:001  addi: 011 ; slti: 100  ; 
assign ALUOp[2] = (instr_op_i==6'b001010);
assign ALUOp[1] = (instr_op_i==6'b001000) | (instr_op_i==6'b000100);
assign ALUOp[0] = ~((instr_op_i==6'b000000) | (instr_op_i==6'b000100) | (instr_op_i==6'b001010));

assign ALUSrc = (instr_op_i==6'b100011) | (instr_op_i==6'b101011) | (instr_op_i==6'b001000) | (instr_op_i==6'b001010); //lw sw addi slt

assign RegDest[1] = (instr_op_i==6'b000011 ); // jal select 2!!!(10)
assign RegDest[0] = (instr_op_i==6'b000000); //R-type choose 0  ; I-type choose 1

assign Jump =~(instr_op_i==6'b000010 | instr_op_i==6'b000011); // j, jal : choose 0
assign JumpRegister = ((instr_op_i==6'b000000) & (funct==6'b001000));//jr


endmodule




                    
                    