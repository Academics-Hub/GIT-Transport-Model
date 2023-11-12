function[time_of_day] = check_meal_time(time)
    % conversion to 24h00 hours format by converting seconds -> hours
    time = time/3600;
    % check if time is 07h00
    if time == 7
        time_of_day = 1;
    % check if time is 12h00
    elseif time == 12
        time_of_day = 2;
    % check if time is 19h00
    elseif time == 19
        time_of_day = 3;
    else
        time_of_day = 0;
    end
end