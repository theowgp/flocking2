function res = phi(X, T, N, d)
x = X(1:N+1, :);
v = X(N+2:2*N+2, :);
xbar = X(2*N+3, 1);

res = 0.5*norm2(x(1,:) - xxdes(T, d)) + xbar;

end

