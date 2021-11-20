a = 1000;
[X,Y] = meshgrid(1:0.01:4, 1:0.01:4);

Z1 = sqrt(9*(a*2 - X^2 - Y^2/4))
Z2 = -sqrt(9*(a*2 - X^2 - Y^2/4));

mesh(X,Y,Z1)
hold on;
%mesh(X,Y,Z2)
rotate3d on;