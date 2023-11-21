function[time_of_day] = check_meal_time(time)
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

    %if time == 7.000000e+00 % check if time is 07h00
    %    time_of_day = 1;
    %    %fprintf('Breakfast time at:%d\n', time);
    %elseif time == 1.300000e+01 % check if time is 12h00
    %    time_of_day = 2;
    %    %fprintf('Lunch time at:%d\n', time);
    %elseif time == 1.900000e+01 % check if time is 19h00
    %    time_of_day = 3;
    %    %fprintf('Dinner time at:%d\n', time);
    %else
    %    time_of_day = 0;
    %end
end
