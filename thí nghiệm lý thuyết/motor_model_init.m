close all
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
uu = [tt; u]';

%Thu thap so lieu 
tt = ScopeData.time;
yk = ScopeData.signals.values(:,1);
uk = ScopeData.signals.values(:,3);
N  = max(size(tt));

% Nhan dang thong so cua he thong:
Theta = zeros(4,N);
P = 1e5*eye(4);
lamda = 0.99;
for i=3:N
    PHI = [-yk(i-1) -yk(i-2) uk(i-1) uk(i-2)]';
    e = yk(i) - PHI'*Theta(:,i-1);
    L = P*PHI / (lamda + PHI'*P*PHI);
    P = 1/lamda *(P - P*PHI*PHI'*P / (lamda + PHI'*P*PHI) );
    Theta(:,i) = Theta(:,i-1) + L*e;
end
figure;
subplot(2,1,1); plot(tt,Theta(1,:),'r',tt,Theta(2,:),':r');
legend('a_1','a_2')
grid on
subplot(2,1,2); plot(tt,Theta(3,:),'b',tt,Theta(4,:),':b')
legend('b_1','b_2');
grid on

Theta(:,N)
a1 = Theta(1,N);
a2 = Theta(2,N);
b1 = Theta(3,N);
b2 = Theta(4,N);
Gz = tf([b1 b2],[1 a1 a2],0.005)

