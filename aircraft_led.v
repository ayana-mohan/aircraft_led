`timescale 1ns / 1ps

module aircraft_led
(
  input sys_clk,
  input rst_n,
  output reg out        
);

reg toggle = 1'b0;
reg [31:0] counter = 0 ;
reg [24:0] count_reg = 0;
reg clk1 = 0;

always @(posedge sys_clk) 
begin
  if (rst_n == 1'b0) begin
    count_reg <= 0;
    clk1 <= 0;
    
  end else begin
    if (count_reg == 10000000) begin
      count_reg <= 0;
      clk1 <= ~clk1;
    end else begin
      count_reg <= count_reg + 1'b1;
    end
  end
end

always @(posedge clk1)
begin
  toggle <= ~toggle;
  if (rst_n == 1'b0) begin
    out <= 1'b0;
    
  end else begin 
    if (toggle == 1'b1) begin
      counter <= counter+1;
      out <= counter[1];
    end else begin
      out <= 1'b0;
    end
  end
end

endmodule




