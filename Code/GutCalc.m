function [GutNew, GutOut] = GutCalc(GutFlowRate, Gut, Arterial, step)
    % Parameters
    Vmax = 5; % Maximum reaction velocity for hexokinase
    Km =  0.15 % Michaelis constant : conc at Vmax/2
    HenrysConst = 0.013; % Henry's constant for O2 in water at body temp [mol/L*atm]
    [glucose] = Food(50, 20, 10, 5);

    % Input concentrations
    % Input will be from food, GIT will output to vascular system
    SpO2_in = Arterial.SpO2;
    PCO2_in = Arterial.PCO2;
    Glucose_in = Arterial.Glucose + glucose;
    Insulin_in = Arterial.Insulin;

    % Michaelis-Menten kinetics for glucose metabolism
    Glucose_usage = Vmax * Glucose_in / (Km + Glucose_in);
    
    % Update using the metabolism rate
    GutNew.Glucose = Gut.Glucose - (step * GutFlowRate) * Glucose_usage; 
    GutOut.Glucose = Glucose_in - (step * GutFlowRate) * Glucose_usage;

    % Oxygen absorption using Henry's Law and Fick's law of diffusion
    A = 300; % Surface area of the gut in square metres
    k = 0.01
    O2_absorption = HenrysConst * SpO2_in + k * A * (Gut.SpO2 - Arterial.SpO2);
    GutNew.SpO2 = Gut.SpO2 - (step * GutFlowRate) * O2_absorption;
    GutOut.SpO2 = SpO2_in - (step * GutFlowRate) * O2_absorption;

    % CO2 production
    CO2_production = GutNew.SpO2 / (1 - GutNew.SpO2) * O2_absorption / HenrysConst;
    GutNew.PCO2 = Gut.PCO2 + (step * GutFlowRate) * CO2_production;
    GutOut.PCO2 = PCO2_in + (step * GutFlowRate) * CO2_production;

    GutNew.Insulin = Gut.Insulin;
    GutOut.Insulin = Insulin_in;
end

