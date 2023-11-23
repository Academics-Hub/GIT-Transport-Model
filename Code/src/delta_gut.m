function [SpO2_new, glucose_new] = delta_gut(SpO2,gut_glucose,Insulin,GutFlowRate,time_step)
    switch GUT_PARAMS.setget_glucose_output_model
        case 1
            [glycemic_load_new,glucose_output] = glucose_output_model(GUT_PARAMS.setget_time, GUT_PARAMS.setget_time_since_last_meal, GUT_PARAMS.setget_current_glycemic_load, time_step);
            GUT_PARAMS.setget_glucose_output(glucose_output);
            GUT_PARAMS.setget_current_glycemic_load(glycemic_load_new);
            absorption = glucose_absorption(glucose_output, time_step);
            [~,glucose_shift_out] = glucose_output_model(GUT_PARAMS.setget_start_time,-1, 0, time_step);
            shift = 2*abs(glucose_absorption(glucose_shift_out, time_step));
            % shift absorption value up
            absorption = absorption + shift;
            %if GUT_PARAMS.setget_time_since_last_meal < 0 
            if glucose_output <= 0 && GUT_PARAMS.setget_time_since_last_meal == -1
                absorption = GUT_PARAMS.setget_BMR;
                %absorption = pull_to_BMR(absorption);
            end
            GUT_PARAMS.setget_glucose_absorption(absorption);
            glucose_new =  gut_glucose + absorption - glucose_output - GUT_PARAMS.setget_BMR; % net glucose
            if glucose_new < 0
                glucose_new = 0;
            end
        case 2
            [rate_glucose_appearance,gut_glucose_new] = glucose_output_model2(gut_glucose, Insulin); % mg/min
            GUT_PARAMS.setget_glucose_output(rate_glucose_appearance);
            absorption = glucose_absorption4(gut_glucose, rate_glucose_appearance, time_step);
            GUT_PARAMS.setget_glucose_absorption(absorption);
            if GUT_PARAMS.setget_time == 0 || GUT_PARAMS.setget_time == 0.5 
                glucose_new = GUT_PARAMS.setget_glucose_input + gut_glucose_new; % net glucose
            else
                glucose_new = gut_glucose_new; % net glucose
            end
            if glucose_new < 0
                glucose_new = 0;
            end
    end
    % piecewise function for glucose_new    
	% change in oxygen output
	Cb = 1.92;
	Hb = 140; 
	[gut_O2, O2_usage, gut_CO2] = O2_fed_fasting(GutFlowRate, Cb, Hb);
    GUT_PARAMS.setget_gut_O2(gut_O2);
    GUT_PARAMS.setget_gut_CO2(gut_CO2);
    % pulling SpO2 towards basal value
    SpO2_new = smooth_to_basal(SpO2, O2_usage);
    GUT_PARAMS.setget_O2_consumption(SpO2_new); 
end

function smoothed_SpO2 = smooth_to_basal(SpO2, O2_usage)
    smoothing_rate = 0.001;
    basal_SpO2 = cast(0.076, 'double');
    if GUT_PARAMS.setget_time_since_last_meal == -1 || GUT_PARAMS.setget_time_since_last_meal > 12600
        smoothed_SpO2 = SpO2 + (basal_SpO2 - SpO2) * smoothing_rate;
    elseif GUT_PARAMS.setget_time_since_last_meal <= (30*60) && GUT_PARAMS.setget_time_since_last_meal > 0  % half an hour
        smoothing_rate = (1/3600)*GUT_PARAMS.setget_time_since_last_meal;
        smoothed_SpO2 = SpO2 + (O2_usage - SpO2) * smoothing_rate;
    elseif GUT_PARAMS.setget_time_since_last_meal > (30*60) && GUT_PARAMS.setget_time_since_last_meal <= 12600
        smoothed_SpO2 = O2_usage;
    else
        smoothed_SpO2 = SpO2;
    end 
    % rate ends up being the proportion of the difference between basal and current SpO2 that we
    % add each step -> somehow we need to take a rate and find a smoothing_rate value
end 

function pull_absorption = pull_to_BMR(glucose_absorption)
    pull_absorption = glucose_absorption + (GUT_PARAMS.setget_BMR - glucose_absorption)*0.1;
end
