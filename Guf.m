function res = Guf(X, u, N, d)

global nu B;

res = B;

temp = nu*mult(u, B);

for i=1:2*N+3
    res(1, :, 2*N+3, i) = temp(i, :);
end

end



