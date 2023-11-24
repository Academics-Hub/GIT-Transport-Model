function [glycemic_load_new,glucose_output] = glucose_output_model(time, time_since_last_meal, glycemic_load, time_step)
	% get if it is a meal time
	time_of_day = check_meal_time(time);
	% if time since last meal is valid, i.e. its still in its absorption period of food
    if  time_of_day > 0 && time_since_last_meal == 0
	    % set the meal
	    [carbs,lipids,proteins,fibre] = set_meal(time_of_day);
	    % find the glycemic load from the meal input
	    [glucose_output, GL] = food(carbs, lipids, proteins, fibre, time_since_last_meal);
	    glycemic_load_new = GL;
    elseif  time_since_last_meal ~= -1
        glucose_output = find_gl_glucose(time_since_last_meal, glycemic_load);
        glycemic_load_new = glycemic_load;
    else
        glucose_output = 0;
        glycemic_load_new = 0;
    end
    glucose_output = glucose_output / (60/time_step); % convert to mmol/L/time_step
end

        

