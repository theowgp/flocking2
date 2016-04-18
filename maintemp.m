clear variables

N = 0;
d = 2;

globalvariables;
global B;
B = zeros(d, d, 2*N+3, 2*N+3);
B(:, :, N+2, N+2) = eye(d, d);

T = 2;
deltat = 0.5;
windows = 0:deltat:T;
nw = length(windows);
n = 8;


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


solu0 = zeros(2*N+3, d, n, s);




eps = 0.000001;
sigma = 0.001;
limitLS = 50;
limitA = 8;



%%


meshes(1) = Grid(windows(1), windows(2), n);
rk = RungeKutta(meshes(1), A, b, s, X0, N, d);
[tempstate, tempcontrol] = NCG(rk, meshes(1), N, d, solu0, eps, sigma, limitLS, limitA);
state(1) = tempstate;
control(1) = tempcontrol;

for i=2:nw-1
    meshes(i) = Grid(windows(i), windows(i+1), n);
    temp = state(i-1);
    rk = RungeKutta(meshes(i), A, b, s, temp(:, :, n+1), N, d);
    [tempstate, tempcontrol] = NCG(rk, meshes(i), N, d, control(i-1), eps, sigma, limitLS, limitA);
    state(i) = tempstate;
    control(i) = tempcontrol;
end





%%

if d==1
    %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(1D)
    figure
    for j = 1:nw-1
        temp = state(j);
        for i=1:N+1
            plot(meshes(j).t, reshape(temp(i,1,:), n+1, 1));
            hold all
        end
    end
else
    if d==2 

        %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(2D)
        figure
        for j = 1:nw-1
            temp = state(j);
            for i=1:N+1
                plot(reshape(temp(i,1,:), n+1, 1), reshape(temp(i,2,:), n+1, 1));
                hold all
            end
        end
    else

        %PLOT THE TRAJECTORY OF THE LEADER AND OTHERS(3D)
        figure
        for j = 1:nw-1
            temp = state(j);
            for i=1:N+1
                plot3(reshape(temp(i,1,:), n+1, 1), reshape(temp(i,2,:), n+1, 1), reshape(temp(i,3,:), n+1, 1));
                grid on
                hold all
            end
        end
    end
end


