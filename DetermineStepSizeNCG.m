function res = DetermineStepSizeNCG(rk, grid, solu, g, drct, N, d, sigma, limitA)

s=1;

[solxA, solyA] = rk.solve_forward_equation(solu + s*drct);

kA=0;
while phi(solxA(:, :, grid.n+1), grid.T, N, d)> phi(rk.solx(:, :, grid.n+1), grid.T, N, d) + sigma*s*spsolu(drct, g, N, d, grid)  &&  kA<limitA
    s = s*0.5;
    [solxA, solyA] = rk.solve_forward_equation(solu + s*drct);
    kA = kA +1;
end
kA;


% %PLOT THE TRAJECTORY OF THE LEADER
% for i=1:N+1
%     plot(reshape(solxA(i,1,:), grid.n+1, 1), reshape(solxA(i,2,:), grid.n+1, 1));
%     %plot(solx(i,1,:), solx(i,2,:));
%     hold all
% end

res = s;
end
