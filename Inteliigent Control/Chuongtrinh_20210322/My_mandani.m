function y = My_mandani(x1,x2)
%Khai bao gia tri ngon ngu cua bien vao, bien ra
x1_LO = hlt_hinhthang(x1,0,0,0,15);
x1_MED = hlt_hinhthang(x1,0,15,15,40);
x1_HI = hlt_hinhthang(x1,15,40,60,60);

x2_LO = hlt_hinhthang(x2,0,0,0,10);
x2_MED = hlt_hinhthang(x2,0,10,10,15);
x2_HI = hlt_hinhthang(x2,10,15,15,20);
x2_VH = hlt_hinhthang(x2,15,20,30,30);

x = 0:0.01:30;
y_VS = hlt_hinhthang(x,0,0,0,3);
y_S = hlt_hinhthang(x,0,3,3,8);
y_MED = hlt_hinhthang(x,3,8,8,16);
y_L = hlt_hinhthang(x,8,16,16,30);
y_VL = hlt_hinhthang(x,16,30,30,30);

beta = zeros(1,12);

beta(1) = min(x1_MED,x2_MED);
beta(2) = min(x1_MED,x2_HI);
beta(3) = min(x1_HI,x2_MED);
beta(4) = min(x1_HI,x2_HI);

n = length(x);
for i = 1:n
    if y_L(i) > beta(1)
        y_L(i) = beta(1);
    end
end

for i = 1:n
    if y_S(i) > beta(2)
        y_S(i) = beta(2);
    end
end

for i = 1:n
    if y_MED(i) > beta(4)
        y_MED(i) = beta(4);
    end
end

y = zeros(1,n);
for i = 1:n
    y(i) =max(y_L(i),max(y_S(i),y_MED(i)));
end
plot(x,y,'r','LineWidth',2)
grid on
