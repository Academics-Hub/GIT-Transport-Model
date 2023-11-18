classdef GUT_PARAMS
    % Sets and gets:
    %   - time
    %   - previous time
    %   - time since last meal
    %   - current glycemic load
    %   - glucose output
    %   - glucose absorption
    %   - O2 consumption
    %   - current increment of simulation, where total increments = simulation duration / time step

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
        % function to set and get current increment
        function CURRENT_INCREMENT = setget_current_increment(current_increment)
            persistent CI_storage;
            if nargin
                CI_storage = current_increment;
            end
            CURRENT_INCREMENT = CI_storage; 
        end
    end
end