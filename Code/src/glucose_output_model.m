function [glycemic_load_new,glucose_output] = glucose_output_model(time, time_since_last_meal, Insulin, glycemic_load)
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
    % values assuming an RDA for a 19-30yr old
    % breakfast
    if time_of_day == 1
        carbs = 43.33;
        lipids = 10;
        proteins = 20;
        fibre = 10;
    % lunch
    elseif time_of_day == 2
        carbs = 43.33;
        lipids = 10;
        proteins = 20;
        fibre = 10;
    % dinner
    elseif time_of_day == 3
        carbs = 43.33;
        lipids = 10;
        proteins = 20;
        fibre = 10;
    else
        carbs = 0;
        lipids = 0;
        proteins = 0;
        fibre = 0;
    end
end