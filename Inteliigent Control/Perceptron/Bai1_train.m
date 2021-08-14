x1 = [-1  -1  -1  -1  -1  -1  -1;...
       0   0   1   0   2   0  -1;...
       0   1   0  -1   0   2   0];
x2 = x1;
x3 = x2;

D1 = [ 0   0   0   0   0   1   1];
D2 = [ 0   0   0   0   1   1   0];
D3 = [ 1   1   0   0   0   1   1];

z1 = train_perceptron(x1, D1);
z2 = train_perceptron(x2, D2);
z3 = train_perceptron(x3, D3);

x4 = [-1  -1  -1  -1;...
       0   0   1   1;...
       0   1   1   0];
D4 = [ 0   1   1   1];

z4 = train_perceptron(x4, D4);

x5 = [-1  -1  -1  -1;...
       0   0   1   1;...
       0   1   0   1];
D5 = [ 1   0   0   0];

z5 = train_perceptron(x5, D5);


x6 = [-1  -1  -1  -1;...
       0   0   1   1;...
       0   1   0   1];
D6 = [ 0   1   0   0];

z6 = train_perceptron(x6, D6);

