% Calculate total Basal Metabolic Rate (tBMR) and change in blood glucose
% Inputs:
% Gender
% Weight (kg)
% Height (cm)
% Age (years)
% GutFlowRate (ml/min)

function[delta_blood_glucose] = BMR(sex, weight, height, age, GutFlowRate)
    %GutFlowRate = GutFlowRate * 60; % ml/min to ml/sec
    Patient = GUT_PARAMS.setget_patient;
    V = 1.45 * Patient(2); % volume of distribution of glucose in dL
    V = V / 10; % dL to L
    % gender: male = 0
    % gender: female = 1
    if sex == 0
        total_basal_metabolic_rate = 88.362 + 13.397 * weight + 4.799 * height - 5.677 * age;
    else
        total_basal_metabolic_rate = 447.593 + 9.247 * weight + 3.098 * height - 4.330 * age;
    end
    fprintf('Total Basal Metabolic Rate (kcal/day): %f\n', total_basal_metabolic_rate);
    % o2 usage at rest (of all body o2 usage) = 16%
    % gut_basal_metabolic_rate (kcal)
    gut_basal_metabolic_rate = total_basal_metabolic_rate * 0.15;
    fprintf('Gut Basal Metabolic Rate (kcal/day): %f\n', gut_basal_metabolic_rate);
    % glucose calorimetric density = 4 kcal/g
    % glucose_g (g/day)
    glucose_g = gut_basal_metabolic_rate / 4;
    fprintf('Glucose (g/day): %f\n', glucose_g);
    % glucose_mol 
    glucose_mol = ((glucose_g * (1/180.15588))/ GutFlowRate ) / (60/GUT_PARAMS.setget_time_step);   % delta_blood_glucose (mmol/min)->(mmol/L/time_step)
    fprintf('Glucose (mmol/L/time_step): %f\n', glucose_mol);
    delta_blood_glucose = glucose_mol;
end
