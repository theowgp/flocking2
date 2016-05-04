function res = Matrix( A )
[m,n,p,q]=size(A);
d=m;
res=zeros(d*p, d*q);

for i=1:p
    for j=1:q
     res(1+(i-1)*d:(i-1)*d+d, 1+(j-1)*d:(j-1)*d+d) = A(:, :, i, j);
    end
end
    


end

