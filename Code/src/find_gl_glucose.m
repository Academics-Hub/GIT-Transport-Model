function [glucose] = find_gl_glucose(time_since_last_meal, glycemic_load)
    % defining data
    time_series = [0,900,1800,2700,3600,5400,7200]; % seconds
    low_gl_glucose_data = [83,89.1,96.1,97.9,93.4,89.7,88.6];
        low_gl_glucose_data = zscore(low_gl_glucose_data);
    high_gl_glucose_data = [82.3,95.1,110.2,106.1,105.5,93.3,93.3];
        high_gl_glucose_data = zscore(high_gl_glucose_data);
    % fitting polynomials to the data -> currently a 5th degree polynomial fit
    low_gl_glucose = polyfit(time_series,low_gl_glucose_data,3);
    high_gl_glucose = polyfit(time_series,high_gl_glucose_data,3);
    % doing calculations
    if glycemic_load >= 20
        glucose = polyval(high_gl_glucose, time_since_last_meal);
    elseif glycemic_load >= 10 && glycemic_load < 20
        glucose = polyval(low_gl_glucose, time_since_last_meal);
    else
        glucose = 0;
    end
    % conversion from mg/dL -> mmol/dL 
    % 1 mg glucose = 0.005551 mmol glucose
    glucose = glucose * 0.005551;
    % convert to mmol/L
    glucose = glucose / 10;
    % solve NaN errors
    if isnan(glucose)
        glucose = 0;
    end
end