

module SegAdder(
	clk,
	rst_n,
	opt_add,
	opt_dec,
	sig_add,
	sig_dec,
	data_out
);

parameter DATA_FORMAT = 4'D10;
parameter ORG_VALUE   = 4'D0;

input       clk;
input       rst_n;
input       opt_add;
input       opt_dec;
output      sig_add;
output      sig_dec;
output[7:0] data_out;

reg       sig_add;
reg       sig_dec;
reg [3:0] cur_cal;
wire[1:0] opt_line;

SegDrv m_seg(
	.clk     (clk),
	.rst_n   (rst_n),
	.data_in (cur_cal),
	.data_out(data_out)
);

assign opt_line = {opt_add, opt_dec};

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		cur_cal <= ORG_VALUE;
		sig_add <= 1'B0;
		sig_dec <= 1'B0;
	end else begin
		sig_add <= 1'B0;
		sig_dec <= 1'B0;
		casex(opt_line)
			2'B1x:
				if(cur_cal == (DATA_FORMAT - 1'B1)) begin
					cur_cal <= 1'B0;
					sig_add <= 1'B1;
				end else begin
					cur_cal <= cur_cal + 1'B1;
				end
			2'B01:
				if(cur_cal == 1'B0) begin
					cur_cal <= DATA_FORMAT - 1'B1;
					sig_dec <= 1'B1;
				end else begin
					cur_cal <= cur_cal - 1'B1;
				end
			default:;
		endcase
	end
end

endmodule
