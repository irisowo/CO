//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:   0616086
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
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
reg        [4-1:0] ALUCtrl;

//Parameter

//Select exact operation

always@(*)begin
    case(ALUOp_i)
	3'd0:begin
	    case(funct_i)
		  6'd32: ALUCtrl = 4'b0010; //add
		  6'd34: ALUCtrl = 4'b0110; //sub
		  6'd36: ALUCtrl = 4'b0000; //and
		  6'd37: ALUCtrl = 4'b0001;  //or
		  6'd42: ALUCtrl = 4'b0111;  //slt
		  default: ALUCtrl = 4'b0000;
		endcase
	    end
	3'b001:begin //lw,sw
		ALUCtrl = 4'b0010;
		end
	3'b010:begin //beq
		ALUCtrl = 4'b0110;
		end
	3'b011:begin //addi
		ALUCtrl = 4'b0010;
		end
	3'b100:begin //slti
		ALUCtrl = 4'b0111;
		end
	3'b101:begin
		ALUCtrl = 4'b0000;
		end
endcase
end
assign ALUCtrl_o = ALUCtrl;

endmodule

                    
                    