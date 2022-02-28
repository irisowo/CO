// 0616086
//--------------------------------------------------------------------------------
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire	[31: 0]pc_in;
wire	[31: 0]pc_out;
wire	[31: 0]instr_o;
wire	[31: 0]sign_extend;
wire	RegDst;
wire	RegWrite;
wire	Branch;
wire	[ 2: 0]ALUOp;
wire	ALUSrc;
wire	[31: 0]shift_left;
wire	[31: 0]Adder1_o;
wire	[31: 0]Adder2_o;
wire	zero;
wire	[31: 0]ALU_result;
wire	branch_mux;
wire	[ 4: 0]write_o;
wire	[31: 0]read_data_1;
wire	[31: 0]read_data_2;
wire	[ 3: 0]ALU_control;
wire	[31: 0]ALUSrc_mux;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(pc_in[31: 0]) ,   
	    .pc_out_o(pc_out[31: 0]) 
	    );

Adder Adder1(
        .src1_i(pc_out[31: 0]),     
	    .src2_i(32'd4),     
	    .sum_o(Adder1_o[31: 0])    
	    );

Instr_Memory IM(
        .pc_addr_i(pc_out[31: 0]),  
	    .instr_o(instr_o[31: 0])    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_o[20:16]),
        .data1_i(instr_o[15:11]),
        .select_i(RegDst),
        .data_o(write_o[4: 0])
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr_o[25:21]) ,  
        .RTaddr_i(instr_o[20:16]) ,  
        .RDaddr_i(write_o) ,  
        .RDdata_i(ALU_result)  , 
        .RegWrite_i (RegWrite),
        .RSdata_o(read_data_1[31:0]) ,  
        .RTdata_o(read_data_2[31:0])   
        );
	
Decoder Decoder(
        .instr_op_i(instr_o[31:26]), 
	    .RegWrite_o(RegWrite), 
	    .ALU_op_o(ALUOp),   
	    .ALUSrc_o(ALUSrc),   
	    .RegDst_o(RegDst),   
		.Branch_o(Branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instr_o[5:0]),   
        .ALUOp_i(ALUOp),   
        .ALUCtrl_o(ALU_control) 
        );
	
Sign_Extend SE(
        .data_i(instr_o[15:0]),
        .data_o(sign_extend[31:0])
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(read_data_2[31:0]),
        .data1_i(sign_extend[31:0]),
        .select_i(ALUSrc),
        .data_o(ALUSrc_mux[31: 0])
        );	
		
ALU ALU(
        .src1_i(read_data_1[31:0]),
	    .src2_i(ALUSrc_mux[31: 0]),
	    .ctrl_i(ALU_control),
	    .result_o(ALU_result),
		.zero_o(zero)
	    );
		
Adder Adder2(
        .src1_i(Adder1_o[31: 0]),     
	    .src2_i(shift_left[31: 0]),     
	    .sum_o(Adder2_o[31:0])      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(sign_extend[31:0]),
        .data_o(shift_left[31: 0])
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(Adder1_o[31:0]),
        .data1_i(Adder2_o[31:0]),
        .select_i(Branch & zero),
        .data_o(pc_in[31: 0])
        );	

endmodule
		  


