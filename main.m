clear variables

N = 0;
d = 2;

globalvariables;
global B;
B = zeros(d, d, 2*N+3, 2*N+3);
B(:, :, N+2, N+2) = eye(d, d);

global T;
T = 0.4;

deltat = T;
windows = 0:deltat:T;
nw = length(windows);
n = 10;


X0 = zeros(2*N+3, d);
%initial position
x0 = zeros(N+1, d);
%initial velocity
v0 = zeros(N+1, d);
x0(1, 1) = 0;
v0(1, 1) = -0.5;
% v0(1, 2) = -0.2;
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


solu0 = zeros(2*N+3, d, n, s);




eps = 0.000001;
sigma = 0.001;
limitLS = 1000;
limitA = 8;



%%
state = zeros(2*N+3, d, n+1, nw-1);
control = zeros(2*N+3, d, n, s, nw-1);


meshes(1) = Grid(windows(1), windows(2), n, s);
rk = RungeKutta(meshes(1), A, b, s, X0, N, d);
[state(:, :, :, 1), control(:, :, :, :, 1)] = NCG(rk, meshes(1), N, d, solu0, eps, sigma, limitLS, limitA);

for i=2:nw-1
    meshes(i) = Grid(windows(i), windows(i+1), n,  s);
    rk = RungeKutta(meshes(i), A, b, s, state(:, :, n+1, i-1), N, d);
%     [state(:, :, :, i), control(:, :, :, :, i)] = NCG(rk, meshes(i), N, d, control(:, :, :, :, i-1), eps, sigma, limitLS, limitA);
    [state(:, :, :, i), control(:, :, :, :, i)] = NCG(rk, meshes(i), N, d, solu0, eps, sigma, limitLS, limitA);
end




%% plot the desired trajectory
for j=1:nw-1
    for i=1:n+1
        temp = xxdes(meshes(j).t(i), d);
        V(i) = temp(1);
        W(i) = temp(2);
    end
    plot(V, W);
    hold all
end
%%
if d==1
    %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(1D)
    %figure
    for j = 1:nw-1
        for i=1:N+1
            plot(meshes(j).t, reshape(state(i,1,:,j), n+1, 1));
            hold all
        end
    end
else
    if d==2 

        %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(2D)
        %figure
        for j = 1:nw-1
            for i=1:N+1
                plot(reshape(state(i,1,:,j), n+1, 1), reshape(state(i,2,:, j), n+1, 1));
                hold all
            end
        end
    else

        %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(3D)
        figure
        for j = 1:nw-1
            for i=1:N+1
                plot3(reshape(state(i,1,:,j), n+1, 1), reshape(state(i,2,:,j), n+1, 1), reshape(state(i,3,:,j), n+1, 1));
                grid on
                hold all
            end
        end
    end
end
