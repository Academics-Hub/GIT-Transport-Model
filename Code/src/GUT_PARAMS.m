classdef GUT_PARAMS
    % Sets and gets:
    %   - start time
    %   - simulation duration
    %   - time
    %   - time since last meal
    %   - current glycemic load
    %   - glucose output
    %   - glucose absorption
    %   - O2 consumption
    methods (Static)
        % function to set and get the start time
        function START_TIME = setget_start_time(start_time)
            persistent ST_storage;
            if nargin
                ST_storage = start_time;
            end
            START_TIME = ST_storage; 
        end 
        % function to set and get the simulation duration
        function SIMULATION_DURATION = setget_simulation_duration(simulation_duration)
            persistent SD_storage;
            if nargin
                SD_storage = simulation_duration;
            end
            SIMULATION_DURATION = SD_storage; 
        end
        % function to set and get the time
        function TIME = setget_time(time)
            persistent T_storage;
            if nargin
                T_storage = time;
            end
            TIME = T_storage; 
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
    end
end