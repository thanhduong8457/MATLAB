l1 = 0.5;
l2 = 0.3;
K = 1000;

theta1 = rand(1,K)*2*pi-pi;
theta2 = rand(1,K)*2*pi-pi;
x = l1*cos(theta1)+l2*cos(theta1+theta2);
y = l1*sin(theta1)+l2*sin(theta1+theta2);

X = [theta1; theta2];
D = [x;y];

theta1v = rand(1,K)*2*pi-pi;
theta2v = rand(1,K)*2*pi-pi;
xv = l1*cos(theta1v)+l2*cos(theta1v+theta2v);
yv = l1*sin(theta1v)+l2*sin(theta1v+theta2v);

%Khoi tao mang va huan luyen
N = 20;
mynet = newff(X,D,N,{'tansig' 'purelin'});
mynet = train(mynet,X,D);

%Danh gia mang sau hua luyen
out = sim(mynet,[theta1v;theta2v]);
xnn = out(1,:);
ynn = out(2,:);
figure(1)
plot(xv,yv,'bo',xnn,ynn,'rx')

%trung binh binh phuong sai so
mse = ((yv - ynn)*(yv - ynn)'+(xv - xnn)*(xv - xnn)')/length(yv)
