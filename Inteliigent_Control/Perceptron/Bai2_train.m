x1 = [-1    -1    -1    -1    -1    -1    -1    -1    -1 ;...
      0.3   0.35  0.28  0.8   0.7   1     0.8   1.2   1.6;...
      0.5   0.45  0.35  0.75  0.78  0.7   0.4   0.5   0.45];
D1 = [ 0     0     0     0     0     0     1     1     1 ];
D2 = [ 1     1     1     0     0     0     0     0     0 ];

z1 = train_perceptron(x1, D1);
z2 = train_perceptron(x1, D2);

x3 = [-1  -1  -1  -1;...
       0   0   1   1;...
       0   1   1   0];
D3 = [ 1   0   0   0];

z3 = train_perceptron(x3, D3);
