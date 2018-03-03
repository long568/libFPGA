`include "UsartCfg.v"

module UsartBaudGenerator(
	clk, 
	rst_n, 
	start,
	signal
);

parameter  BAUD_RATE = `BAUD_FULL_50M_57600;

localparam BAUD_HALF = BAUD_RATE[`BAUD_RATE_WIDTH-1:1];
localparam BAUD_FULL = BAUD_RATE - 1'B1;

input  clk;
input  rst_n;
input  start;
output signal;

reg                       signal;
reg[`BAUD_RATE_WIDTH-1:0] cnt;

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		cnt <= `BAUD_RATE_WIDTH'D0;
	else if((!start) || (cnt == BAUD_FULL))
		cnt <= `BAUD_RATE_WIDTH'D0;
	else
		cnt <= cnt + 1'B1;
end

always @(posedge clk or negedge rst_n) begin
	if(!rst_n)
		signal <= 1'B0;
	else if(cnt == BAUD_HALF)
		signal <= 1'B1;
	else
		signal <= 1'B0;
end

endmodule
