%% LQR
Q = diag([1 1 1 1]);
R = 1;
K = lqr(As,Bs,Q,R);
%% Noise variance
N1=0.001;
N2=0.001;
%% Kalman gain
G = eye(4);
Cs = [ 1 0 0 0; 0 0 1 0];
Cm = [1 0; 0 1];
QN = 10^-6*eye(4);
RN = 10^(-3)*eye(2);
Lo =lqe(As,G,Cs,QN,RN)