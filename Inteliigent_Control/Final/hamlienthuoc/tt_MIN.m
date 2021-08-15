function  y=tt_MIN(x,a,b)
K= length(x);
y= zeros(size(x));
for k=1:K
    if(a(k)<=b(k))
        y(k)=a(k);
    else
        y(k)=b(k);
    end
end
end