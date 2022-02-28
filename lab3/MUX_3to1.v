//Subject:     CO project 2 - MUX 3to1
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      0616086
//----------------------------------------------
//Date:        2010/8/17
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------

module MUX_3to1(
                data0_i,
                data1_i,
                data2_i,
                select_i,
                data_o
                   );		   
parameter size = 0;				
//I/O ports               
input   [size-1:0] data0_i;          
input   [size-1:0] data1_i;
input   [size-1:0] data2_i;
input   [	  1:0] select_i;
output  [size-1:0] data_o; 

//Internal Signals
reg     [size-1:0] result;

//Main function
always@(*)begin
    if(select_i == 2'd0) result = data0_i;
    else if(select_i == 2'd1) result = data1_i;
    else if(select_i == 2'd2) result = data2_i;
end
assign data_o = result;
endmodule
          