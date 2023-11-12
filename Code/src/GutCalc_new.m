function [GutNew, GutOut] = GutCalc(GutFlowRate, Gut, Arterial, step)
    time_step = step; % just for the naming convention sanity
    % inputs:
        % GutFlowRate: [mL/min]
        % Gut: gut object
        % Arterial: arterial object
        % step: time step [seconds]
    % We are given initial values, and then from these, we need to simulate what happens at the next time step.
    % Remember that we receive the previous Gut and Aterial values, at the beginning of each iteration of the function in OverallLoop
    gut_spO2 = Gut.SpO2;
    gut_glucose = Gut.Glucose;
    arterial_spO2 = Arterial(1);
    arterial_glucose = Arterial(2);
    arterial_insulin = Arterial(3);

    % Using Gut and Arterial functions to calculate their change
    Gut = delta_gut(gut_glucose, gut_spO2, arterial_insulin, GutFlowRate, time_step);
    Arterial = delta_arterial(arterial_glucose, arterial_spO2, arterial_insulin, Gut, time_step);
    
    % final outputs
    GutNew = Gut;
    GutOut = Arterial; % this means we manipulate arterial, and we manipulate gut
end