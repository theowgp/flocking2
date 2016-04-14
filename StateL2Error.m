function res = StateL2Error(solx, grid)

temp = 0;
for i = 2:grid.n+1
   temp = temp + (solx(1, 1, i) - xex(grid.t(i)))^2;
end
res = sqrt(temp*grid.h);

end

