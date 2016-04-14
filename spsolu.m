function res = spsolu(solu1, solu2, N, d, grid)

temp = 0;

for k=1:grid.n
    for i=1:N+2
        for j=1:d
            temp = temp + solu1(i, j, k, 1)*solu2(i, j, k, 1);
        end
    end
end

res = temp*grid.h;


end

