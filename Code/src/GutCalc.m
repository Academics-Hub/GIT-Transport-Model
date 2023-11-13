% my rework of the gut function, to make it more modular

% looking at OverallLoop -> gut is initiliased as a 2 element vector -> [40,1]
% assuming that the first element is the glucose in the gut, and the 2nd element is something else (idk), we can use subsequent elements to store other values
% We'll say that:
    % Gut(1) = SpO2 in gut
    % Gut(2) = glucose in gut
    % Gut(3) = time
    % Gut(4) = time since last meal
    % Gut(5) = current glycemic load
% Therefore we;ll recommend that the gut object is initialised as [40,1,0,-1,0]
function [GutNew, GutOut] = GutCalc(GutFlowRate, Gut, Arterial, time_step)
    % if it is the first time the function is called, we need to convert Gut(3) to a double
    Gut(3) = cast(Gut(3),'double');
    % checking the previous time of day. 
    previous_time = Gut(3);
    % setting the time of day as a value from 0 -> 86400 (seconds in a day)
    time = get_time(previous_time, time_step);

    MEAL_ABSORPTION_TIME = 4*3600; % this needs a researched value (hrs -> seconds)
    time_since_last_meal = Gut(4);

    meal_time = check_meal_time(time);

    % if it's been more than MEAL_ABSORPTION_TIME since the last meal, set the time to -1 to indicate that we are not in the meal absorption phase
    if time_since_last_meal >= MEAL_ABSORPTION_TIME
        time_since_last_meal = -1;
    % if check_meal_time returns a positive integer, and we are not in the meal absorption phase, set the time to 0 to indicate that we are starting the meal absorption phase
    elseif meal_time > 0 && time_since_last_meal == -1
        time_since_last_meal = 0;
    % if we are in the meal absorption phase, add the time step to the time since last meal
    elseif time_since_last_meal < MEAL_ABSORPTION_TIME && time_since_last_meal >= 0
        time_since_last_meal = time_since_last_meal + time_step;
    end
    
    % inputs:
        % GutFlowRate: [mL/min]
        % Gut: gut object
        % Arterial: arterial object
        % step: time step [seconds]
    % We are given initial values, and then from these, we need to simulate what happens at the next time step.
    % Remember that we receive the previous Gut and Aterial values, at the beginning of each iteration of the function in OverallLoop
    gut_spO2 = Gut(1);
    gut_glucose = Gut(2);
    glycemic_load = Gut(5);
    arterial_spO2 = Arterial(1);
    arterial_glucose = Arterial(2);
    arterial_insulin = Arterial(3);

    % Using Gut and Arterial functions to calculate their change
    [SpO2_new, glucose_new, gut_glucose_output, gut_glucose_absorption,O2_used, glycemic_load_new] = delta_gut(gut_glucose, gut_spO2, arterial_insulin, GutFlowRate, time, time_step, time_since_last_meal, glycemic_load);

    [arterial_SpO2_new,arterial_glucose_new,arterial_insulin_new] = delta_arterial(arterial_spO2, arterial_glucose, arterial_insulin, gut_glucose_output, gut_glucose_absorption, O2_used, time);

    % final outputs
    GutNew = zeros(1,5);
    GutNew(1) = SpO2_new;
    GutNew(2) = glucose_new;
    GutNew(3) = time;
    GutNew(4) = time_since_last_meal;
    GutNew(5) = glycemic_load_new;

    GutOut = zeros(1,3);
    GutOut(1) = arterial_SpO2_new;
    GutOut(2) = arterial_glucose_new;
    GutOut(3) = arterial_insulin_new;
end

% set the time of day after each call of the GutCalc function
function [time] = get_time(previous_time,time_step)
    time = previous_time + time_step;
end