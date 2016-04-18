clear variables

N = 2;
d = 2;

globalvariables;
global B;
B = zeros(d, d, 2*N+3, 2*N+3);
B(:, :, N+2, N+2) = eye(d, d);

T = 0.4;
n = 10;
mesh = Grid(T, n);

X0 = zeros(2*N+3, d);
%initial position
x0 = zeros(N+1, d);
%initial velocity
v0 = zeros(N+1, d);
x0(1, 1) = 0;
v0(1, 1) = -0.5;
v0(1, 2) = -0.2;
% v0(1, 3) = -1;
for i = 2:N+1
    x0(i, 1) = x0(i-1, 1) + 1.5;
    v0(i, 2) = 0.5;
end
X0(1:N+1, :) = x0;
X0(N+2:2*N+2, :) = v0;
X0(2*N+3, :) = zeros(1, d);



A = [0 0 0; 0.5 0 0; -1 2 0];
b = [1.0/6.0    2.0/3.0    1.0/6.0];
s = 3;
rk = RungeKutta(mesh, A, b, s, X0, N, d);


solu0 = zeros(2*N+3, d, mesh.n, rk.s);




eps = 0.000001;
sigma = 0.001;
% sigma = 1;
limitLS = 5000;
limitA = 8;
% [solx, solu] = StepestDescent(rk, mesh, N, d, solu0, eps, sigma, limitLS, limitA);
[solx, solu] = NCG(rk, mesh, N, d, solu0, eps, sigma, limitLS, limitA);


if d==1
    %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(1D)
    figure
    for i=1:N+1
        plot(mesh.t, reshape(solx(i,1,:), mesh.n+1, 1));
        hold all
    end
else
    if d==2 

        %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(2D)
        figure
        for i=1:N+1
            plot(reshape(solx(i,1,:), mesh.n+1, 1), reshape(solx(i,2,:), mesh.n+1, 1));
            hold all
        end
    else

        %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(3D)
        figure
        for i=1:N+1
            plot3(reshape(solx(i,1,:), mesh.n+1, 1), reshape(solx(i,2,:), mesh.n+1, 1), reshape(solx(i,3,:), mesh.n+1, 1));
            grid on
            hold all
        end
    end
end


% %PLOT THE TRAJECTORY COMPONENTS AGAINST TIME
% % first componetn
% figure
% for i=1:N+1
%     plot(grid.t, reshape(solx(i,1,:), mesh.n+1, 1));
%     hold all
% end
% % second component
% figure
% for i=1:N+1
%     plot(grid.t, reshape(solx(i,2,:), mesh.n+1, 1));
%     hold all
% end
% % third component
% figure
% for i=1:N+1
%     plot(grid.t, reshape(solx(i,3,:), mesh.n+1, 1));
%     hold all
% end