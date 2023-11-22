% amount of O2 absorbed from arterial (hopefully)

% Inputs:
% GutFlowRate: rate of blood flow to gut (l/min)
% arterial_spO2: oxygen saturation of entering blood (%)
% Cb: oxygen carrying capacity (mg/g)
% Hb: haemoglobin concentration (g/l)

function [gut_O2, gut_spO2, gut_CO2] = O2_fed_fasting(GutFlowRate, Cb, Hb)
    time_step = GUT_PARAMS.setget_time_step;
    time_since_last_meal = GUT_PARAMS.setget_time_since_last_meal;
    % gutflow rate to l/min
    GutFlowRate = GutFlowRate / 1000;

    if time_since_last_meal == -1
        O2_usage = 0.15;
    elseif time_since_last_meal <= (30*60) && time_since_last_meal >= 0  % half an hour
        O2_usage = (1/3600)*time_since_last_meal + 0.15;
    elseif time_since_last_meal > (30*60) && time_since_last_meal <= 12600
        O2_usage = 0.65;
    elseif time_since_last_meal > 12600
        O2_usage = (-1/3600) * time_since_last_meal + 4.15;
    end
    gut_spO2 = O2_usage;
    %O2_usage

    % arterial_spO2 - arterial_spO2_new = 15 for fasting?? (need to check)

    % O2_usage = 0.15

    %arterial_spO2_new = arterial_spO2 - O2_usage;

    gut_O2 = O2_usage * GutFlowRate * Hb * Cb;
    % gut_O2 in mg/min

    %change units to g/min
    gut_O2_g = gut_O2 / 1000;

    %change units to mol
    %O2: 32 g/mol
    gut_O2_mol = gut_O2_g / 32;

    % conversion from mol/min to mol/(s*time_step)
    gut_O2_mol_timestep = gut_O2_mol / (60);
    gut_O2 = gut_O2_mol_timestep;

    %gut_O2_mol

    gut_CO2_mol = gut_O2_mol;
    gut_CO2 = gut_CO2_mol;

    %CO2: 44 g/mol 
    %gut_CO2_g = gut_CO2_mol * 44;
end
