function [glucose] = find_gl_glucose(time_since_last_meal, glycemic_load)
    try
        % calling the interpolation fit from static storage
        [low_gl_glucose,high_gl_glucose] = GUT_PARAMS.setget_interpolation_fit;
        % doing calculations
        if glycemic_load >= 20
            glucose = high_gl_glucose(time_since_last_meal);
        elseif glycemic_load >= 10 && glycemic_load < 20
            glucose = low_gl_glucose(time_since_last_meal);
        else
            glucose = 0;
        end
        % conversion from mg/dL -> mmol/dL 
        % 1 mg glucose = 0.005551 mmol glucose
        glucose = glucose * 0.005551;
        % convert to mmol/L
        glucose = glucose * 10;

        % solve NaN errors
        if glucose < 0
            glucose = 0;
        elseif isnan(glucose)
            fprintf('glucose is NaN in find_gl_glucose at time: %d\n', GUT_PARAMS.setget_time);
        end
    catch ERR
        fprintf('Error in find_gl_glucose at time: %d\n', GUT_PARAMS.setget_time);
        fprintf('Error Message: %s\n', ERR.message);
        fprintf('Glucose was: %d before the error was thrown\n', GUT_PARAMS.setget_glucose_output);
        rethrow(ERR);
    end
end
