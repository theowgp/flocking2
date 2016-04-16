function res = norm2( x )
[n, m] = size(x);

temp = 0;
for i=1:n
    for j=1:m
        temp = temp + x(i, j)^2;
    end
end
res = sqrt(temp);
end

