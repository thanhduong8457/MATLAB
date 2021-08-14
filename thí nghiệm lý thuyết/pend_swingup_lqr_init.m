%% Swing-up
Ksw = 100;

%% LQR
Q = diag([0.01 0.01 1 1]);
R = 1;
K = lqr(As,Bs,Q,R)
