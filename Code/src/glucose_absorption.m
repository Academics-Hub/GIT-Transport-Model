function [glucose_usage] = glucose_absorption(gutglucose, GutFlowRate, time_step)
	% GutFlowRate is in mL/min 
	% v is in mmole/s

	% Gutflowrate -> L/(s/time_step)

	GutFlowRate = GutFlowRate * 1000 / (60 * time_step); % L/time_step -> L/s
	% mmol/s * s / L/s = mmol/L 


	%glut 2
	vmax =3; % mmole s -1
	km=20; %mM 

	% Michaelis-Menten kinetics for glucose metabolism
	%glucose_usage = vmax * gutglucose / (km + gutglucose); 
	%glucose_usage = (vmax * gutglucose / (km + gutglucose)) * (step * GutFlowRate); 
	glucose_usage = (vmax * gutglucose / (km + gutglucose)) * time_step / GutFlowRate;
	%glucose_usage = 
	% Update using the metabolism rate
	%GutNew_glucose = gutglucose + (step * GutFlowRate) * glucose_usage;

	% Update glucose using the metabolism rate
	%GutOut_glucose = arterialglucose - (step * GutFlowRate) * glucose_usage;
	
end

