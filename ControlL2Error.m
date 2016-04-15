function res = ControlL2Error(solu, grid)

temp = 0;
for i = 1:grid.n
   temp = temp + (solu(1, 1, i, 1) - uex(grid.t(i)))^2;
end
res = sqrt(temp*grid.h);

end

