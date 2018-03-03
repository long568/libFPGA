

module UsartTx(
	clk,
	rst_n,
	bps_sig,
	data,
	ts_ing,
	ts_rdy,
	tx_bit,
	start
);

input      clk;
input      rst_n;
input      bps_sig;
input[7:0] data;
output     ts_ing;
output     ts_rdy;
output     tx_bit;
input      start;

reg      ts_ing;
reg      ts_rdy;
reg      tx_bit;
reg[3:0] cnt;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		ts_ing <= 1'B0;
		ts_rdy <= 1'B0;
		tx_bit <= 1'B1;
	end else begin
		if(ts_ing) begin
			if(bps_sig) begin
				case(cnt)
					4'D0: tx_bit <= 1'B0;
					4'D1: tx_bit <= data[0];
					4'D2: tx_bit <= data[1];
					4'D3: tx_bit <= data[2];
					4'D4: tx_bit <= data[3];
					4'D5: tx_bit <= data[4];
					4'D6: tx_bit <= data[5];
					4'D7: tx_bit <= data[6];
					4'D8: tx_bit <= data[7];
					4'D9: tx_bit <= 1'B1;
					default: begin
						ts_ing <= 1'B0;
						ts_rdy <= 1'B1;
					end
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
