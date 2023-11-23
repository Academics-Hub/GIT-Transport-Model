function time_of_day = check_meal_time(time)
    % conversion to 24h00 hours format by converting seconds -> hours
    time = mod(time,86400)/3600;
    Meal_times = GUT_PARAMS.setget_meal_times;
    % check if time_of_day is a meal time
    if ismember(time, Meal_times)
        % find the index of the meal time
        time_of_day = find(Meal_times == time);
    else
        time_of_day = 0;
    end
end
