function [glycemic_load] = glycemic_load(carbs, proteins, lipids, fibre)
    glycemic_load = 19.27+(0.39*carbs)-(0.21*lipids)-(0.01*proteins^2)-(0.01*fibre^2);
end
