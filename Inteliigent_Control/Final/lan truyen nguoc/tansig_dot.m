function y=tansig_dot(value)
    temp=2/(1+exp(-2*value))-1;
    y=1-temp^2;
end