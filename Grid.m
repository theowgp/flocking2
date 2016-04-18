classdef Grid
        
    properties
         h;
         T0;
         T;
         n;
         t;
         
    end
    
    methods
        function obj = Grid(T0, T, n)
            obj.T0 = T0;
            obj.T = T;
            obj.n = n;
            obj.h = (T-T0)/n;
            obj.t = T0:obj.h:T;
        end
    end
    
end

