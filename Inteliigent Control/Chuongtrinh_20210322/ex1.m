y = My_mandani(20,12);
n = length(y);
a=0;
b=0;
for i=1:n
    a=a+y(i)*0.01*i;
    b=b+y(i);
end
a/b