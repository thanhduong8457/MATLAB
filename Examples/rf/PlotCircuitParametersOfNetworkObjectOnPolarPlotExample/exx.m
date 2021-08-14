x=-sqrt(2):0.1:sqrt(2);
y=-sqrt(2):0.1:sqrt(2);

[X,Y]= meshgrid(x,y);
[X1,~]= meshgrid(x,y);

Z = sqrt(4-X^2-Y^2);
Y1 = sqrt(2*X1 + X1^2);

surf(X,Y,Z)

hold on;
ezsurf(X1,Y1,Z)
colormap(cool)
rotate3d on
