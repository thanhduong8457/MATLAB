x=1:0.01:12
y1=hlt(x,1,3,3,9)
plot(x,y1,'r','LineWidth',1);
hold on
y2 = hlt(x,4,7,10,12)
plot(x,y2,'g','LineWidth',1)
hold on
%y3= tt_MIN(x,y1,y2)
%plot(x,y3,'b','LineWidth',2)
%y4= tt_MAX(x,y1,y2);
%plot(x,y4,'LineWidth',2)
%y5= tt_Prod(x,y1,y2);
%plot(x,y5,'LineWidth',2)
y6= tt_Bsum(x,y1,y2);
plot(x,y6,'b','LineWidth',2)
grid on
