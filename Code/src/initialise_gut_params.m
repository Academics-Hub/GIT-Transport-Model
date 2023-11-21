function initialise_gut_params(curve_fitting_choice, InitialGlucose, ArterialInsulin)
    % This function initialises the parameters for the gut model
    GUT_PARAMS.setget_time(0); % always intialise time to 0
    GUT_PARAMS.setget_previous_time(0); % always intialise previous time to 0
    GUT_PARAMS.setget_time_since_last_meal(-1); % always intialise time since last meal to -1
    GUT_PARAMS.setget_current_glycemic_load(0); % always intialise glycemic load to 0
    GUT_PARAMS.setget_glucose_output(0); % always intialise glucose output to 0
    GUT_PARAMS.setget_glucose_absorption(cast(0.0035, 'double'));
    GUT_PARAMS.setget_initial_insulin_input(ArterialInsulin);
    GUT_PARAMS.setget_glucose_input(InitialGlucose);
    time_series = [0,900,1800,2700,3600,5400,7200]; % seconds
    low_gl_glucose_data = [83,89.1,96.1,97.9,93.4,89.7,88.6];
    high_gl_glucose_data = [82.3,95.1,110.2,106.1,105.5,93.3,93.3];
    switch curve_fitting_choice
        case 1
            [low_gl_fit, high_gl_fit, ~, ~, ~, ~] = gl_polynomial_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
        case 2
            [low_gl_fit, high_gl_fit, ~, ~, ~, ~] = gl_fourier_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
        case 3
            [low_gl_fit, high_gl_fit, ~, ~, ~, ~] = gl_gaussian_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
        case 4
            [low_gl_fit, high_gl_fit, ~, ~, ~, ~] = gl_interpolation_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
        case 5
            [low_gl_fit, high_gl_fit, ~, ~, ~, ~] = gl_smoothing_spline_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
        case 6
            [low_gl_fit, high_gl_fit, ~, ~, ~, ~] = gl_sum_of_sines_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
    end
    GUT_PARAMS.setget_interpolation_fit(low_gl_fit, high_gl_fit);
end
