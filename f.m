function res = f(t, X, u, N, d)
x = X(1:N+1, :);
v = X(N+2:2*N+2, :);
xbar = X(2*N+3, 1);


global nu B eta;


res(1:N+1, :) = v;
res(N+2:2*N+2, :) = S(v, N, d) + M(x, N, d) + L(x, N, d);
res(2*N+3, :) = zeros(1, d);
res(2*N+3, 1) = 0.5*nu*norm2(mult(u, B))^2 +  l1(x, N) + 0.5*eta*norm(x(1, :) - xxdes(t, d))^2;

res = res + mult(u, B);


end