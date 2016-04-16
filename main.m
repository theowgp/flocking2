clear variables

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


solu0 = zeros(N+2, d, grid.n, rk.s);

% solu = zeros(N+2, d, grid.n, rk.s);
% for i=1:grid.n
%     for j=1:rk.s
%         if j==1
%             solu(1, 1, i, j) = uex(grid.t(i));
%         else if j==3
%                 solu(1, 1, i, j) = uex(grid.t(i+1));
%             else
%                 solu(1, 1, i, j) = uex((grid.t(i) + grid.t(i+1))/2);
%             end
%         end
%     end
% end

% [solx, soly] = rk.solve_forward_equation(solu);
% StateL2Error(solx, grid)

% rk = rk.solve_optimality_system(solu);
% 
% normsolu(rk.g_u(solu), N, d, grid)

eps = 0.0000001;
sigma = 0.01;
% sigma = 1;
limitLS = 10000;
limitA = 8;
[solx, solu] = StepestDescent(rk, grid, N, d, solu0, eps, sigma, limitLS, limitA);
ControlL2Error = ControlL2Error(solu, grid)

% plot the control: exact and approximate
Y=zeros(grid.n, 1);
for i=1:grid.n
    Y(i) = solu(1, 1, i, 1);
end
X = grid.t(1:grid.n);
plot(X,Y);
hold all
fuex = @(t) uex(t);
fplot(fuex, [grid.t(1), grid.t(grid.n)]);

