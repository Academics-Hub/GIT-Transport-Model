function [SpO2_new, glucose_new, glucose_to_arterial, glucose_used, O2_used, glycemic_load_new] = delta_gut(gut_glucose,SpO2,Insulin,GutFlowRate,time,time_step,time_since_last_meal,glycemic_load)
    % change in glucose in gut -> absorption
    glucose_absorbed = 0; % replace with Dinal's function to get glucose absorbed
    % change in glucose output
    % tbh not sure how to use the gut flow rate for output. I think it should affect digestion, but I'm not sure how
    [glycemic_load_new,glucose_output] = glucose_output_model(time,time_step,time_since_last_meal,Insulin,glycemic_load);    
    glucose_new = gut_glucose + glucose_absorbed - glucose_output; % net glucose
    glucose_to_arterial = glucose_output; % for use in Arterial model
    glucose_used = glucose_absorbed; % for use in Arterial model

    % change in oxygen output
    O2_used = 0; % replace with Julia's function to get O2 used -> O2 to be subtracted from arterial
    SpO2_new = SpO2; % net oxygen -> no idea how this changes, setting it to stay the same for now
end