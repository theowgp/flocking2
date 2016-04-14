function res = Gxf(x, u, N, d)
   
res = zeros(d, d, N+2, N+2);

for i=1:N+1
    for j=1:N+1
        res(:, :, i, j) = 0.5*eye(d);
    end
end

for j=1:N+1
    res(1, :, N+2, j) = x(j, :);
end

end

