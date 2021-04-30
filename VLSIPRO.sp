.include TSMC_180nm.txt
.param SUPPLY=1.8
.param LAMBDA=0.09u
.param width_P={20*LAMBDA}
.param width_N={10*LAMBDA}
.global gnd vdd

Vdd	vdd	gnd	'SUPPLY'
* A = 1100
vin1 d0 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns
vin2 d1 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns
vin3 d2 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns
vin4 d3 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns

* B = 0101
vin5 e0 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns
vin6 e1 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns
vin7 e2 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns
vin8 e3 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns

vin9 C0 0 pulse 0 0 0ns 100ps 100ps 99.9ns 200ns

vin10 a0_bar 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns
vin11 a1_bar 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns
vin12 a2_bar 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns
vin13 a3_bar 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns

vin14 b0_bar 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns
vin15 b1_bar 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns
vin16 b2_bar 0 pulse 1.8 0 0ns 100ps 100ps 19.9ns 40ns
vin17 b3_bar 0 pulse 0 1.8 0ns 100ps 100ps 19.9ns 40ns

vin18 clock 0 pulse 0 1.8 0ns 100ps 100ps 9.9ns 20ns
vin19 notclock 0 pulse 1.8 0 0ns 100ps 100ps 9.9ns 20ns

.subckt xor P a b a_bar b_bar vdd gnd
.param width_P={20*LAMBDA}
.param width_N={10*LAMBDA}
M1      P       b       f     f  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M2      f       a       gnd     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M3      P       b_bar       g     g  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M4      g       a_bar       gnd     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M5      d       b_bar       vdd     vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M6      P       a       d    d  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M7      e       b       vdd     vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M8      P       a_bar      e    e  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
.ends xor

.subckt and G a b vdd gnd
.param width_P={20*LAMBDA}
.param width_N={10*LAMBDA}
M1      G       r       gnd     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M2      G       r       vdd     vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M3 r a vdd vdd    CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M4  r  b   vdd  vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M5      r     a      q    q  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M6      q     b      gnd     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends and

.subckt or C a b vdd gnd
M1      u       a      vdd    vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
M2      v       b      u    vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
M3      gnd       a       v     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
M4      gnd       b       v     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M5      C       v      vdd    vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}
M6      gnd     v       C     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends or

.subckt inv yi xi vdd gnd
M1      yi       xi       gnd     gnd  CMOSN   W={width_n}   L={2*LAMBDA}
+ AS={5*width_n*LAMBDA} PS={10*LAMBDA+2*width_n} AD={5*width_n*LAMBDA} PD={10*LAMBDA+2*width_n}
M2      yi       xi       vdd     vdd  CMOSP   W={width_p}   L={2*LAMBDA}
+ AS={5*width_p*LAMBDA} PS={10*LAMBDA+2*width_p} AD={5*width_p*LAMBDA} PD={10*LAMBDA+2*width_p}
.ends inv

.subckt nand fout a b vdd gnd
.param width_P={20*LAMBDA}
.param width_N={10*LAMBDA}

M1 fout a vdd vdd    CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M2  fout  b   vdd  vdd  CMOSP   W={width_P}   L={2*LAMBDA}
+ AS={5*width_P*LAMBDA} PS={10*LAMBDA+2*width_P} AD={5*width_P*LAMBDA} PD={10*LAMBDA+2*width_P}

M3      fout     a      c    c  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}

M4      c     b      gnd     gnd  CMOSN   W={width_N}   L={2*LAMBDA}
+ AS={5*width_N*LAMBDA} PS={10*LAMBDA+2*width_N} AD={5*width_N*LAMBDA} PD={10*LAMBDA+2*width_N}
.ends nand

.subckt dlatch q d cl vdd gnd
x100 fout d cl vdd gnd nand
x200 d_bar d vdd gnd inv
x101 fout1 d_bar cl vdd gnd nand
x102 q fout nq vdd gnd nand
x103 nq q fout1 vdd gnd nand
.ends dlatch

