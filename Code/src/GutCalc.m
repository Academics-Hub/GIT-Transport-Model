function [GutNew, GutOut] = GutCalc(GutFlowRate, Gut, Arterial, step)
    % Parameters
    vmax = 5; % Maximum reaction velocity for hexokinase
    km = 0.15; % Michaelis constant : conc at Vmax/2
    henrys_const = 0.013; % Henry's constant for O2 in water at body temp [mol/L*atm]
    [glucose] = food(50, 20, 10, 5);

    % Input concentrations
    % Input will be from food, GIT will output to vascular system
    SpO2_in = Arterial.SpO2;
    PCO2_in = Arterial.PCO2;
    Arterial.Glucose = Arterial.Glucose + glucose; %assumes all glucose from meal is absorped 
    Glucose_in = Arterial.Glucose; %assume all glucose from artieres is available to be used by gut (but wont all be used)
    Gut.Glucose = Gut.glucose + Glucose_in;
    Insulin_in = Arterial.Insulin;

    %calculate rate of o2 comsumption ??
    % JO2 = (GutFlowRate/1000) * (SpO2_in - Gut.SpO2) * 150 * 1.92;

    % Mass balance chcecker 
    total_mass_in = SpO2_in + PCO2_in + Glucose_in + Insulin_in;
    total_mass_out = Gut.SpO2 + Gut.PCO2 + Gut.Glucose + Gut.Insulin;
    mass_balance_error = total_mass_in - total_mass_out;
    if abs(mass_balance_error) > 1e-6
        error('Mass balance not conserved');
    end
    
    % Michaelis-Menten kinetics for glucose metabolism
    glucose_usage = vmax * Gut.Glucose / (km + Gut.Glucose);
    
    % Update glucose using the metabolism rate
    GutNew.Glucose = Gut.Glucose + (step * GutFlowRate) * glucose_usage;
    GutOut.Glucose = Glucose_in - (step * GutFlowRate) * glucose_usage;

    % Oxygen absorption using Henry's Law and Fick's law of diffusion
    k = 0.01; % Diffusion coefficient [m^2/s]
    O2_absorption = HenrysConst * SpO2_in + k * A * (Gut.SpO2 - Arterial.SpO2);
    GutNew.SpO2 = Gut.SpO2 + (step * GutFlowRate) * O2_absorption;
    GutOut.SpO2 = SpO2_in - (step * GutFlowRate) * O2_absorption;

    % CO2 production
    % Takes into account the amount of O2 absorbed by the gut and the oxygen saturation in the gut to estimate the amount of CO2 produced during metabolism.
    CO2_production = GutNew.SpO2 / (1 - GutNew.SpO2) * O2_absorption / henrys_const;
    GutNew.PCO2 = (step * GutFlowRate) * CO2_production; 
    GutOut.PCO2 = PCO2_in + (step * GutFlowRate) * CO2_production;

    % Insulin absorption and elimination via first-order kinetic model
    k_elim = 0.1;
    Insulin_absorption = Insulin_in - GutFlowRate * Gut.Insulin;
    Insulin_elimination = k_elim * Gut.Insulin;
    GutNew.Insulin = Gut.Insulin + step * (Insulin_absorption - Insulin_elimination);
    GutOut.Insulin = Insulin_in;
end