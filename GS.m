function res = GS( v, N, d ) %S0: Rd(N+1)  -> Rd(N+1) 

global alpha beta;


res = zeros(d, d, N+1, N+1);

for i=1:N+1
    res(:, :, i, i) = (alpha - beta*norm(v(i, :))^2) * eye(d, d) - 2*beta*v(i, :)'*v(i, :);
end


end