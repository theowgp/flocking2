classdef RungeKutta
        
    properties
        grid;
        A;
        b;
        s;
        N;
        d;
        
        x0;
        solx;
        soly;
        
        solp;
        solkhi;
    end
    
    methods
        function obj = RungeKutta(grid, A, b, s, x0, N, d)
            obj.grid = grid;
            obj.A = A;
            obj.b = b;
            obj.s = s;
            obj.N = N;            
            obj.d = d;
            obj.x0 = x0;
            
%             obj.solx = zeros(N, d, grid.n+1);
%             obj.solx(:, :, 1) = x0;
%             obj.soly = zeros(N, d, grid.n, s);
            
            
%             obj.solp(:, :, 1) = zeros(N, d, grid.n+1);
%             obj.solkhi = zeros(N, d, grid.n, s);
        end
        
        function [solx, soly] = solve_forward_equation(obj, solu)
            solx = zeros(obj.N+2, obj.d, obj.grid.n+1);
            solx(:, :, 1) = obj.x0;
            soly = zeros(obj.N+2, obj.d, obj.grid.n, obj.s);

            
            for k=1:obj.grid.n
                solx(:, :, k+1) = solx(:, :, k);
                for i=1:obj.s
                   soly(:, :, k, i) = solx(:, :, k);
                   for j=1:obj.s
                       if i>j
                        soly(:, :, k, i) = soly(:, :, k, i) + obj.grid.h*obj.A(i, j)*f(soly(:, :, k, j), solu(:, k, j));
                       end
                   end
                   solx(:, :, k+1) = solx(:, :, k+1) + obj.grid.h*obj.b(i)*f(soly(:, :, k, i), solu(:, k, i));
                end
            end
        end
        
        function [solp, solkhi] = solve_adjoint_equation(obj, solu)
            solp = zeros(obj.N+2, obj.d, obj.grid.n+1);
%             solp(:, :, obj.grid.n+1) = -Gphi(obj.solx(:, :, obj.grid.n+1));
%             solp(:, :, obj.grid.n+1) = Gphi(obj.solx(:, :, obj.grid.n+1));
            solkhi = zeros(obj.N+2, obj.d, obj.grid.n, obj.s);

            
            for k=obj.grid.n:-1:1
                solp(:, :, k) = solp(:, :, k+1);
                for i=1:obj.s
                   solkhi(:, :, k, i) = solp(:, :, k+1);
                   for j=1:obj.s
                       if i>j
%                         solkhi(:, :, k, i) = solkhi(:, :, k, i) + obj.grid.h*obj.A(j, i)*obj.b(j)/obj.b(i)*solkhi(:, :, k, j)*Gxf(obj.soly(:, :, k, j), solu(:, k, j));
                       end
                   end
%                    solp(:, :, k) = solp(:, :, k) + obj.grid.h*obj.b(i)*solkhi(:, :, k, i)*Gxf(obj.soly(:, :, k, i), solu(:, k, i));
                end
            end
        end
        
        function obj = solve_optimality_system(obj, solu)
            [obj.solx, obj.soly] = obj.solve_forward_equation(solu);
            [obj.solp, obj.solkhi] = obj.solve_adjoint_equation(solu);
        end
        
        function res = g_u(obj, solu)
           res = zeros(obj.d, obj.grid.n, obj.s);
           for k=1:obj.grid.n
               for i=1:obj.s
%                    res(:, k, i) = -obj.grid.h*obj.b(i)*obj.solkhi(:, :, k, i)*Guf(obj.soly(:, :, k, i), solu(:, k, i));
%                    res(:, k, i) = -obj.solkhi(:, :, k, i)*Guf(obj.soly(:, :, k, i), solu(:, k, i));  % as in Haager      
               end
           end
        end
        
    end
    
end

