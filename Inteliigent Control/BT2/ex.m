A=200;
b=1.5;
C=0.8;
k=60;
g=981;
u=zeros;
for i=1:10
    u(i) = i;
end
(k*u(1)-b*C*sqrt(2*g*u(2)))/A