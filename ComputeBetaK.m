function res = ComputeBetaK(g, gnext, drct, N, d, grid)

y = gnext - g;

sigma = y - 2*drct*spsolu(y, y, N, d, grid)/spsolu(y, drct, N, d, grid);

res = spsolu(sigma, gnext, N, d, grid)/spsolu(drct, y, N, d, grid);
end

