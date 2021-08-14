
%% Declare symbolic variables
syms a b c d e f h c1 c2;
syms vol th1 th2;
syms dth1 dth2;
%% vector X = [d2th1; d2th2]
% Solve equation A.X = B
A = [a+c*(sin(th2))^2 -b*cos(th2);
 -b*cos(th2) f]
B = [-c*sin(2*th2)*dth1*dth2-b*dth2^2*sin(th2)-d*dth1+e*vol;
 (c*dth1^2*sin(2*th2))/2+h*sin(th2)-c2*dth2]
%% Math model of system
X = inv(A)*B;
X = simplify(X)