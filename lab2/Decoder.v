// Decoder
// 0616086
//--------------------------------------------------------------------------------

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
reg    [3-1:0] ALU_op_o;
reg            ALUSrc_o;
reg            RegWrite_o;
reg            RegDst_o;
reg            Branch_o;

//Parameter


//Main function
always@(*) begin
    case (instr_op_i)
	    // R-Type: add, sub, and, or, slt
		6'b000000:begin
          ALU_op_o <= 3'b010;
		  ALUSrc_o <= 1'b0;
		  RegWrite_o <= 1'b1;
		  RegDst_o <= 1'b1;
		  Branch_o <= 1'b0;
       end
        // addi(8)
        6'b001000:begin
		  ALU_op_o <= 3'b000;
		  ALUSrc_o <= 1'b1;
		  RegWrite_o <= 1'b1;
		  RegDst_o <= 1'b0;
		  Branch_o <= 1'b0;
         end
        // beq(4)
        6'b000100:begin
		  ALU_op_o <= 3'b001;
		  ALUSrc_o <= 1'b0;
		  RegWrite_o <= 1'b0;
		  RegDst_o <= 1'b0;
		  Branch_o <= 1'b1;
        end
        // slti(10)
        6'b001010:begin
          ALU_op_o <= 3'b110;
		  ALUSrc_o <= 1'b1;
		  RegWrite_o <= 1'b1;
		  RegDst_o <= 1'b0;
		  Branch_o <= 1'b0;
        end 
        default:
          {RegWrite_o, ALU_op_o, ALUSrc_o, RegDst_o, Branch_o} <= 8'bx_xxx_xxx;
    endcase
end

endmodule





                    
                    