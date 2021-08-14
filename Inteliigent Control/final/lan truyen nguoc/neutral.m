%% initial value
x_1 = 0.5;
x_2 = -0.2;
d = 0.5;
eta = 0.4;
%weights of hidden layer
v_11 = -0.1;
v_21 = 0.6;
v_12 = 0.1;
v_22 = 0.4;
% weights of out layer
w_1 = 0.2;
w_2 = -0.3;
% thetal
b_1 = 0.2;
b_2 = -0.2;
b_3 = 0.2;

%% x(1)=[-1 x1 x2]'
x = [-1 x_1 x_2]';
% v1(1)=[thetal_1 v11(1) v21(1)]'
v1 = [b_1 v_11 v_21]';
% v2(1)=[thetal_2 v12(1) v22(1)]'
v2 = [b_2 v_12 v_22]';
% w(1)=[theta_3 w1(1) w2(1)]'
w = [b_3 w_1 w_2]';
%% compute output
net_h1 = v1'*x;
net_h2 = v2'*x;
% output of hidden layer////////////////////////tan_sig
z1 = tan_sig(net_h1)
z2 = tan_sig(net_h2)
% input of perceptron layer out
z = [-1 z1 z2]';
net_out = w'*z;
% output of network/////////////////////////////log_sig
y = log_sig(net_out)
% denta out layer///////////////////////////log_sig_dot
delta_out = (d-y)*log_sig_dot(net_out)
% w(2) = w(1) + muy*delta_out(1)*z(1)
w_new = w + eta*delta_out*z
%% delta hidden layer///////////////////////tan_sig_dot
delta_h1 = delta_out*w(2)*tan_sig_dot(net_h1)
delta_h2 = delta_out*w(3)*tan_sig_dot(net_h2)
% update weight of hidden layer
v1_new = v1 + (eta*delta_h1)*x
v2_new = v2 + (eta*delta_h2)*x
