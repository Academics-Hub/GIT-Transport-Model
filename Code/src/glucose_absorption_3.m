function [GutOut_glucose,GutNew_glucose] = glucose_absorption(arterialglucose, gutglucose, GutFlowRate, insulin, step)

    A = 300; % define surface area of gut in m^2
    D= 5.7 x 10^{-10}; %define diffusibility
    thickeness = 0.005; % small intestin is 5mm thick
    partition_coef = 0.65; 
    K = D * partition_coef / thickeness; %calculate permeability

    J_glucose = K * A * (gutglucose - arterialglucose)

    % Update using the metabolism rate
    GutNew_glucose = gutglucose + (step * GutFlowRate) * J_glucose;

    % Update glucose using the metabolism rate
    GutOut_glucose = arterialglucose + (step * GutFlowRate) * J_glucose;
end