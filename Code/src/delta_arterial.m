% Arterial array in OverallLoop.m looks like:
%   Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
% therefore it makes sense to have a function to manipulate this array
function [venous_SpO2_new, venous_glucose_new, venous_insulin_new] = delta_arterial(arterial_SpO2, arterial_glucose, arterial_insulin)
    % Manipulation of AterialSpO2
    % Manipulation of ArterialGlucose ->
    %   mmol/dL
    % Manipulation of ArterialInsulin -> probably won't be any, but useful for glucose
    %   microU/mL
    venous_SpO2_new = arterial_SpO2 - GUT_PARAMS.setget_O2_consumption;
    venous_glucose_new = arterial_glucose + GUT_PARAMS.setget_glucose_output - GUT_PARAMS.setget_glucose_absorption;
    % test insulin as half rectified sine wave
    %initial_insulin = GUT_PARAMS.setget_initial_insulin_input;
    %venous_insulin_new = arterial_insulin * (sin(2*pi*0.0001*GUT_PARAMS.setget_time)+1)/2;
    venous_insulin_new = arterial_insulin; % set like this for now, probably won't change
end


