function [Gut_new] = delta_gut(Glucose,SpO2,Insulin,GutFlowRate,time_step)
    % change in glucose in gut -> absorption
    % change in glucose output
    Gut_new.Glucose_out = Glucose(time_step);
    
    
end