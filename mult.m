function res = mult(b, A, N, d)

res = zeros(N+2,d);
for i=1:N+2
    temp = zeros(1,d);
    for j=1:N+2
        temp = temp + b(j,:)*A(:,:, j, i);
    end
    res(i,:) = temp;
end



end

