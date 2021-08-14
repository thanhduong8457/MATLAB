load PendulumData_01
K = length(u);
ResampleStep = 2;
ue = u(1:ResampleStep:K);
ye = y(1:ResampleStep:K);

% Tap mau du lieu de huan luyen mang NN
Ke = length(u);
%X = [u(1:K-2)'; u(2:K-1)'; y(1:K-2)'; y(2:K-1)'];
Xe = [ue(2:Ke-1)';...
     ue(1:Ke-2)';...
     ye(2:Ke-1)';...
     ye(1:Ke-2)'];
 
De = [ye(3:Ke)'];

% Khai bao mang NN va huan luyen
N = 20;
mynet = newff(Xe,De,N,{'logsig' 'purelin'});
mynet = train(mynet,Xe,De);

% tao khoi Simulink thuc hien mang NN vua huan luyen
%gensim(mynet); 
load PendulumData_02
K = length(ue);
uv = u(1:ResampleStep:K);
yv = y(1:ResampleStep:K);
Kv = length(uv);
for k = 3:Kv
    X = [uv(k-1);uv(k-2);ynn(k-1);ynn(k-2)];
    ynn(k) = sim(mynet,X);
end
plot (yv,'r');
hold on
plot(ynn,'b');
hold off