function y = My_mandaniii(x1,x2,x3)
%Khai bao gia tri ngon ngu cua bien vao, bien ra
x1_S = hlt_hinhthang(x1,0,0,0,50);
x1_MED = hlt_hinhthang(x1,0,50,50,100);
x1_L = hlt_hinhthang(x1,50,100,100,100);

x2_G1 = hlt_hinhthang(x2,0,0,0,50);
x2_MED = hlt_hinhthang(x2,0,50,50,100);
x2_G2 = hlt_hinhthang(x2,50,100,100,100);

x3_L = hlt_hinhthang(x3,0,0,0,50);
x3_MED = hlt_hinhthang(x3,0,50,50,100);
x3_H = hlt_hinhthang(x3,50,100,100,100);

x = 0:0.01:60;
y_VS = hlt_hinhthang(x,0,8,8,12);
y_S = hlt_hinhthang(x,8,12,12,20);
y_MED = hlt_hinhthang(x,12,20,20,40);
y_L = hlt_hinhthang(x,20,40,40,60);
y_VL = hlt_hinhthang(x,40,60,60,60);

beta = zeros(1,27);

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
