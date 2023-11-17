function [GutOut_glucose,GutNew_glucose] = glucose_absorption(vmax, km, arterialglucose, gutglucose, GutFlowRate, step)ß

    % Michaelis-Menten kinetics for glucose metabolism
    glucose_usage = vmax * gutglucose / (km + gutglucose); 

    % Update using the metabolism rate
    GutNew_glucose = gutglucose + (step * GutFlowRate) * glucose_usage;

    % Update glucose using the metabolism rate
    GutOut_glucose = arterialglucose - (step * GutFlowRate) * glucose_usage;
    
end

