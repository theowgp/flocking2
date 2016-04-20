classdef Grid
        
    properties
         h;
         T0;
         T;
         n;
         t;
         tfine;
         
    end
    
    methods
        function obj = Grid(T0, T, n, s)
            obj.T0 = T0;
            obj.T = T;
            obj.n = n;
            obj.h = (T-T0)/n;
            obj.t = T0:obj.h:T;
            obj.tfine = zeros(n, s);
            for i=1:n
                obj.tfine(i, 1) = obj.t(i);
                obj.tfine(i, 2) = 0.5*(obj.t(i) + obj.t(i+1));
                obj.tfine(i, 3) = obj.t(i+1);
            end
        end
    end
    
end

