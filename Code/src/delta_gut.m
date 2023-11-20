function [SpO2_new, glucose_new] = delta_gut(SpO2,gut_glucose,Insulin,GutFlowRate,time_step)
    % change in glucose in gut -> absorption
    % blood -> tissue
    [absorption] = BMR(gender, weight, height, age, GutFlowRate); % replace with Dinal's function to get glucose absorbed
    GUT_PARAMS.setget_glucose_absorption(absorption);
    % change in glucose output
    % tbh not sure how to use the gut flow rate for output. I think it should affect digestion, but I'm not sure how
    [glycemic_load_new,glucose_output] = glucose_output_model(GUT_PARAMS.setget_time, GUT_PARAMS.setget_time_since_last_meal, Insulin, GUT_PARAMS.setget_current_glycemic_load);

    GUT_PARAMS.setget_current_glycemic_load(glycemic_load_new);
    % lumen -> blood
    GUT_PARAMS.setget_glucose_output(glucose_output);

    glucose_new = gut_glucose + GUT_PARAMS.setget_glucose_absorption; % net glucose

    % change in oxygen output
    GUT_PARAMS.setget_O2_consumption(15) % replace with Julia's function to get O2 used -> O2 to be subtracted from arterial
    SpO2_new = SpO2; % net oxygen -> no idea how this changes, setting it to stay the same for now
end