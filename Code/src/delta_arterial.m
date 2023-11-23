% Arterial array in OverallLoop.m looks like:
%   Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
% therefore it makes sense to have a function to manipulate this array
function [venous_SpO2_new, venous_glucose_new, venous_insulin_new] = delta_arterial(arterial_SpO2, arterial_glucose, arterial_insulin)
    switch GUT_PARAMS.setget_glucose_output_model
        case 1
            venous_glucose_new = GUT_PARAMS.setget_plasma_glucose - GUT_PARAMS.setget_glucose_absorption - GUT_PARAMS.setget_BMR + GUT_PARAMS.setget_glucose_output;
            GUT_PARAMS.setget_plasma_glucose(venous_glucose_new);
        case 2
            venous_glucose_new = GUT_PARAMS.setget_plasma_glucose;
    end 
    venous_SpO2_new = arterial_SpO2 - GUT_PARAMS.setget_O2_consumption;
    venous_insulin_new = arterial_insulin; 
end


