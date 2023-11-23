% my rework of the gut function, to make it more modular
function [GutNew, GutOut] = GutCalc(GutFlowRate, Gut, Arterial, time_step)
	% Setting gut parameters
	TIME_STEP = time_step;
	previous_time = cast(GUT_PARAMS.setget_previous_time, 'double'); % typecasting just in case
	%previous_time = cast(GUT_PARAMS.setget_time, 'double'); % typecasting just in case
	time_since_last_meal = GUT_PARAMS.setget_time_since_last_meal;

	% setting the time of day as a value from 0 -> 86400 (seconds in a day)
	new_time = calc_new_time(previous_time,TIME_STEP);

    meal = check_meal_time(new_time);
	MEAL_ABSORPTION_TIME = 4*3600; % this needs a researched value (hrs -> seconds)
	% if it's been more than MEAL_ABSORPTION_TIME since the last meal, set the time to -1 to indicate that we are not in the meal absorption phase
	if time_since_last_meal >= MEAL_ABSORPTION_TIME
	    time_since_last_meal = -1;
	% if check_meal_time returns a positive integer, and we are not in the meal absorption phase, set the time to 0 to indicate that we are starting the meal absorption phase
    elseif meal > 0 && time_since_last_meal == -1
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
	gut_spO2 = cast(Gut(1), 'double'); % typecasting just in case (shouldn't be necessary)
	gut_glucose = cast(Gut(2), 'double');
	arterial_spO2 = Arterial(1);
	arterial_glucose = Arterial(2);
    GUT_PARAMS.setget_plasma_glucose(arterial_glucose);
	arterial_insulin = Arterial(3);

	% Using Gut and Arterial functions to calculate their change
	[SpO2_new, glucose_new] = delta_gut(gut_spO2, gut_glucose, arterial_insulin, GutFlowRate, time_step);

	[venous_SpO2_new,venous_glucose_new,venous_insulin_new] = delta_arterial(arterial_spO2, arterial_glucose, arterial_insulin);

	% final outputs
	GutNew = zeros(1,2);
	GutNew(1) = SpO2_new;
	GutNew(2) = glucose_new;
	% updating the Gut parameters
	GUT_PARAMS.setget_time(new_time);
	GUT_PARAMS.setget_previous_time(new_time);
    GUT_PARAMS.setget_time_since_last_meal(time_since_last_meal);

	GutOut = zeros(1,3);
	GutOut(1) = venous_SpO2_new;
	GutOut(2) = venous_glucose_new;
	GutOut(3) = venous_insulin_new;
end

% set the time of day after each call of the GutCalc function
function new_time = calc_new_time(previous_time,time_step)
	new_time = previous_time + time_step;
end
