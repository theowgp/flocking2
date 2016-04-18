function res = DetermineStepSizeNCG(rk, grid, solu, g, drct, N, d, sigma, limitA)

s=1;

[solxA, solyA] = rk.solve_forward_equation(solu + s*drct);

kA=0;
while phi(solxA, N, d, grid)> phi(rk.solx, N, d, grid) + sigma*s*spsolu(drct, g, N, d, grid)  &&  kA<limitA
    s = s*0.5;
    [solxA, solyA] = rk.solve_forward_equation(solu + s*drct);
    kA = kA + 1;
end
kA;

res = s;
end