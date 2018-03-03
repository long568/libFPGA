

module UsartRx(
	clk,
	rst_n,
	bps_sig,
	data,
	ts_ing,
	ts_rdy,
	rx_bit
);

input       clk;
input       rst_n;
input       bps_sig;
output[7:0] data;
output      ts_ing;
output      ts_rdy;
input       rx_bit;

reg[7:0] data;
reg      ts_ing;
reg      ts_rdy;
reg[3:0] cnt;
wire     start;

Filter_FallingEdge filter_rx_start(
	.clk(clk),
	.rst_n(rst_n),
	.sig_i(rx_bit),
	.sig_o(start)
);

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		ts_ing <= 1'B0;
		ts_rdy <= 1'B0;
		data   <= 8'H00;
		cnt    <= 4'D0;
	end else begin
		if(ts_ing) begin
			if(bps_sig) begin
				case(cnt)
					4'D0: if(rx_bit) ts_ing <= 1'B0;
					4'D1: data[0] <= rx_bit;
					4'D2: data[1] <= rx_bit;
					4'D3: data[2] <= rx_bit;
					4'D4: data[3] <= rx_bit;
					4'D5: data[4] <= rx_bit;
					4'D6: data[5] <= rx_bit;
					4'D7: data[6] <= rx_bit;
					4'D8: data[7] <= rx_bit;
					4'D9: begin
						if(rx_bit == 1'B1) ts_rdy <= 1'B1;
						ts_ing <= 1'B0;
					end
					default: ts_ing <= 1'B0;
				endcase
				cnt <= cnt + 1'B1;
			end
		end else if(start) begin
			ts_ing <= 1'B1;
			ts_rdy <= 1'B0;
			cnt    <= 4'D0;
		end else begin
			ts_rdy <= 1'B0;
		end
	end
end

endmodule
