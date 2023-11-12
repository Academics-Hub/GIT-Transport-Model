function [Gut_new, glucose_to_arterial, glucose_used] = delta_gut(gut_glucose,SpO2,Insulin,GutFlowRate,time,time_step,time_since_last_meal,glycemic_load)
    % change in glucose in gut -> absorption
    % change in glucose output
    % tbh not sure how to use the gut flow rate for output. I think it should affect digestion, but I'm not sure how
    [Gut_new(5),glucose_absorbed,glucose_output] = glucose_model(time,time_step,time_since_last_meal,Insulin,glycemic_load);    
    Gut_new(1) = gut_glucose + glucose_absorbed - glucose_output; % net glucose
    glucose_to_arterial = glucose_output; % for use in Arterial model
end