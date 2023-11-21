function [SpO2_new, glucose_new] = delta_gut(SpO2,gut_glucose,Insulin,GutFlowRate,time_step)
	% change in glucose in gut -> absorption
	% change in glucose output
	% tbh not sure how to use the gut flow rate for output. I think it should affect digestion, but I'm not sure how
	if isnan(gut_glucose)
		fprintf('gut_glucose is NaN at delta_gut at time: %d\n', GUT_PARAMS.setget_time)
		return
	end
	[glycemic_load_new,glucose_output] = glucose_output_model(GUT_PARAMS.setget_time, GUT_PARAMS.setget_time_since_last_meal, Insulin, GUT_PARAMS.setget_current_glycemic_load);
	if isnan(glucose_output)
		fprintf('glucose_output is NaN at delta_gut at time: %d\n', GUT_PARAMS.setget_time)
		return
	end
	GUT_PARAMS.setget_current_glycemic_load(glycemic_load_new);
	% lumen -> blood
	GUT_PARAMS.setget_glucose_output(glucose_output);
	% blood -> tissue
	%absorption = glucose_absorption_2(gut_glucose, GutFlowRate, Insulin, glucose_output, time_step); % replace with Dinal's function to get glucose absorbed
	absorption = glucose_absorption(gut_glucose, glucose_output, time_step);
	if isnan(absorption)
		fprintf('absorption is NaN at delta_gut\n')
		return
	end
	%absorption = 0.0035/(60*time_step);
	GUT_PARAMS.setget_glucose_absorption(absorption);
	%glucose_new = gut_glucose + absorption - glucose_output; % net glucose
	glucose_new = absorption - glucose_output; % net glucose
	if isnan(glucose_new)
		fprintf('glucose_new is NaN at delta_gut at time: %d\n', GUT_PARAMS.setget_time)
		fprintf('gut_glucose: %d, absorption: %d, glucose_output: %d\n', gut_glucose, absorption, glucose_output)
		return
	end
	% change in oxygen output
	Cb = 1.92;
	Hb = 140; 
	[gut_O2, O2_usage, gut_CO2] = O2_fed_fasting(GutFlowRate, Cb, Hb);
    GUT_PARAMS.setget_gut_O2(gut_O2);
    GUT_PARAMS.setget_gut_CO2(gut_CO2);
	%SpO2_new = SpO2 + O2_usage; % net oxygen -> no idea how this changes, setting it to stay the same for now
    % pulling SpO2 towards basal value
    %SpO2 = SpO2 + O2_usage;
    %SpO2_new = SpO2 + O2_usage;
    SpO2_new = smooth_to_basal(SpO2, O2_usage);
    GUT_PARAMS.setget_O2_consumption(SpO2_new); % replace with Julia's function to get O2 used -> O2 to be subtracted from arterial
	%SpO2_new = SpO2 + O2_usage; % net oxygen -> no idea how this changes, setting it to stay the same for now
	%if SpO2_new > 98
	%	SpO2_new = 98;
	%end
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
