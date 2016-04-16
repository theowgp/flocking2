clear variables

N=0;
d=2;

global B nu alpha beta;
alpha = 0;
beta = 0;
nu = 1;
B = zeros(d, d, 2*N+3, 2*N+3);
B(:, :, N+2, N+2) = eye(d, d);

grid = Grid(1, 100);

X0 = zeros(2*N+3, d);





A = [0 0 0; 0.5 0 0; -1 2 0];
b = [1.0/6.0    2.0/3.0    1.0/6.0];
s = 3;
rk = RungeKutta(grid, A, b, s, X0, N, d);


solu0 = zeros(2*N+3, d, grid.n, rk.s);

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

eps = 0.000001;
sigma = 0.01;
% sigma = 1;
limitLS = 10000;
limitA = 8;
[solx, solu] = StepestDescent(rk, grid, N, d, solu0, eps, sigma, limitLS, limitA);

