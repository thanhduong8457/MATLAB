%%
clear;clc;
pend_model_init; %call pend_model_init.m to re-initialize
%% Declare symbolic variables
syms vol th1 th2;
syms dth1 dth2;
%% vector X = [d2th1; d2th2]
% Solve equations A.X = B
A = [a+c*(sin(th2))^2 -b*cos(th2);-b*cos(th2) f]
B = [-c*sin(2*th2)*dth1*dth2-b*dth2^2*sin(th2)-d*dth1+e*vol;(c*dth1^2*sin(2*th2))/2+h*sin(th2)-c2*dth2]
%% Math model of system
X = inv(A)*B;
X = simplify(X);
%% Linearization at equilibrium point
f1 = X(1);
df1_dth1 = diff(f1, th1);
df1_ddth1 = diff(f1, dth1);
df1_dth2 = diff(f1, th2);
df1_ddth2 = diff(f1, dth2);
f2 = X(2);
df2_dth1 = diff(f2, th1);
df2_ddth1 = diff(f2, dth1);
df2_dth2 = diff(f2, th2);
df2_ddth2 = diff(f2, dth2);
A1 = [0 1 0 0;
    subs(df1_dth1, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]) subs(df1_ddth1, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]) subs(df1_dth2, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]) subs(df1_ddth2, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]);
 0 0 0 1;
subs(df2_dth1, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]) subs(df2_ddth1, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]) subs(df2_dth2, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0]) subs(df2_ddth2, [th1, dth1, th2, dth2, vol], [0, 0, 0, 0, 0])];
%% A matrix
As = double(A1)