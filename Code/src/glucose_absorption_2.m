function [glucose_change_plasma] = glucose_absorption_2(gutglucose, GutFlowRate, insulin, glucoseoutput, step) %need glucoseoutput from jono
	%normal basal values 
	Gb = 5.6; %fasting glcuose mmol/L
	Sg = 0.035; %net glucose utilization without dynamic insulin response min^-1
	% X(t) is the interstitial insulin at time t. assumed to be the blood insulin
	Sg = Sg / (60*step); % if Sg is in min^-1, then Sg needs to be converted to step^-1 cause we calculate everytime sec/step
	X = insulin; 
	if isnan(gutglucose)
		fprintf('gutglucose is NaN at glucose_absorption_2 at time: %f\n', GUT_PARAMS.setget_time);
		%return
	end
	% Define the differential equations for minimal model
	dG_dt = -(Sg + X)*gutglucose + Sg*Gb + glucoseoutput/1.35e6;
	% Update glucose usage using the differential equations
	glucose_change_plasma = dG_dt * step * GutFlowRate;
	% Update using the metabolism rate
	%GutNew_glucose = gutglucose + glucose_change_plasma;
	% Update glucose using the metabolism rate
	%GutOut_glucose = arterialglucose + glucose_change_plasma;
end


