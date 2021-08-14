clc;
format rat
syms t tg q me vx vy vz
B= [0 0 1];
xyz= input('Nhap vao vi tri ban dau cua electron, vitri= ');
x0= xyz(:,1); y0= xyz(:,2); z0= xyz(:,3);
v0= input('Nhap vao vecto van toc, v= ');
v0x= v0(:,1); v0y= v0(:,2); v0z= v0(:,3);
E= input('Nhap vao vecto dien truong, E= ');
Ex=E(:,1);Ey=E(:,2);Ez=E(:,3);
disp('vecto cam ung tu B=[0 0 1]');
me= 9.1*10^-31;
q= -1.6*10^-19;
b=cross(v0,B);
bx=b(:,1);by=b(:,2);bz=b(:,3);
Fx = q*( Ex + v0y );
Fy = q*( Ey - v0x );
Fz = q*Ez;
F=(sqrt(Fx*Fx+Fy*Fy+Fz*Fz))%h?p l?c tác d?ng
ax=Fx/me;
ay=Fy/me;
az=Fz/me;
a=(sqrt(ax*ax+ay*ay+az*az))%gia t?c
tg=input('nhap thoi gian tg de tinh van toc v,t= ');
vx=v0x+ax*tg;
vy=v0y+ay*tg;
vz=v0z+az*tg;
v=sqrt(vx^2+vy^2+vz^2)%v?n t?c
x= x0+v0x*t + 1/2*ax*t^2;
y= y0 + v0y*t +1/2*ay*t^2;
z= z0 + v0z*t +1/2*az*t^2;
ezplot3(x,y,z,[0,10^-4]);%ph??ng trình chuy?n ??ng c?a electron
title('Quy dao chuyen dong cua electron')