classdef GUT_PARAMS
    % Sets and gets:
    %   - time
    %   - previous time
    %   - time since last meal
    %   - time step
    %   - current glycemic load
    %   - glucose output
    %   - glucose absorption
    %   - O2 consumption
    %   - initial input of insulin
    %   - gut O2
    %   - gut CO2
    %   - glucose input
    %   - meal
    %   - meal times
    %   - start time

    % call example:
    %   setter -> GUT_PARAMS.setget_time(0)
    %   getter -> GUT_PARAMS.setget_time
    methods (Static)
        % function to set and get the time
        function TIME = setget_time(time)
            persistent T_storage;
            if nargin
                T_storage = time;
            end
            TIME = T_storage; 
        end
        % function to set and get the previous time
        function PREVIOUS_TIME = setget_previous_time(previous_time)
            persistent PT_storage;
            if nargin
                PT_storage = previous_time;
            end
            PREVIOUS_TIME = PT_storage; 
        end
        % function to set and get the time since last meal
        function TIME_SINCE_LAST_MEAL = setget_time_since_last_meal(time_since_last_meal)
            persistent TSLM_storage;
            if nargin
                TSLM_storage = time_since_last_meal;
            end
            TIME_SINCE_LAST_MEAL = TSLM_storage; 
        end
        % function to set and get the time step
        function TIME_STEP = setget_time_step(time_step)
            persistent TS_storage;
            if nargin
                TS_storage = time_step;
            end
            TIME_STEP = TS_storage; 
        end
        % function to set and get the current glycemic load
        function CURRENT_GLYCEMIC_LOAD = setget_current_glycemic_load(current_glycemic_load)
            persistent CGL_storage;
            if nargin
                CGL_storage = current_glycemic_load;
            end
            CURRENT_GLYCEMIC_LOAD = CGL_storage; 
        end
        % function to set and get the glucose output
        function GLUCOSE_OUTPUT = setget_glucose_output(glucose_output)
            persistent GO_storage;
            if nargin
                GO_storage = glucose_output;
            end
            GLUCOSE_OUTPUT = GO_storage; 
        end
        % function to set and get the glucose absorption
        function GLUCOSE_ABSORPTION = setget_glucose_absorption(glucose_absorption)
            persistent GA_storage;
            if nargin
                GA_storage = glucose_absorption;
            end
            GLUCOSE_ABSORPTION = GA_storage; 
        end
        % function to set and get the O2 consumption
        function O2_CONSUMPTION = setget_O2_consumption(O2_consumption)
            persistent O2C_storage;
            if nargin
                O2C_storage = O2_consumption;
            end
            O2_CONSUMPTION = O2C_storage; 
        end
        % function to set and get the initial insulin input
        function INITIAL_INSULIN_INPUT = setget_initial_insulin_input(initial_insulin_input)
            persistent III_storage;
            if nargin
                III_storage = initial_insulin_input;
            end
            INITIAL_INSULIN_INPUT = III_storage; 
        end
        % function to set and get gut O2
        function GUT_O2 = setget_gut_O2(gut_O2)
            persistent GO2_storage;
            if nargin
                GO2_storage = gut_O2;
            end
            GUT_O2 = GO2_storage; 
        end
        % function to set and get gut CO2
        function GUT_CO2 = setget_gut_CO2(gut_CO2)
            persistent GCO2_storage;
            if nargin
                GCO2_storage = gut_CO2;
            end
            GUT_CO2 = GCO2_storage; 
        end
        % function to set and get glucose input 
        function GLUCOSE_INPUT = setget_glucose_input(glucose_input)
            persistent GI_storage;
            if nargin
                GI_storage = glucose_input;
            end
            GLUCOSE_INPUT = GI_storage; 
        end
        % function to do interpolation fit once for efficiency
        function [HIGH_GL_FIT, LOW_GL_FIT] = setget_interpolation_fit(high_gl_fit, low_gl_fit)
            persistent LOW_GL_FIT_STORAGE;
            persistent HIGH_GL_FIT_STORAGE;
            if nargin
                LOW_GL_FIT_STORAGE = low_gl_fit;
                HIGH_GL_FIT_STORAGE = high_gl_fit;
            end
            HIGH_GL_FIT = HIGH_GL_FIT_STORAGE;
            LOW_GL_FIT = LOW_GL_FIT_STORAGE;
        end
        % function to set and get meals
        function MEALS = setget_meals(meals)
            persistent M_storage;
            if nargin
                M_storage = meals;
            end
            MEALS = M_storage; 
        end
        % function to set and get meal times    
        function MEAL_TIMES = setget_meal_times(meal_times)
            persistent MT_storage;
            if nargin
                MT_storage = meal_times;
            end
            MEAL_TIMES = MT_storage; 
        end
        % function to set and get start time
        function START_TIME = setget_start_time(start_time)
            persistent ST_storage;
            if nargin
                ST_storage = start_time;
            end
            START_TIME = ST_storage; 
        end
        % function to set and get a patient array
        function PATIENT = setget_patient(patient)
            persistent P_storage;
            if nargin
                P_storage = patient;
            end
            PATIENT = P_storage; 
        end
    end
end
