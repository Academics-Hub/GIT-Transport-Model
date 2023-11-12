function [Gut_new] = delta_gut(gut_glucose,SpO2,Insulin,GutFlowRate,time,time_step,time_since_last_meal,glycemic_load)
    % change in glucose in gut -> absorption
    % change in glucose output
    % tbh not sure how to use the gut flow rate for output. I think it should affect digestion, but I'm not sure how
    [Gut_new.glycemic_load,glucose_absorbed,glucose_output] = glucose_model(time,time_step,time_since_last_meal,Insulin,glycemic_load);    
    Gut_new.Glucose = gut_glucose + glucose_absorbed - glucose_output; % net glucose
    Gut_new.glucose_output = glucose_output; % for use in Arterial model
end