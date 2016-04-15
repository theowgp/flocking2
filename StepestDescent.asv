function [solx, solu] = StepestDescent(rk, grid, N, d, solu, eps, sigma, limitLS, limitA)

rk = rk.solve_optimality_system(solu);
g = rk.g_u(solu);



kLS = 0;
while normsolu(g, N, d, grid)>eps && kLS<limitLS
    s = DetermineStepSize(rk, grid, solu, g, N, d, sigma, limitA);
    solu = solu - s*g;
    rk = rk.solve_optimality_system(solu);
    g = rk.g_u(solu);
    
    kLS = kLS+1;
    normsolu(g, N, d, grid);
    phi(rk.solx, N, d, grid);
end
Gradient = normsolu(g, N, d, grid)
Phi = phi(rk.solx, N, d, grid)
kLS

solx = rk.solx;
solu;

end

