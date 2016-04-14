function res = Guf(x, u, N, d)
   
res = zeros(d, d, N+2, N+2);
res(:, :, 1, 1) = eye(d,d);


res(1, :, N+2, 1) = 2*u(1, :);

end



