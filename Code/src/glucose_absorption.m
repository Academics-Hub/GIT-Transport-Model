function [GutOut_glucose,GutNew_glucose] = glucose_absorption(vmax, km, arterialglucose, gutglucose, GutFlowRate, step)

    % Michaelis-Menten kinetics for glucose metabolism
    glucose_usage = vmax * Gut.Glucose / (km + gutglucose); 
    glucose_usage = vmax * Gut.Glucose / (km + gutglucose);

    % Update using the metabolism rate
    GutNew_glucose = Gut.Glucose - (step * GutFlowRate) * glucose_usage; 

    % Update glucose using the metabolism rate
    GutNew_glucose = arterialglucose + (step * GutFlowRate) * glucose_usage;
    GutOut_glucose = gutglucose - (step * GutFlowRate) * glucose_usage;
    
end

