x1 = [   -1          -1          -1          -1          -1          -1          -1;...
        3595        4285        4585        6403        6600       11990       10810;...
        1595        1695        1760        2032        2000        2490        2500;...
        1480        1435        1760        2070        2600        3415        3500];

D1 = [ 1     1     0     0     0     0     0];
D2 = [ 1     1     1     0     0     0     0];
D3 = [ 0     0     0     0     0     1     1];

z1 = train_perceptron(x1, D1);
z2 = train_perceptron(x1, D2);
z3 = train_perceptron(x1, D3);

x4 = [-1  -1  -1  -1;...
       0   0   1   1;...
       0   1   1   0];
D4 = [ 0   1   0   0];

z4 = train_perceptron(x4, D4);

x5 = [-1  -1  -1  -1;...
       0   0   1   1;...
       0   1   1   0];
D5 = [ 1   0   0   0];

z5 = train_perceptron(x5, D5);