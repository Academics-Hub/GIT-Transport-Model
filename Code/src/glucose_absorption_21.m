function [glucose_change_plasma] = glucose_absorption_21(gutglucose, GutFlowRate, insulin, glucoseoutput, step) %need glucoseoutput from jono
	%normal basal values 
	Gb = 5.6; %fasting glcuose mmol/L
	Sg = 0.035; %net glucose utilization without dynamic insulin response min^-1
	Sg = Sg / (60*step); % if Sg is in min^-1, then Sg needs to be converted to step^-1 cause we calculate everytime sec/step
	p2 = 0.05 ;
	p2 = p2 / (60*step);
	p3 = 0.000028;
	Vol = 11.7; %distribution volume in L
	% X(t) is the interstitial insulin at time t. assumed to be the blood insulin
	I = insulin; 
	if isnan(gutglucose)
		fprintf('gutglucose is NaN at glucose_absorption_2 at time: %f\n', GUT_PARAMS.setget_time);
		%return
	end
	dX_dt = -p2*I + p3
	% Define the differential equations for minimal model
	dG_dt = -(Sg + X)*gutglucose + Sg*Gb + glucoseoutput/Vol;
	% Update glucose usage using the differential equations
	glucose_change_plasma = dG_dt * step * GutFlowRate;

	% Define maximum and minimum values
	%max_change_plasma = 100;  % Adjust the value based on your requirements
	%min_change_plasma = -100; % Adjust the value based on your requirements

	% Apply constraints
	%glucose_change_plasma = max(min(glucose_change_plasma, max_change_plasma), min_change_plasma);


	% Update using the metabolism rate
	%GutNew_glucose = gutglucose + glucose_change_plasma;
	% Update glucose using the metabolism rate
	%GutOut_glucose = arterialglucose + glucose_change_plasma;
end