*input flipflops
x0 y0 d0 clock vdd gnd dlatch
x1 y1 d1 clock vdd gnd dlatch
x2 y2 d2 clock vdd gnd dlatch
x3 y3 d3 clock vdd gnd dlatch
x4 z0 e0 clock vdd gnd dlatch
x5 z1 e1 clock vdd gnd dlatch
x6 z2 e2 clock vdd gnd dlatch
x7 z3 e3 clock vdd gnd dlatch

x8 a0 y0 notclock vdd gnd dlatch
x9 a1 y1 notclock vdd gnd dlatch
x10 a2 y2 notclock vdd gnd dlatch
x11 a3 y3 notclock vdd gnd dlatch
x12 b0 z0 notclock vdd gnd dlatch
x13 b1 z1 notclock vdd gnd dlatch
x14 b2 z2 notclock vdd gnd dlatch
x15 b3 z3 notclock vdd gnd dlatch

*Propagate and generate block
x16 P0 a0 b0 a0_bar b0_bar vdd gnd xor
x17 P1 a1 b1 a1_bar b1_bar vdd gnd xor
x18 P2 a2 b2 a2_bar b2_bar vdd gnd xor
x19 P3 a3 b3 a3_bar b3_bar vdd gnd xor

x20 G0 a0 b0 vdd gnd and
x21 G1 a1 b1 vdd gnd and
x22 G2 a2 b2 vdd gnd and
x23 G3 a3 b3 vdd gnd and

*CLA block
x24 OP0 P0 C0 vdd gnd and
x25 C1 G0 OP0 vdd gnd or

x26 OP1 P1 OP0 vdd gnd and
x27 temp1 P1 G0 vdd gnd and
x28 temp2 temp1 G1 vdd gnd or
x29 C2 temp2 OP1 vdd gnd or

x30 OP2 OP1 P2 vdd gnd and
x31 temp3 temp1 P2 vdd gnd and
x32 temp4 P2 G1 vdd gnd and
x33 temp5 G2 temp4 vdd gnd or
x34 temp6 temp5 temp3 vdd gnd or
x35 C3 temp6 OP2 vdd gnd or

x36 OP3 P3 OP2 vdd gnd and
x37 temp7 temp3 P3 vdd gnd and
x38 temp8 temp4 P3 vdd gnd and
x39 temp9 P3 G2 vdd gnd and
x40 temp10 temp9 G3 vdd gnd or
x41 temp11 temp10 temp8 vdd gnd or
x42 temp12 temp11 temp7 vdd gnd or
x43 C4 temp12 OP3 vdd gnd or

*Sum block
x44 P0_bar P0 vdd gnd inv
x45 C0_bar C0 vdd gnd inv
x46 S0 P0 C0 P0_bar C0_bar vdd gnd xor 

x47 P1_bar P1 vdd gnd inv
x48 C1_bar C1 vdd gnd inv
x49 S1 P1 C1 P1_bar C1_bar vdd gnd xor 

x50 P2_bar P2 vdd gnd inv
x51 C2_bar C2 vdd gnd inv
x52 S2 P2 C2 P2_bar C2_bar vdd gnd xor 

x53 P3_bar P3 vdd gnd inv
x54 C3_bar C3 vdd gnd inv
x55 S3 P3 C3 P3_bar C3_bar vdd gnd xor 

*output flipflops
x56 out0 S0 notclock vdd gnd dlatch
x57 out1 S1 notclock vdd gnd dlatch
x58 out2 S2 notclock vdd gnd dlatch
x59 out3 S3 notclock vdd gnd dlatch

x60 sum0 out0 clock vdd gnd dlatch
x61 sum1 out1 clock vdd gnd dlatch
x62 sum2 out2 clock vdd gnd dlatch
x63 sum3 out3 clock vdd gnd dlatch

x64 car4 C4 notclock vdd gnd dlatch
x65 carry4 car4 clock vdd gnd dlatch

x66 car2 C2 notclock vdd gnd dlatch
x67 carry2 car2 clock vdd gnd dlatch

.tran 0.1n 200n

.control
set hcopypscolor = 1 
set color0=white 
set color1=black 

run
set curplottitle= "Pragya_Singhal_2019112001"
plot v(clock)
plot v(d0)
plot v(e0)
* plot v(C0)
* plot v(P2)
* plot v(G2)
plot v(sum0)
plot v(sum1)
* plot v(sum2)
* plot v(sum3)
.endc

