%% Define parameters (use symbolic variable of MATLAB)
syms g;
syms m1 m2 J1 J2 l1 l2 c1 c2;
syms Ra La Kt Ke;
%% Declare system variables (use symbolic variable of MATLAB)
syms th1 dth1 d2th1;
syms th2 dth2 d2th2;
syms Tm;
%%
dth1= fulldiff(th1);
d2th1= fulldiff(dth1);
dth2= fulldiff(th2);
d2th2= fulldiff(dth2);
%%
x2 = l1*cos(th1) + l2*sin(th1)*sin(th2);
y2 = l1*sin(th1) - l2*cos(th1)*sin(th2);
z2 = l2*cos(th2);
%%
dx2 = fulldiff(x2,{th1 th2});
dy2 = fulldiff(y2,{ th1 th2});
dz2 = fulldiff(z2,{ th1 th2});
%%
v2_sq = simplify(dx2^2 + dy2^2 + dz2^2);
v2_sq = simplify((l2*dth1)^2*sin(th2)^2+simplify(v2_sq+(l2*dth1)^2*(cos(th2)^2-1)));
%% Potential Energy
% Arm
Ep_1 = 0;
% Pendulum
Ep_2 = g*m2*l2*cos(th2);
% Total potential energy
Ep = Ep_1 + Ep_2;
%% Kinetic Energy
% Kinetic energy of the Arm
Ek_1_r = 0.5*J1*(dth1)^2;
Ek_1_t = 0;
Ek_1 = Ek_1_r + Ek_1_t;
% Kinetic energy of the Pendulum
Ek_2_r = 0.5*J2*(dth2)^2;
Ek_2_t = 0.5*m2*v2_sq;
Ek_2 = Ek_2_r + Ek_2_t;
% Total kinetic energy of the system
Ek = Ek_1 + Ek_2;
%% Langrangian operator
L = Ek - Ep;
%% Theta 1
% Derive the components that make up the Euler-Lagrange Equation
dL_dtheta1 = simplify(diff(L,th1));
% d/dt(dL/ddtheta1)
dL_ddtheta1_dt = simplify(fulldiff(diff(L,dth1),{th1 th2 dth1 dth2}));
Ftheta1 = simplify(dL_ddtheta1_dt - dL_dtheta1 + c1*dth1 - Tm)
%% Theta 2
% Derive the components that make up the Euler-Lagrange Equation
dL_dtheta2 = simplify(diff(L,th2));
% d/dt(dL/ddtheta1)
dL_ddtheta2_dt = simplify(fulldiff(diff(L,dth2),{th1 th2 dth1 dth2}));
Ftheta2 = simplify(dL_ddtheta2_dt - dL_dtheta2 + c2*dth2)
