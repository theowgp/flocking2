function res = Gxf(X, u, N, d)
x = X(1:N+1, :);
v = X(N+2:2*N+2, :);
xbar = X(2*N+3, 1);
   
res = zeros(d, d, 2*N+3, 2*N+3);


res(:, :, N+2:2*N+2, N+2:2*N+2) = GS(v, N, d);

temp = zeros(d, d, N+1, N+1);
for i=1:N+1
    temp(:, :, i, i) = eye(d, d);
end

res(:, :, 1:N+1, N+2:2*N+2) = temp;

res(:, :, N+2:2*N+2, 1:N+1) = GxM(x, N, d) + GxL(x, N, d);

temp = Gl1(x, N, d);
for i=1:1*N+1
    res(1, :, 2*N+3, i) = temp(i, :);
end

end

