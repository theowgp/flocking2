function res = Gl1(x, N, d)

global mu;

res = zeros(N+1, d);

temp = zeros(1, d);
for i=2:N+1
    temp = temp + norm(x(1,:)-x(i,:))^2*(x(1,:)-x(i,:));
end
res(1,:) = 2*mu*temp;

for i=2:N+1
    res(i,:) = -2*mu*norm(x(1,:)-x(i,:))^2*(x(1,:)-x(i,:));
end


end
