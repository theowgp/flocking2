N=0;
d=1;

grid = Grid(1, 100);

x0 = ones(N+2,d);
x0(N+2, 1) = 0;
for i=2:d
    x0(N+2,i) = 0;
end




A = [0 0 0; 0.5 0 0; -1 2 0];
b = [1.0/6.0    2.0/3.0    1.0/6.0];
s = 3;
rk = RungeKutta(grid, A, b, s, x0, N, d);



solu = zeros(N+2, d, grid.n, rk.s);
for i=1:grid.n
    for j=1:rk.s
        if j==1
            solu(1, 1, i, j) = uex(grid.t(i));
        else if j==3
                solu(1, 1, i, j) = uex(grid.t(i+1));
            else
                solu(1, 1, i, j) = uex((grid.t(i) + grid.t(i+1))/2);
            end
        end
    end
end

[solx, soly] = rk.solve_forward_equation(solu);

StateL2Error(solx, grid)