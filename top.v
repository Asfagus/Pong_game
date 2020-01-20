//Limits might get cut sometimes. If that happens click on Auto Adjust.

module top (
	input clk, reset, button, button1, button2, button3,
	output [11:0] rgb,
	output hsync, vsync, 
	output [6:0] seg1, seg2
	);
	
	
	wire [9:0] x,y;
	
	wire video_on;
	wire clk_1ms;
	
	wire [11:0] rgb_paddle1, rgb_paddle2, rgb_ball;
	wire ball_on, paddle1_on, paddle2_on;
	wire [9:0] x_paddle1, x_paddle2, y_paddle1, y_paddle2;
	wire [3:0] p1_score, p2_score;
	wire [1:0] game_state;
	
	vga_sync v1	(.clk(clk), .hsync(hsync), .vsync(vsync), .x(x), .y(y), .video_on(video_on));
	
	render r1	(.clk(clk), .reset(reset), .x(x), .y(y), .video_on(video_on), .rgb(rgb), .clk_1ms(clk_1ms),
					.paddle1_on(paddle1_on), .paddle2_on(paddle2_on), .ball_on(ball_on), 
					.rgb_paddle1(rgb_paddle1), .rgb_paddle2(rgb_paddle2), .rgb_ball(rgb_ball),
					.game_state(game_state));
				
	clock_divider c1 (.clk(clk), .clk_1ms(clk_1ms));
	
	ball b1 	(.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .x(x), .y(y),  .ball_on(ball_on), .rgb_ball(rgb_ball),
				.x_paddle1(x_paddle1), .x_paddle2(x_paddle2), .y_paddle1(y_paddle1), .y_paddle2(y_paddle2),
				.p1_score(p1_score), .p2_score(p2_score), .game_state(game_state));
	
	paddle p1	(.clk_1ms(clk_1ms), .reset(reset), .x(x), .y(y),
					 .button(button), .button1(button1),  .button2(button2), .button3(button3),
					.paddle1_on(paddle1_on), .rgb_paddle1(rgb_paddle1), .paddle2_on(paddle2_on), .rgb_paddle2(rgb_paddle2),
					.x_paddle1(x_paddle1), .x_paddle2(x_paddle2), .y_paddle1(y_paddle1), .y_paddle2(y_paddle2) );

	game_state(.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .p1_score(p1_score), .p2_score(p2_score), .game_state(game_state));
	
	seven_seg (.clk(clk), .clk_1ms(clk_1ms), .reset(reset), .p1_score(p1_score), .p2_score(p2_score), .seg1(seg1), .seg2(seg2));
	
	
endmodule

