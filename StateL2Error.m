function res = StateL2Error(solx, grid)

d = 0;
for i = 2:grid.n+1
   d = d + (solx(1, 1, i) - xex(grid.t(i)))^2;
end
res = sqrt(d*grid.h);

end

