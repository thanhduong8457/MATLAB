function y= tt_MAX(x,a,b)
K=length(x);
y=zeros(size(x));
for k=1:K
    if (a(k)<b(k))
        y(k)=b(k);
    else
        y(k)=a(k);
    end
end
end