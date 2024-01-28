`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2023 22:17:59
// Design Name: 
// Module Name: enterLetter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module enterLetter(clock, letter, cellNumber, currX, currY, x0, x1, isThisChar, charData);
    
    input clock;
    input [7:0]letter;
    input [3:0]cellNumber;
    input [12:0]currX, currY, x0, x1;
    output reg isThisChar = 0;
    output reg [15:0]charData;
    
    `include "alphabets.vh"
    wire [12:0]pixelNum;
    assign pixelNum = ((currY - 26) * 6) + (currX - 5 - (8 * cellNumber));
    
    // Store individual characters
    reg [15:0] a [41:0];
    reg [15:0] b [41:0];
    reg [15:0] c [41:0];
    reg [15:0] d [41:0];
    reg [15:0] e [41:0];
    reg [15:0] f [41:0];
    reg [15:0] g [41:0];
    reg [15:0] h [41:0];
    reg [15:0] i [41:0];
    reg [15:0] j [41:0];
    reg [15:0] k [41:0];
    reg [15:0] l [41:0];
    reg [15:0] m [41:0];
    reg [15:0] n [41:0];
    reg [15:0] o [41:0];
    reg [15:0] p [41:0];
    reg [15:0] q [41:0];
    reg [15:0] r [41:0];
    reg [15:0] s [41:0];
    reg [15:0] t [41:0];
    reg [15:0] u [41:0];
    reg [15:0] v [41:0];
    reg [15:0] w [41:0];
    reg [15:0] x [41:0];
    reg [15:0] y [41:0];
    reg [15:0] z [41:0];
    
    initial begin
        $readmemh("C:/Users/davia/EE2026/Letters/a.txt", a);
        $readmemh("C:/Users/davia/EE2026/Letters/b.txt", b);
        $readmemh("C:/Users/davia/EE2026/Letters/c.txt", c);
        $readmemh("C:/Users/davia/EE2026/Letters/d.txt", d);
        $readmemh("C:/Users/davia/EE2026/Letters/e.txt", e);
        $readmemh("C:/Users/davia/EE2026/Letters/f.txt", f);
        $readmemh("C:/Users/davia/EE2026/Letters/g.txt", g);
        $readmemh("C:/Users/davia/EE2026/Letters/h.txt", h);
        $readmemh("C:/Users/davia/EE2026/Letters/i.txt", i);
        $readmemh("C:/Users/davia/EE2026/Letters/j.txt", j);
        $readmemh("C:/Users/davia/EE2026/Letters/k.txt", k);
        $readmemh("C:/Users/davia/EE2026/Letters/l.txt", l);
        $readmemh("C:/Users/davia/EE2026/Letters/m.txt", m);
        $readmemh("C:/Users/davia/EE2026/Letters/n.txt", n);
        $readmemh("C:/Users/davia/EE2026/Letters/o.txt", o);
        $readmemh("C:/Users/davia/EE2026/Letters/p.txt", p);
        $readmemh("C:/Users/davia/EE2026/Letters/q.txt", q);
        $readmemh("C:/Users/davia/EE2026/Letters/r.txt", r);
        $readmemh("C:/Users/davia/EE2026/Letters/s.txt", s);
        $readmemh("C:/Users/davia/EE2026/Letters/t.txt", t);
        $readmemh("C:/Users/davia/EE2026/Letters/u.txt", u);
        $readmemh("C:/Users/davia/EE2026/Letters/v.txt", v);
        $readmemh("C:/Users/davia/EE2026/Letters/w.txt", w);
        $readmemh("C:/Users/davia/EE2026/Letters/x.txt", x);
        $readmemh("C:/Users/davia/EE2026/Letters/y.txt", y);
        $readmemh("C:/Users/davia/EE2026/Letters/z.txt", z);
    end
    
    always @ (posedge clock) begin
        isThisChar <= 0;
        if (currX >= x0 && currX <= x1 && currY >= 26 && currY <= 32) begin
            isThisChar <= 1;
            case (letter)
                A: charData <= a[pixelNum];
                B: charData <= b[pixelNum];
                C: charData <= c[pixelNum];
                D: charData <= d[pixelNum];
                E: charData <= e[pixelNum];
                F: charData <= f[pixelNum];
                G: charData <= g[pixelNum];
                H: charData <= h[pixelNum];
                I: charData <= i[pixelNum];
                J: charData <= j[pixelNum];
                K: charData <= k[pixelNum];
                L: charData <= l[pixelNum];
                M: charData <= m[pixelNum];
                N: charData <= n[pixelNum];
                O: charData <= o[pixelNum];
                P: charData <= p[pixelNum];
                Q: charData <= q[pixelNum];
                R: charData <= r[pixelNum];
                S: charData <= s[pixelNum];
                T: charData <= t[pixelNum];
                U: charData <= u[pixelNum];
                V: charData <= v[pixelNum];
                W: charData <= w[pixelNum];
                X: charData <= x[pixelNum];
                Y: charData <= y[pixelNum];
                Z: charData <= z[pixelNum];
                default: charData <= 16'hffff;
            endcase
        end
    end
    
endmodule
