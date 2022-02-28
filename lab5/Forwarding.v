//0616086

module Forwarding(
            RegWrite_mem,
            RegWrite_wb,
            rs_idex,
            rt_idex,
            rd_exmem,
            rd_memwb,
            forwarda,
            forwardb
);

input       RegWrite_mem;
input       RegWrite_wb;
input [4:0] rs_idex;
input [4:0] rt_idex;
input [4:0] rd_exmem;
input [4:0] rd_memwb;
output [1:0] forwarda;
output [1:0] forwardb;

reg [1:0] forwarda;
reg [1:0] forwardb;

always@(*) begin
    // rs
    if(RegWrite_mem == 1'b1 && rd_exmem != 5'd0 && rs_idex == rd_exmem)
        forwarda <= 2'b01;
    else if(RegWrite_wb == 1'b1 && rs_idex == rd_memwb && rd_memwb != 5'd0 && (!((RegWrite_mem)&&(rd_exmem!=0)&&(rs_idex == rd_exmem))) )
        forwarda <= 2'b10;
    else
        forwarda <= 2'b00;
    // rt
    if(RegWrite_mem == 1'b1 && rd_exmem != 5'd0 && rt_idex == rd_exmem)
        forwardb <= 2'b01;
    else if(RegWrite_wb == 1'b1 && rt_idex == rd_memwb && rd_memwb != 5'd0 && (!((RegWrite_mem)&&(rd_exmem!=0)&&(rt_idex == rd_exmem))) )
        forwardb <= 2'b10;
    else
        forwardb <= 2'b00;

end
endmodule






                    
                    