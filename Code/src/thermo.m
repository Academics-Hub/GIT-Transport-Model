function [food_energy, delta_blood_glucose] = thermo(carbs, protein, lipids)

P = 59/760; %(atm)
V = 0.03712; %(ml/min)
R = 0.08206; %((L*atm)/(mol*K))
T = 310; %(K)

n_O2 = (P*V)/(R*T); %(mol/min)

n_glucose = n_O2 / 6 %(mol/min)

% energy_carbs = energy_protein = 4 kcal/g
% energy_lipids = 9 kcal/g

food_energy = 0.95 * (carbs * 4) + 0.7 * (protein * 4) + 0.95 * (lipids * 9); %(kcal)

% glucose calorimetric density: 4 kcal/g
% glucose molecular density: 180.15588 g/mol

delta_blood_glucose = food_energy * (1/4.4) * (1/180.15588)* GutFlowRate;