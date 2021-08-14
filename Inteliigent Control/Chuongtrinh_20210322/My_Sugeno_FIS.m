function y=My_Sugeno_FIS(x1,x2)

%Khai bao gia tri ngon ngu cua bien vao, bien ra
x1_NB=hlt_hinhthang(x1,-2,-1,-0.7,-0.2);
x1_NS=hlt_hinhthang(x1,-0.7,-0.2,-0.2,0);
x1_ZE=hlt_hinhthang(x1,-0.2,0,0,0.2);
x1_PS=hlt_hinhthang(x1,0,0.2,0.2,0.7);
x1_PB=hlt_hinhthang(x1,0.2,0.7,1,2);

x2_NE=hlt_hinhthang(x2,-2,-1,-0.6,0);
x2_ZE=hlt_hinhthang(x2,-0.6,0,0,0.6);
x2_PO=hlt_hinhthang(x2,0,0.6,1,2);

y_NB=-1; y_NM=-0.7; y_NS=-0.4; y_ZE=0;
y_PS=0.4; y_PM=0.7; y_PB=1;

%Cac qui tac - do dung cua menh de dieu kien
beta1=x1_NB*x2_NE;y1=y_PB;
beta2=x1_NB*x2_ZE;y2=y_PM;
beta3=x1_NB*x2_PO;y3=y_PS;

beta4=x1_NS*x2_NE;y4=y_PM;
beta5=x1_NS*x2_ZE;y5=y_PS;
beta6=x1_NS*x2_PO;y6=y_ZE;

beta7=x1_ZE*x2_NE;y7=y_PS;
beta8=x1_ZE*x2_ZE;y8=y_ZE;
beta9=x1_ZE*x2_PO;y9=y_NS;

beta10=x1_PS*x2_NE;y10=y_ZE;
beta11=x1_PS*x2_ZE;y11=y_NS;
beta12=x1_PS*x2_PO;y12=y_NM;

beta13=x1_PB*x2_NE;y13=y_NS;
beta14=x1_PB*x2_ZE;y14=y_NM;
beta15=x1_PB*x2_PO;y15=y_NB;

%Giai mo dung pp trung binh co trong so
TS = beta1*y1+beta2*y2+beta3*y3+...
     beta4*y4+beta5*y5+beta6*y6+...
     beta7*y7+beta8*y8+beta9*y9+...
     beta10*y10+beta11*y11+beta12*y12+...
     beta13*y13+beta14*y14+beta15*y15;
MS = beta1+beta2+beta3+...
     beta4+beta5+beta6+...
     beta7+beta8+beta9+...
     beta10+beta11+beta12+...
     beta13+beta14+beta15;
y=TS/MS;
end

