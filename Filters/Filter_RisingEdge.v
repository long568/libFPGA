

module Filter_RisingEdge (
	clk,
	rst_n,
	sig_i,
	sig_o
);

input  clk;
input  rst_n;
input  sig_i;
output sig_o;

reg[3:0] sig_r;

assign sig_o = (~sig_r[3]) & (~sig_r[2]) & sig_r[1] & sig_r[0];

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		sig_r <= 4'H0;
	end else begin
		sig_r <= {sig_r[2:0], sig_i};
	end
end

endmodule
