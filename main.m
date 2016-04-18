clear variables

N = 5;
d = 2;

globalvariables;
global B;

B = zeros(d, d, 2*N+3, 2*N+3);
B(:, :, N+2, N+2) = eye(d, d);

T = 0.4;

grid = Grid(T, 10);

X0 = zeros(2*N+3, d);
%initial position
x0 = zeros(N+1, d);
%initial velocity
v0 = zeros(N+1, d);
x0(1, 1) = 0;
v0(1, 1) = -0.5;
v0(1, 2) = -0.5;
for i = 2:N+1
    x0(i, 1) = x0(i-1, 1) + 1;
    v0(i, 2) = 0.5;
end
X0(1:N+1, :) = x0;
X0(N+2:2*N+2, :) = v0;
X0(2*N+3, :) = zeros(1, d);



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
sigma = 0.001;
% sigma = 1;
limitLS = 5000;
limitA = 8;
[solx, solu] = StepestDescent(rk, grid, N, d, solu0, eps, sigma, limitLS, limitA);


%PLOT THE TRAJECTORY OF THE LEADER AND OTHERS
figure
for i=1:N+1
    plot(reshape(solx(i,1,:), grid.n+1, 1), reshape(solx(i,2,:), grid.n+1, 1));
    %plot(solx(i,1,:), solx(i,2,:));
    hold all
end
% %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(3D)
% figure
% for i=1:N+1
%     plot3(reshape(solx(i,1,:), grid.n+1, 1), reshape(solx(i,2,:), grid.n+1, 1), reshape(solx(i,3,:), grid.n+1, 1));
%     %plot(solx(i,1,:), solx(i,2,:));
%     hold all
% end

% %PLOT THE TRAJECTORY COMPONENTS AGAINST TIME
% figure
% for i=1:N+1
%     plot(grid.t, reshape(solx(i,1,:), grid.n+1, 1));
%     %plot(solx(i,1,:), solx(i,2,:));
%     hold all
% end
% figure
% for i=1:N+1
%     plot(grid.t, reshape(solx(i,2,:), grid.n+1, 1));
%     %plot(solx(i,1,:), solx(i,2,:));
%     hold all
% end