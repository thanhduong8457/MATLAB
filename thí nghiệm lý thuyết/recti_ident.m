% Khoi tao gia tri khoi luong xe 1, 2
m1 = 0.7;
m2 = 1.3;

% Cai dat chu ky va thoi gian lay mau
N  = 1000;
T  = 0.005;
Tstop = (N-1)*T;
    
% Tao chuoi tin hieu dieu khien
tt = 0:T:T*(N-1);
u  = ones(1,N);

u(1:90)    = 0.5;
u(150:200) = 0.1;
u(200:270) = 0.6;
u(270:350) = 0.4;
u(350:400) = 0.7;
u(400:440) = 0;
u(440:500) = 0.3;
u(500:650) = 0.9;
u(650:720) = 0.2;
u(800:870) = 0.6;
u(940:1000) = 0.1;
u = u * 16.8;
uk = [tt; u]';

%Thu thap so lieu 
tt = ScopeData.time;
x1 = ScopeData.signals.values(:,1)/1000;
x2 = ScopeData.signals.values(:,2)/1000;
uu = ScopeData.signals.values(:,3);
N  = max(size(tt));

% Tim thong so cua he thong:
% Do cung k cua lo xo: k1_hat
% He so ma sat tren m1: b1_hat
a1 = T*T*(2*x1(2:N-1) - x2(2:N-1));
a2 = T*(x1(2:N-1) - x1(1:N-2));
PHI   = [a1 a2];
lamda = (2*x1(2:N-1) - x1(1:N-2) - x1(3:N))*m1;

theta = inv(PHI'*PHI)*PHI'*lamda;
k1_hat = theta(1)
b1_hat = theta(2)

% Sinh vien tham khao doan code o tren
% de tim thong so cua he thong:
% He so khuech dai U = K.F: K_hat
% He so ma sat tren m2: b2_hat


