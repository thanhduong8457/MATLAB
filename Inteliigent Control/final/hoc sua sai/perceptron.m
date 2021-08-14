x_1 = 1;
x_2 = 1;
d = 1;
b = 0;
w_1 = 0.3;
w_2 = -0.5;
eta = 0.4;

x = [-1 x_1 x_2]';
w = [b w_1 w_2]';

y = step(w'*x);
w_new = w + eta*(d-y)*x