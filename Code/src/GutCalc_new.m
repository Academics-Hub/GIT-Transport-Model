% my rework of the gut function, to make it more modular
function [GutNew, GutOut] = GutCalc_new(GutFlowRate, Gut, Arterial, step)
    time_step = step; % just for the naming convention sanity
    % checking the previous time of day. The first time the function is called, Gut.time will not have a value
    if isnan(Gut.time)
        previous_time=0;
    else
        previous_time = Gut.time;
    end
    % setting the time of day as a value from 0 -> 86400 (seconds in a day)
    time = get_time(previous_time, time_step);

    MEAL_ABSORPTION_TIME = 15*60; % this needs a researched value (seconds)
    % if it's been more than MEAL_ABSORPTION_TIME since the last meal, set the time to -1 to indicate that we are not in the meal absorption phase
    if time_since_last_meal >= MEAL_ABSORPTION_TIME
        time_since_last_meal = -1;
    % if check_meal_time returns a positive integer, and we are not in the meal absorption phase, set the time to 0 to indicate that we are starting the meal absorption phase
    elseif check_meal_time(time) > 0 && time_since_last_meal == -1
        time_since_last_meal = 0;
    % if we are in the meal absorption phase, add the time step to the time since last meal
    elseif time_since_last_meal < MEAL_ABSORPTION_TIME
        time_since_last_meal = time_since_last_meal + time_step;
    end
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
    Gut = delta_gut(gut_glucose, gut_spO2, arterial_insulin, GutFlowRate, time, time_since_last_meal);
    Arterial = delta_arterial(arterial_glucose, arterial_spO2, arterial_insulin, Gut, time_step);

    % final outputs
    GutNew = Gut;
    GutOut = Arterial; % this means we manipulate arterial, and we manipulate gut
end