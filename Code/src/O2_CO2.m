% calculate O2 absorbed and CO2 generated, given
% A = 4500 m^2
% gut_spO2
% Arterial.SpO2
% GutFlowRate
% Arterial.PCO2
% step

function [GutNew, GutOut] = O2_CO2(GutFlowRate, Gut, Arterial, step, A)
  % Arterial values:
  arterial_spO2 = Aterial(1);
  % gut values:
  gut_spO2 = Gut(1);

  henrys_const = 0.013; % Henry's constant for O2 in water at body temp [mol/L*atm]

  % Oxygen absorption using Henry's Law and Fick's law of diffusion
  k = 0.01; % Diffusion coefficient [m^2/s]
  O2_absorption = henrys_const * arterial_spO2 + k * A * (gut_spO2 - arterial_spO2);
  GutNew(1) = gut_spO2 + (step * GutFlowRate) * O2_absorption;
  GutOut(1) = Arterial.SpO2 - (step * GutFlowRate) * O2_absorption;

  % CO2 production
  % Takes into account the amount of O2 absorbed by the gut and the oxygen saturation in the gut to estimate the amount of CO2 produced during metabolism.
  CO2_production = GutNew(1) / (1 - GutNew(1)) * O2_absorption / henrys_const;

  % Comment: we would make PCO2 be Gut(6) if its a value we want to keep track of
  GutNew(6) = (step * GutFlowRate) * CO2_production; 
  GutOut(6) = Arterial.PCO2 + (step * GutFlowRate) * CO2_production;
  % Comment: the Arterial array ->  Arterial=[ArterialSpO2, ArterialGlucose, ArterialInsulin]; So there isn't a CO2 value

  % Comment: CO2 doesn't seem to be an output we need, what's the thought behind calculating ?

end
