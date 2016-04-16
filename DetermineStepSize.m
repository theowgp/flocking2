function res = DetermineStepSize(rk, grid, solu, g, N, d, sigma, limitA)

s=1;

[solxA, solyA] = rk.solve_forward_equation(solu - s*g);

kA=0;
while phi(solxA(:, :, grid.n+1), grid.T, N, d)> phi(rk.solx(:, :, grid.n+1), grid.T, N, d) - sigma*s*spsolu(g, g, N, d, grid)  &&  kA<limitA
    s = s*0.5;
    [solxA, solyA] = rk.solve_forward_equation(solu - s*g);
    kA = kA +1;
end
kA

res = s;
end

