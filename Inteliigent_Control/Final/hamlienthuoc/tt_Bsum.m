function y=tt_Bsum(x,a,b)
K=length(x);
y=zeros(size(x));
for k= 1:K
    y(k)=a(k)+b(k);
    if (y(k)>1)
        y(k)=1;
    end
end
end