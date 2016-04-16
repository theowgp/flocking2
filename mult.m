function res = mult(b, A)

[n, m] = size(b); 

res = zeros(n, m);
for i=1:n
    temp = zeros(1,m);
    for j=1:n
        temp = temp + b(j,:)*A(:,:, j, i);
    end
    res(i,:) = temp;
end



end

