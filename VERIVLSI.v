`timescale 1ns / 1ps
module four_bit_xor(out,a,b);
input [3:0]a,b;
output [3:0]out;
xor (out[0],a[0],b[0]);
xor (out[1],a[1],b[1]);
xor (out[2],a[2],b[2]);
xor (out[3],a[3],b[3]);
endmodule
51
module four_bit_and(out,a,b);
input [3:0]a,b;
output [3:0]out;
and (out[0],a[0],b[0]);
and (out[1],a[1],b[1]);
and (out[2],a[2],b[2]);
and (out[3],a[3],b[3]);
endmodule
module carry(pc,p,c,g);
input [3:0]p,g;
output [4:0]c;
output [15:0]pc;
and (pc[0], p[0], c[0]);
xor (c[1], g[0], pc[0]);
and (pc[1], pc[0], p[1]);
and (pc[2], p[1], g[0]);
xor (pc[3], pc[1], pc[2]);
xor (c[2], pc[3], g[1]);
and (pc[4], pc[1], p[2]);
and (pc[5], pc[2], p[2]);
and (pc[6], p[2], g[1]);
xor (pc[7], pc[4], pc[5]);
xor (pc[8], pc[6], pc[7]);
xor (c[3], pc[8], g[2]);
52
and (pc[9], pc[4], p[3]);
and (pc[10], pc[5], p[3]);
and (pc[11], pc[6], p[3]);
and (pc[12], p[3], g[2]);
xor (pc[13], pc[9], pc[10]);
xor (pc[14], pc[11], pc[13]);
xor (pc[15], pc[12], pc[14]);
xor (c[4], pc[15], g[3]);
endmodule
module pro(a,b,clk,c_out,sum,result);
input [3:0]a,b;
input clk;
output c_out;
output [3:0]sum;
output [4:0]result;
wire [3:0] ff_sum,ff_a,ff_b;
wire ff_c_out;
dff i10(a[0],clk,ff_a[0]);
dff i11(a[1],clk,ff_a[1]);
dff i12(a[2],clk,ff_a[2]);
dff i13(a[3],clk,ff_a[3]);
dff i20(b[0],clk,ff_b[0]);
dff i21(b[1],clk,ff_b[1]);
53
dff i22(b[2],clk,ff_b[2]);
dff i23(b[3],clk,ff_b[3]);
cla CLA(ff_a, ff_b, ff_c_out, ff_sum);
dff o1(ff_c_out, ~clk, c_out);
dff o20(ff_sum[0], ~clk, sum[0]);
dff o21(ff_sum[1], ~clk, sum[1]);
dff o22(ff_sum[2], ~clk, sum[2]);
dff o23(ff_sum[3], ~clk, sum[3]);
assign result = {c_out, sum};
endmodule
module dff(D,clk,Q);
input D,clk;
output Q;
wire w1, w2, w3, w4, w5, w6, w7, w8, d_bar, clk_bar;
not (d_bar, D);
not (clk_bar, clk);
nand (w1, D, clk);
nand (w2, d_bar, clk);
nand (w3, w1, w4);
nand (w4, w2, w3);
nand (w5, w3, clk_bar);
nand (w6, w4, clk_bar);
nand (w7, w5, w8);
54
nand (w8, w6, w7);
assign Q = w7;
endmodule
module cla(a,b,C_out,s);
input [3:0] a,b;
output C_out;
output [3:0]s;
wire [4:0] c;
wire [3:0] g,p;
wire [15:0] pc;
assign c[0] = 1'b0;
four_bit_xor x3(p,a,b);
four_bit_and x2(g,a,b);
four_bit_xor x1(s,p,c[3:0]);
carry x4(pc,p,c,g);
assign C_out = c[4];
endmodule
