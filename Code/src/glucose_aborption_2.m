function [GutOut_glucose,GutNew_glucose] = glucose_absorption(vmax, km, arterialglucose, gutglucose, GutFlowRate, insulin, step, P1, P2, G0, Ib)

    %normal basal values 
    Gb = 5.6 ; %fssting glcuose mmol/L
    Ib = 174 ; %fasting insulin pmol/L

    % X(t) is the interstitial insulin at time t. assumed to be the blood insulin
    X = insulin  ; 

    % Define the differential equations
    dG_dt = -[P1 + X]*gutglucose + P1*Gb;
    dX_dt = -P2*X + P1*(insulin - Ib);

    % Update glucose usage using the differential equations
    glucose_usage = dG_dt * step;

    % Update using the metabolism rate
    GutNew_glucose = gutglucose + (step * GutFlowRate) * glucose_usage;

    % Update glucose using the metabolism rate
    GutOut_glucose = arterialglucose - (step * GutFlowRate) * glucose_usage;
    
end


