convert_day = [1 32 60 91 121 152 182 213 244 274 305 335];
% Need to type Day and Mouth here
day = 2;
mouth = 8;
n = convert_day(mouth) - 1 + day;
% Vi Do
L = 8 + 40/60 + 57/3600;
% Type Clock time here
CT = 12;
LT = 15*7; % mui gio +7
% Kinh Do
LL = 106 + 36/60 + 10/3600;

%///////////////////////////////////////////
B = 360/364*(n-81);
E = 9.28*sin(2*B*pi/180) - 7.53*cos(B*pi/180) - 1.5*sin(B*pi/180);

ST = CT + (LT - LL)/15 + E/60;
%ST = 9;

H = 15*(12 - ST);

delta = 23.45*sin((360/365)*(n - 81)*pi/180);
% beta
beta = asin(cos(L*pi/180)*cos(delta*pi/180)*cos(H*pi/180)... 
        + sin(L*pi/180)*sin(delta*pi/180))*180/pi;
if(beta>90)
    beta = 180 - beta;
end
m = 1/sin(beta*pi/180);
tilt = 90 - beta;
phiS = asin((cos(delta*pi/180)*sin(H*pi/180))/cos(beta*pi/180))*180/pi;