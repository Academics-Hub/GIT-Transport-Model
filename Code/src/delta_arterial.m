% Arterial array in OverallLoop.m looks like:
%   Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
% therefore it makes sense to have a function to manipulate this array
function [Arterial] = delta_arterial(AterialSpO2,ArterialGlucose,ArterialInsulin,gut_glucose_output,gut_glucose_absorption,time_step)
    % Manipulation of AterialSpO2
    % Manipulation of ArterialGlucose ->
    %   mmol/dL
    % Manipulation of ArterialInsulin -> probably won't be any, but useful for glucose
    %   microU/mL
    ArterialGlucose = ArterialGlucose - gut_glucose_absorption + gut_glucose_output;
    Arterial = [AterialSpO2,ArterialGlucose,ArterialInsulin];
end

