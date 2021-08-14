clc
a = 0;
while ~a
d = input('nhap chieu dai: ');
r = input('nhap chieu rong: ');
c = input('nhap chieu cao: ');

y1 = my_perceptron(z1,[-1;d;r;c]);
y2 = my_perceptron(z2,[-1;d;r;c]);
y3 = my_perceptron(z3,[-1;d;r;c]);
y4 = my_perceptron(z4,[-1;y1;y2]);
y5 = my_perceptron(z5,[-1;y2;y3]);

%[giuong ghe ban]
y = [y1 y4 y5 y3];
disp('[4 7 16 50]: so cho ngoi')
disp(y)
if(y1)
    disp('chon xe 4 cho')
elseif(y4)
    disp('chon xe 7 cho')
elseif(y5)
    disp('chon xe 16 cho')
else
    disp('chon xe 50 cho')
end
if(d == 0 && r == 0 && c == 0)
    a = 1;
else
    a = 0;
end
disp('enter d=0, r=0 and c=0 to exit')
end