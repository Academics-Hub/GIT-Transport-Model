function [GutOut_glucose,GutNew_glucose] = glucose_absorption(arterialglucose, gutglucose, GutFlowRate, step)

    %glut 2
    vmax =3; % mmole s -1
    km=20; %mM 

    % Michaelis-Menten kinetics for glucose metabolism
    glucose_usage = vmax * gutglucose / (km + gutglucose); 

    % Update using the metabolism rate
    GutNew_glucose = gutglucose + (step * GutFlowRate) * glucose_usage;

    % Update glucose using the metabolism rate
    GutOut_glucose = arterialglucose - (step * GutFlowRate) * glucose_usage;
    
end

