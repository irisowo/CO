//0616086

module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire	[31:0]	pc_in, pc_out, instr, pc_add4, add_pc_SESL;//SESL means sign extended shift left
wire	[31:0]	Jump_in_1, Jump_in_0,Jump_out;

wire	[1:0]	MemToReg, BranchType, RegDst;
wire			Branch,Jump,MemRead,MemWrite,ALUSrc, RegWrite;
wire [2:0]  ALUOp; 
wire [4:0]	WriteReg;
wire			JumpRegister; 

wire 	[31:0]	RD1_o, RD2_o, RD_after_mux ,ReadData, WriteRegData;
wire 	[3:0]	ALUCtrl_out;
wire 	[31:0]	SignExtended, SignExtendShiftLeft;
wire	[31:0]	ALUResult;

wire branch_and_zero;
wire	zero;
wire	[27:0]	instrShiftLeft;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in),   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(pc_out),     
	    .src2_i(32'd4),     
	    .sum_o(pc_add4)    
	    );
	    
 Shift_Left_26_to_28  Shifter(
        .data_i(instr[25:0]),
        .data_o(instrShiftLeft)	
 );	
		
PC_instr PC_instr1(
	.instr(instrShiftLeft),
	.pc(pc_add4),
	.PC_instr_o(Jump_in_0)
    );
	
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr)    
	    );

MUX_3to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr[20:16]),
        .data1_i(instr[15:11]),
		.data2_i(5'b11111),
        .select_i(RegDst),
        .data_o(WriteReg)
        );	
		
Reg_File Registers(
        .clk_i(clk_i),      
	    .rst_i(rst_i),     
        .RSaddr_i(instr[25:21]),  
        .RTaddr_i(instr[20:16]),  
        .RDaddr_i(WriteReg),  
        .RDdata_i(WriteRegData), 
        .RegWrite_i(RegWrite),
        .RSdata_o(RD1_o),  
        .RTdata_o(RD2_o)   
        );
	
Decoder Decoder(
	.instr_op_i(instr[31:26]), 
	.funct(instr[5:0]), 
    .Branch(Branch), 
	.MemToReg(MemToReg), 
	.BranchType(BranchType), 
	.Jump(Jump), 
	.MemRead(MemRead), 
	.MemWrite(MemWrite), 
	.ALUOp(ALUOp), 
	.ALUSrc(ALUSrc), 
	.RegWrite(RegWrite), 
	.RegDest(RegDst), 
	.JumpRegister(JumpRegister)
	);

ALU_Ctrl AC(
        .funct_i(instr[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALUCtrl_out) 
        );
	
Sign_Extend SE(
        .data_i(instr[15:0]),
        .data_o(SignExtended)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(RD2_o),
        .data1_i(SignExtended),
        .select_i(ALUSrc),
        .data_o(RD_after_mux)
        );	
		
ALU ALU(
        .src1_i(RD1_o),
	    .src2_i(RD_after_mux),
	    .ctrl_i(ALUCtrl_out),
	    .result_o(ALUResult),
		.zero_o(zero)
	    );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(ALUResult),
	.data_i(RD2_o),
	.MemRead_i(MemRead),
	.MemWrite_i(MemWrite),
	.data_o(ReadData)
	);
	
Adder Adder2(
        .src1_i(pc_add4),     
	    .src2_i(SignExtendShiftLeft),     
	    .sum_o(add_pc_SESL)      
	    );
		
Shift_Left_Two_32 #(.size(32)) Shifter1(
        .data_i(SignExtended),
        .data_o(SignExtendShiftLeft)
        ); 		
		
MUX_3to1 #(.size(32)) Mux_Mem_To_Reg(
        .data0_i(ALUResult),
        .data1_i(ReadData),
		.data2_i(pc_add4),
        .select_i(MemToReg),
        .data_o(WriteRegData)
        );	

and	G1(branch_and_zero, Branch, zero);

MUX_2to1 #(.size(32)) Mux_A(
        .data0_i(pc_add4),
        .data1_i(add_pc_SESL),
        .select_i(branch_and_zero),
        .data_o(Jump_in_1)
        );	

MUX_2to1 #(.size(32)) Mux_Jump(
        .data0_i(Jump_in_0),
        .data1_i(Jump_in_1),
        .select_i(Jump),
        .data_o(Jump_out)
        );	
		
MUX_2to1 #(.size(32)) Mux_Jump_Register(
        .data0_i(Jump_out),
        .data1_i(RD1_o),
        .select_i(JumpRegister),
        .data_o(pc_in)
        );			
		
endmodule