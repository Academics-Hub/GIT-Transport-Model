function [glucose_change_plasma] = glucose_absorption(gut_glucose, glucose_output, time_step) %need glucose_output from jono
    glucose_output = glucose_output * 18.0182; %convert to mg/dL
	%normal basal values 
	G_b = 5.6; %fasting glcuose mmol/L
    G_b = G_b * 18.0182; %convert to mg/dL
	p1 = 0.035; %net glucose utilization without dynamic insulin response min^-1
    V = 1350 * 10000; %volume of distribution of glucose dL
    glucose_input = GUT_PARAMS.setget_glucose_input * 18.0182; %convert to mg/dL
    C = glucose_input - G_b - glucose_output/(p1*V);
	% X(t) is the interstitial insulin at time t. assumed to be the blood insulin
	p1 = p1 / (60*time_step); % if p1 is in min^-1, then p1 needs to be converted to step^-1 cause we calculate everytime sec/step
	if isnan(gut_glucose)
		fprintf('gut_glucose is NaN at glucose_absorption_2 at time: %f\n', GUT_PARAMS.setget_time);
		return
    elseif glucose_output < 0
        fprintf('glucose_output is negative at glucose_absorption_2 at time: %f\n', GUT_PARAMS.setget_time);
        return
    elseif isnan(glucose_output)
        fprintf('glucose_output is NaN at glucose_absorption_2 at time: %f\n', GUT_PARAMS.setget_time);
        return
	end
	% Define the differential equations for minimal model
    % dX_dt = -p2*X_t + p3*(
	%dG_dt = -p1*gut_glucose + p1*G_b + glucose_output/300;
    % solution to ODE
    glucose_change_plasma = G_b + C * exp(-p1*GUT_PARAMS.setget_time) + glucose_output/(p1*V); % this is mg/dL
    glucose_change_plasma = glucose_change_plasma / 18.0182; %convert to mmol/L
end


