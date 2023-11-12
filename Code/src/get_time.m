% set the time of day after each call of the GutCalc function
function [time] = get_time(previous_time,time_step)
    time = previous_time + time_step;
end