% Arterial array in OverallLoop.m looks like:
%   Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
% therefore it makes sense to have a function to manipulate this array
function [Arterial] = Aterial(AterialSpO2,ArterialGlucose,ArterialInsulin)
    % Manipulation of AterialSpO2
    % Manipulation of ArterialGlucose
    % Manipulation of ArterialInsulin -> probably won't be any, but useful for glucose

    Arterial = [AterialSpO2,ArterialGlucose,ArterialInsulin];
end

