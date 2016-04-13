classdef Grid
        
    properties
         h;
         T;
         n;
         t;
         
    end
    
    methods
        function obj = Grid(T, n)
            obj.T = T;
            obj.n = n;
            obj.h = T/n;
            obj.t = 0:h:T;
        end
    end
    
end

