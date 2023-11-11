% calculate food inputs
function [glucose] = Food(carbs, proteins, lipids, fiber)
glucose = 19.27+(0.39*carbs)-(0.21*lipids)-(0.01*proteins^2)-(0.01*fiber^2);
end

