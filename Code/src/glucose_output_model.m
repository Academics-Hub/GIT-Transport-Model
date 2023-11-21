function [glycemic_load_new,glucose_output] = glucose_output_model(time, time_since_last_meal, glycemic_load)
	% get if it is a meal time
	time_of_day = check_meal_time(time);
	% if time since last meal is valid, i.e. its still in its absorption period of food
	if time_since_last_meal > 0 && time_of_day == 0
	    glucose_output = find_gl_glucose(time_since_last_meal, glycemic_load);
	    glycemic_load_new = glycemic_load;
	    % I assume that there will be a different rate of energy consumption during a time period post a meal (energy of digestion)
	elseif time_since_last_meal == 0 && time_of_day > 0
	    % set the meal
	    [carbs,lipids,proteins,fibre] = set_meal(time_of_day);
	    % find the glycemic load from the meal input
	    [glucose_output, GL] = food(carbs, lipids, proteins, fibre, time_since_last_meal);
	    glycemic_load_new = GL;
	else
	    glucose_output = 0;
	    glycemic_load_new = 0;
	end
end

function[carbs,lipids,proteins,fibre] = set_meal(time_of_day)
	Meals = GUT_PARAMS.setget_meals;
    % check if time_of_day is a meal time
    if time_of_day > 0
        % set the meal
        carbs = Meals(time_of_day,1);
        lipids = Meals(time_of_day,2);
        proteins = Meals(time_of_day,3);
        fibre = Meals(time_of_day,4);
    else
        carbs = 0;
        lipids = 0;
        proteins = 0;
        fibre = 0;
    end
end
