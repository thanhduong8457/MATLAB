%Ham can xap xi
x=0:0.001:2;
y=exp(-x).*sin(10*x);
figure(1)
plot(x,y,'b')

%Du lieu huan luyen mang
K = 300; %so mau du lieu
X = rand(1,K)*2; %x ngau nhien trong doan 0-2
D = exp(-X).*sin(10*X);
figure(2)
plot(X,D,'bo')

%Khoi tao mang va huan luyen
N = 6;
mynet = newff(X,D,N,{'tansig' 'purelin'});
mynet = train(mynet,X,D);

%Danh gia mang sau hua luyen
ynn = sim(mynet,x)
figure(3)
plot(x,y,'b',x,ynn,'r')
mse = (y - ynn)*(y - ynn)'/length(y) %trung binh binh phuong sai so