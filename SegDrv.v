

module SegDrv(
	clk,
	rst_n,
	data_in,
	data_out
);

localparam SEGN_0 = 8'H3f,
		   SEGN_1 = 8'H06,
		   SEGN_2 = 8'H5b,
		   SEGN_3 = 8'H4f,
		   SEGN_4 = 8'H66,
		   SEGN_5 = 8'H6d,
		   SEGN_6 = 8'H7d,
		   SEGN_7 = 8'H07,
		   SEGN_8 = 8'H7f,
		   SEGN_9 = 8'H6f,
		   SEGN_a = 8'H77,
		   SEGN_b = 8'H7c,
		   SEGN_c = 8'H39,
		   SEGN_d = 8'H5e,
		   SEGN_e = 8'H79,
		   SEGN_f = 8'H71;

input       clk;
input       rst_n;
input [3:0] data_in;
output[7:0] data_out;

reg[7:0] data_out;
		  
always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		data_out <= 1'B0;
	end else begin
		case(data_in)
			4'H0: data_out <= SEGN_0;
			4'H1: data_out <= SEGN_1;
			4'H2: data_out <= SEGN_2;
			4'H3: data_out <= SEGN_3;
			4'H4: data_out <= SEGN_4;
			4'H5: data_out <= SEGN_5;
			4'H6: data_out <= SEGN_6;
			4'H7: data_out <= SEGN_7;
			4'H8: data_out <= SEGN_8;
			4'H9: data_out <= SEGN_9;
			4'Ha: data_out <= SEGN_a;
			4'Hb: data_out <= SEGN_b;
			4'Hc: data_out <= SEGN_c;
			4'Hd: data_out <= SEGN_d;
			4'He: data_out <= SEGN_e;
			4'Hf: data_out <= SEGN_f;
		endcase
	end
end

endmodule
