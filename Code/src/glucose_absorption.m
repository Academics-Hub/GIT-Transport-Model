function [glucose_absorption] = glucose_absorption(glucose_output, time_step)
    glucose_output = glucose_output * 18.0182; %convert to mg/dL/time_step
	%normal basal values 
	%G_b = 5.6; %fasting glcuose mmol/L
    G_b = 80; %-> Dynamic Modeling of Exercise Effects on Plasma Glucose and Insulin Levels
    p1 = 0.035; %net glucose utilization without dynamic insulin response min^-1
        p1 = p1 / (60*time_step); % if p1 is in min^-1, then p1 needs to be converted to step^-1 cause we calculate everytime sec/step
    patient = GUT_PARAMS.setget_patient; 
    V = 1.45 * patient(2); %volume of distribution dL per kg
    %glucose_input = GUT_PARAMS.setget_glucose_input * 18.0182; %convert to mg/dL
    %C = glucose_input - G_b - glucose_output/(p1*V);
	% X(t) is the interstitial insulin at time t. assumed to be the blood insulin
	% Define the differential equations for minimal model
    % dX_dt = -p2*X_t + p3*(
    G = GUT_PARAMS.setget_plasma_glucose * 18.0182; %convert to mg/dL
	dG_dt = -p1*G + p1*G_b + glucose_output/V;
    glucose_absorption = dG_dt; %mg/dL/min
    % solution to ODE
    %glucose_change_plasma = G_b + C * exp(-p1*GUT_PARAMS.setget_time_since_last_meal) + glucose_output/(p1*V); % this is mg/dL
    glucose_absorption = (glucose_absorption / 18.0182) / (60/time_step); %convert to mmol/L/time_step
    %glucose_absorption = glucose_absorption; % negative because we want to add it to the gut, and substract from the plasma, and this equation gives the change in plasma glucose
    %if glucose_output <= 0
    %    glucose_absorption = 0;
    %else
        %glucose_absorption = GUT_PARAMS.setget_plasma_glucose - glucose_change_plasma;
    %end
end


