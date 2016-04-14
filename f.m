function res = f(x, u, N, d)
res = zeros(N+2, d);

res(1, :) = 0.5*x(1, :) + u(1, :); 

for i=2:N+1
    res(i,:) = 0.5*x(i, :);
end

res(N+2, 1) = 0.5*(2*norm(x(1, :))^2 + norm(u(1, :))^2); 

end