% Calculate total Basal Metabolic Rate (tBMR) and change in blood glucose
% Inputs:
% Gender
% Weight (kg)
% Height (cm)
% Age (years)
% GutFlowRate (l/min)

function[delta_blood_glucose] = BMR(step, sex, weight, height, age, GutFlowRate)

% Gender: male = 0
% Gender: female = 1

if sex == 0
    total_basal_metabolic_rate = 88.362 + 13.397 * weight + 4.799 * height - 5.677 * age;
else
    total_basal_metabolic_rate = 447.593 + 9.247 * weight + 3.098 * height - 4.330 * age;
end

% O2 usage at rest (of all body O2 usage) = 16%
% gut_basal_metabolic_rate (kcal)
gut_basal_metabolic_rate = total_basal_metabolic_rate * 0.1298;

% glucose calorimetric density = 4 kcal/g
% glucose_g (g/day)
glucose_g = gut_basal_metabolic_rate / 4;

% glucose_mol (mol/min)
% 1440 minutes per day
glucose_mol = glucose_g * (1/180.15588) * (1/1440);

% delta_blood_glucose (mmol/l)
delta_blood_glucose = glucose_mol * 1000 * 1/GutFlowRate * step;

end
