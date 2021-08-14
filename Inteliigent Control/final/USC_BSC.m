a = input('nhap a= ');
b = input('nhap b= ');
a_temp = a;
b_temp = b;

if(b>a)
    temp = a;
    a = b;
    b = temp;
end
temp = 1;
while(temp~=0)
    temp = mod(a,b);
    a = b;
    b = temp;
end
disp("USCLN")
disp(a)
BSC = (a_temp*b_temp)/a;
disp("BSCNN")
disp(BSC)