% calculate O2 absorbed and CO2 generated, given
% A = 4500 m^2
% Gut.SpO2
% Arterial.SpO2
% GutFlowRate
% Arterial.PCO2
% step

function [GutNew, GutOut] = O2_CO2(GutFlowRate, Gut, Arterial, step, A)

  henrys_const = 0.013; % Henry's constant for O2 in water at body temp [mol/L*atm]
  
    % Oxygen absorption using Henry's Law and Fick's law of diffusion
    k = 0.01; % Diffusion coefficient [m^2/s]
    O2_absorption = henrys_const * Arterial.SpO2 + k * A * (Gut.SpO2 - Arterial.SpO2);
    GutNew.SpO2 = Gut.SpO2 + (step * GutFlowRate) * O2_absorption;
    GutOut.SpO2 = Arterial.SpO2 - (step * GutFlowRate) * O2_absorption;

    % CO2 production
    % Takes into account the amount of O2 absorbed by the gut and the oxygen saturation in the gut to estimate the amount of CO2 produced during metabolism.
    CO2_production = GutNew.SpO2 / (1 - GutNew.SpO2) * O2_absorption / henrys_const;
    GutNew.PCO2 = (step * GutFlowRate) * CO2_production; 
    GutOut.PCO2 = Arterial.PCO2 + (step * GutFlowRate) * CO2_production;

end
