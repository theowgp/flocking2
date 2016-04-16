function res = Gxphi(X, T, N, d)
x = X(1:N+1, :);
v = X(N+2:2*N+2, :);
xbar = X(2*N+3, 1);

res = zeros(2*N+3, d);

res(1, :) = x(1, :) - xxdes(T, d);
res(2*N+3, 1) = 1;

end

