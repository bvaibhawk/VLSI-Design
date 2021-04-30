`timescale 1ns / 1ps
module pro_tb;
reg [3:0] a,b;
55
reg clk = 0;
wire c_out;
wire [3:0] sum;
wire [4:0] result;
pro uut (
.a(a),
.b(b),
.clk(clk),
.c_out(c_out),
.sum(sum),
.result(result)
);
always #10
clk = ~clk;
initial begin
$dumpfile("pro.vcd");
$dumpvars(0,pro_tb);
#10;
a = 4'b1100;
b = 4'b0101;
#30;
$finish;
end
endmodule
