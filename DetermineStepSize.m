function res = DetermineStepSize(rk, grid, solu, g, N, d, sigma, limitA)

s=1;

[solxA, solyA] = rk.solve_forward_equation(solu - s*g);

kA=0;
while phi(solxA, N, d, grid)> phi(rk.solx, N, d, grid) - sigma*s*spsolu(g, g, N, d, grid)  &&  kA<limitA
    s = s*0.5;
    [solxA, solyA] = rk.solve_forward_equation(solu - s*g);
    kA = kA +1;
end
kA

res = s;
end

