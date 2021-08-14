clc
a = 0;
while ~a
x1 = input('nhap x1: ');
x2 = input('nhap x2: ');

y1 = my_perceptron(z1,[-1;x1;x2]);
y2 = my_perceptron(z2,[-1;x1;x2]);
y3 = my_perceptron(z3,[-1;y1;y2]);
%[giuong ghe ban]
y = [y1 y2 y3];
disp('[y1 y2 y3]')
disp(y)
if(y1)
    disp('giuong')
elseif(y2)
    disp('ghe')
else
    disp('ban')
end
if(x1 == 0 && x2 == 0)
    a = 1;
else
    a = 0;
end
disp('enter x1=0 and x2=0 to exit')
end