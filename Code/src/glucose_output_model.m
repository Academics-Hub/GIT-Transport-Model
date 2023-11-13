function [glycemic_load_new,glucose_output] = glucose_output_model(time, time_step, time_since_last_meal, Insulin, glycemic_load)
    % get if it is a meal time
    time_of_day = check_meal_time(time);
    Meal = set_meal(time);
    % Meal inputs
    carbs = Meal.carbs;
    lipids = Meal.lipids;
    proteins = Meal.proteins;
    fibre = Meal.fibre;
    % if time since last meal is valid, i.e. its still in its absorption period of food
    if time_since_last_meal > 0 && time_of_day == 0
        glucose_output = find_gl_glucose(time_since_last_meal, glycemic_load);
        glycemic_load_new = glycemic_load;
        % I assume that there will be a different rate of energy consumption during a time period post a meal (energy of digestion)
    elseif time_since_last_meal == 0 && time_of_day > 0
        [glucose_output, GL] = food(carbs, lipids, proteins, fibre, time_since_last_meal);
        glycemic_load_new = GL;
    else
        glucose_output = 0;
        glycemic_load_new = 0;
    end
end

function[Meal] = set_meal(time_of_day)
    % these need researched values
    % breakfast
    if time_of_day == 1
        Meal.carbs = 50;
        Meal.lipids = 10;
        Meal.proteins = 20;
        Meal.fibre = 10;
    % lunch
    elseif time_of_day == 2
        Meal.carbs = 50;
        Meal.lipids = 10;
        Meal.proteins = 20;
        Meal.fibre = 10;
    % dinner
    elseif time_of_day == 3
        Meal.carbs = 50;
        Meal.lipids = 10;
        Meal.proteins = 20;
        Meal.fibre = 10;
    else
        Meal.carbs = 0;
        Meal.lipids = 0;
        Meal.proteins = 0;
        Meal.fibre = 0;
    end
end