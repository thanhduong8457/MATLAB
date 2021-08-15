clc
a = 0;
while ~a
x1 = input('nhap x1: ');
x2 = input('nhap x2: ');

y1 = my_perceptron(z1,[-1;x1;x2]);
y2 = my_perceptron(z2,[-1;x1;x2]);
y3 = my_perceptron(z3,[-1;x1;x2]);
y4 = my_perceptron(z4,[-1;y1;y2]);
y5 = my_perceptron(z5,[-1;y4;y3]);
y6 = my_perceptron(z6,[-1;y4;y3]);

y = [y6 y5 y4]

if(y6)
    disp('square')
elseif(y5)
    disp('circle')
else
    disp('triangle')
end

if(x1 == 100 && x2 == 100)
    a = 1;
else
    a = 0;
end
disp('enter x1=100 and x2=100 to exit')
end