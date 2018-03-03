

module TipKey(
	clk,
	rst_n,
	key,
	sig
);

parameter KEY_DOWN_VAL  = 1'B0;
parameter KEY_CNT_WIDTH = 24;
parameter SHAKE_FILTER  = 24'D1000000; // 20ms <=> 50MHz
parameter SER_SPEED     = 5'D15;

localparam SER_MUL     = SER_SPEED + 1'B1;
localparam SER_CNT_MAX = SHAKE_FILTER * SER_MUL - 1'B1;
localparam KEY_CNT_MAX = SHAKE_FILTER - 1'B1;

localparam STA_0    = 2'D0;
localparam STA_DOWN = 2'D1;
localparam STA_SER  = 2'D2;

input  clk;
input  rst_n;
input  key;
output sig;

reg                    sig;
reg[1:0]               key_sta;
reg[KEY_CNT_WIDTH-1:0] key_cnt;

always@(posedge clk or negedge rst_n) begin
	if(!rst_n) begin
		key_sta <= STA_0;
		key_cnt <= 1'B0;
		sig     <= 1'B0;
	end else begin
		sig <= 1'B0;
		case (key_sta)
			STA_0: begin
				if(key == KEY_DOWN_VAL) begin
					key_sta <= STA_DOWN;
					key_cnt <= 1'B0;
				end
			end
			
			STA_DOWN: begin
				if(key == KEY_DOWN_VAL) begin
					if(key_cnt > KEY_CNT_MAX) begin
						key_sta <= STA_SER;
						key_cnt <= 1'B0;
						sig     <= 1'B1;
					end else begin
						key_cnt <= key_cnt + 1'B1;
					end
				end else begin
					key_sta <= STA_0;
				end
			end
			
			STA_SER: begin
				if(key == KEY_DOWN_VAL) begin
					if(key_cnt > SER_CNT_MAX) begin
						key_cnt <= 1'B0;
						sig     <= 1'B1;
					end else begin
						key_cnt <= key_cnt + 1'B1;
					end
				end else begin
					if(key_cnt < SHAKE_FILTER) begin
						key_sta <= STA_0;
					end else begin
						key_cnt <= key_cnt - SHAKE_FILTER;
					end
				end
			end
			
			default: key_sta <= STA_0;
		endcase
	end
end

endmodule
