//0616086

module Hazard_Detection(
    MemRead_ex,
    instr_i,
    rs_ifid,
    rt_ifid,
    rt_idex,
    branch,
    pcwrite,
    ifid_write,
    ifid_flush,
    idex_flush,
    exmem_flush
);

input       MemRead_ex;
input [15:0]instr_i;
input [4:0] rs_ifid, rt_ifid, rt_idex;
input       branch;
output      pcwrite;
output      ifid_write;
output      ifid_flush;
output      idex_flush;
output      exmem_flush;

reg      pcwrite;
reg      ifid_write;
reg      ifid_flush;
reg      idex_flush;
reg      exmem_flush;

always@(*) begin
     pcwrite <= 1'b1;
	 ifid_write <= 1'b1;
	 ifid_flush <= 1'b0;
	 idex_flush <= 1'b0;
	 exmem_flush <= 1'b0;
	 
    if(branch==1'b1) begin
	  ifid_flush <= 1'b1;
	  idex_flush <= 1'b1;
	  exmem_flush <= 1'b1;
	end
    else begin
      if( MemRead_ex==1'b1 && (rs_ifid==rt_idex || (rt_ifid==rt_idex)) ) begin		
	     pcwrite <= 1'b0;
		 ifid_write <= 1'b0;
	  	 ifid_flush <= 1'b0;
	  	 idex_flush <= 1'b1;
	  	 exmem_flush <= 1'b0;
	  end
   end
end

endmodule





                    
                    