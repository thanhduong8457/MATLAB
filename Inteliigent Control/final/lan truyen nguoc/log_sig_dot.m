function y=log_sig_dot(value)
    temp=1/(1+exp(-value));
    y=temp*(1-temp);
end