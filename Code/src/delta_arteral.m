% Arterial array in OverallLoop.m looks like:
%   Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
% therefore it makes sense to have a function to manipulate this array
function [Arterial] = delta_aterial(AterialSpO2,ArterialGlucose,ArterialInsulin, Gut)
    % Manipulation of AterialSpO2
    % Manipulation of ArterialGlucose ->
    %   mmol/dL
    % Manipulation of ArterialInsulin -> probably won't be any, but useful for glucose
    %   microU/mL

    Arterial = [AterialSpO2,ArterialGlucose,ArterialInsulin];
end

