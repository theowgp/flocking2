function [solx, solu] = NCG(rk, grid, N, d, solu, eps, sigma, limitLS, limitA)

rk = rk.solve_optimality_system(solu);
drct = - rk.g_u(solu);
g = - drct;



kLS = 0;
while normsolu(g, N, d, grid)>eps && kLS<limitLS
    s = DetermineStepSizeNCG(rk, grid, solu, g, drct, N, d, sigma, limitA);
    solu = solu + s*drct;
    rk = rk.solve_optimality_system(solu);
    gnext = rk.g_u(solu);
    beta = ComputeBetaK(g, gnext, drct, N, d, grid);
    drct = - gnext + beta*drct;
    g = gnext;
    
    
    
    kLS = kLS+1;
    normsolu(g, N, d, grid);
    phi(rk.solx(:, :, grid.n+1), grid.T, N, d);
    
    Gradient = normsolu(g, N, d, grid);
    Phi = phi(rk.solx(:, :, grid.n+1), grid.T, N, d);
%     disp([kLS, Phi, Gradient]);
end
Gradient = normsolu(g, N, d, grid)
Phi = phi(rk.solx(:, :, grid.n+1), grid.T, N, d)
kLS

solx = rk.solx;
solu;

end

