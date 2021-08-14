clc;
clear all;
%% Initialize parameters of RIP
J1 = 2.48*10^-2;
J2 = 3.86*10^-3;
m2 = 0.075;
l1 = 0.15;
l2 = 0.148;
g = 9.8;
c1 = 1*10^-4;
c2 = 2.8*10^-3;
Kt = 0.09*5;
Ke = 0.09;
Ra = 7.8;
%% Some constants to simplify model
a = J1 + m2*l1^2;
b = m2*l1*l2;
c = m2*l2^2;
d = Kt*Ke/Ra + c1;
e = Kt/Ra;
f = J2 + m2*l2^2;
h = m2*g*l2;

%% Pendulum Linearized Model
As = [0   1.0000          0         0;
      0   -0.2037    1.2667   -0.0326;
      0         0         0    1.0000;
      0   -0.0616   20.1514   -0.5187];
Bs = [0;   2.2203;   0;  0.6718];

%% LQR Banlance Control
Q = diag([1,1,1,1]);
R = 1;
K = lqr(As,Bs,Q,R)




