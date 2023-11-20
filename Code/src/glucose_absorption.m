function [glucose_usage] = glucose_absorption(gutglucose, GutFlowRate, step)

	%glut 2
	vmax =3; % mmole s -1
	km=20; %mM 

	% Michaelis-Menten kinetics for glucose metabolism
	%glucose_usage = vmax * gutglucose / (km + gutglucose); 
	%glucose_usage = (vmax * gutglucose / (km + gutglucose)) * (step * GutFlowRate); 
	glucose_usage = (vmax * gutglucose / (km + gutglucose)) * step;
	% Update using the metabolism rate
	%GutNew_glucose = gutglucose + (step * GutFlowRate) * glucose_usage;

	% Update glucose using the metabolism rate
	%GutOut_glucose = arterialglucose - (step * GutFlowRate) * glucose_usage;
	
end

