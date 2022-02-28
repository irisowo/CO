// ALU Controller
/// 0616086
//--------------------------------------------------------------------------------

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
reg        [4-1:0] ALUCtrl_o;

//Parameter
       
//Select exact operation
always @(*) begin
  case (ALUOp_i)
    3'b010:
      case (funct_i)
        6'h20: ALUCtrl_o <= 4'b0010;  //add
        6'h22: ALUCtrl_o <= 4'b0110;  //sub
        6'h24: ALUCtrl_o <= 4'b0000;  //and
        6'h25: ALUCtrl_o <= 4'b0001;  //or
        6'h2a: ALUCtrl_o <= 4'b0111;  //slt
        default: ALUCtrl_o <= 4'b0000;
      endcase
    3'b000: ALUCtrl_o <= 4'b0010;  //addi 
    3'b110: ALUCtrl_o <= 4'b0111;  //slti
    3'b001: ALUCtrl_o <= 4'b0110;  //beq
    default: ALUCtrl_o <= 4'b0000;
  endcase
end

endmodule     





                    
                    