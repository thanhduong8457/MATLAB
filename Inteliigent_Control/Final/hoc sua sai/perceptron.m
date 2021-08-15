x_1 = 1;
x_2 = 1;
d1 = 1;
b = 0.5;
w_1 = 0.4;
w_2 = -0.2;
eta = 0.2;

x1 = [-1 x_1 x_2]';
w1 = [b w_1 w_2]';
% thuat toan sua sai huan luyen mang perceptron
y1 = step(w1'*x1);
w2 = w1 + eta*(d1-y1)*x1

