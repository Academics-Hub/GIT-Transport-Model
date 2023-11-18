% Arterial array in OverallLoop.m looks like:
%   Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
% therefore it makes sense to have a function to manipulate this array
function [arterial_SpO2_new, arterial_glucose_new, arterial_insulin_new] = delta_arterial(arterial_SpO2, arterial_glucose, arterial_insulin)
    % Manipulation of AterialSpO2
    % Manipulation of ArterialGlucose ->
    %   mmol/dL
    % Manipulation of ArterialInsulin -> probably won't be any, but useful for glucose
    %   microU/mL
    arterial_SpO2_new = arterial_SpO2 - GUT_PARAMS.setget_O2_consumption; % set like this for now
    arterial_glucose_new = arterial_glucose + GUT_PARAMS.setget_glucose_output - GUT_PARAMS.setget_glucose_absorption;
    arterial_insulin_new = arterial_insulin; % set like this for now, probably won't change
end

