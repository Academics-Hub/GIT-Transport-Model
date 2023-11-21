clear
clc
cla
% main script to test functions
%suite = testsuite;

% testing overall model things
GutFlowRate = 500;
% intialising Arterial things
ArterialSpO2 = 0.98;
ArterialGlucose = 4;
ArterialInsulin = 10;
%ArterialInsulin = ArterialInsulin * 0.039 * 6000 / 1000; %conversion to mmol/L
ArterialSpO2 = cast(ArterialSpO2, 'double');
ArterialGlucose = cast(ArterialGlucose, 'double');
time_step = 0.5; % seconds
Gut = [0.4,5]; % initialising Gut to what we'll recommend
ArterialInsulin = cast(ArterialInsulin, 'double');
%% check initial input values
assert( GutFlowRate >= 500 && GutFlowRate <= 750, 'Gut Flow Rate is not initialised to an appropriate physiological value\nIt should be between 500 and 750mL/min')
assert( ArterialSpO2 > 0 && ArterialSpO2 < 1, 'Arterial SpO2 is not initialised to an appropriate physiological value\nIt should be between 0 and 1')
assert( ArterialGlucose > 0 && ArterialGlucose < 5.6, 'Arterial Glucose is not initialised to an appropriate physiological value\nIt should be between 0 and 5.6mmol/L in a fasting state')
assert( ArterialInsulin > 0 && ArterialInsulin < 15, 'Arterial Insulin is not initialised to an appropriate physiological value\nIt should be between 0 and 15mU/L in a fasting state')
assert(Gut(1) >= 0.076 && Gut(1) <= 0.98, 'Gut SpO2 is not initialised to an appropriate physiological value\nIt should be between 0.076(7.6%) and 0.98(98%)')
% need normal gut glucose levels
ArterialGlucose = ArterialGlucose * 10; % conversion to mmol/L
Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
GutFlowRate = GutFlowRate/(1000); % conversion to L/min
Gut(1) = cast(Gut(1), 'double');
Gut(2) = cast(Gut(2), 'double');
if isnan(Gut(2))
	fprintf('Glucose input is a NaN')
	return
end
duration = 24*3600; % seconds


% storing gut parameters
% to chooose a type of curve fitting for the glucose output, choose one of the following numbers:
% 1 - polynomial fitting
% 2 - fourier fitting
% 3 - gaussian fitting
% 4 - interpolation fitting
% 5 - smoothing spline fitting
% 6 - sum of sines fitting
% 7 - Gaylard fit
% 8 - Gaylard2 fit

% start_time -> will shift the meal times -> 24h00 format
start_time = 0;
% Meal times -> 24h00 format
Meal_times = [ 7 , 13, 19 ];
% Meals -> must equal the number of meal times -> each row -> carbs proteins lipids fibres -> grams
% values assuming an RDA for a 19-30yr old, eating 2400kcal per day, weighing 70kg
	% for a 2400kcal diet, it is recommended that 25-35% be lipids. Therefore 2400*0.275 = 660kcal
	% 1g of lipids = 9kcal, therefore 660/9 = 73.33g total
	% for proteins 0.66 g/kg of body weight is recommended, therefore 0.66*70 = 46.2g
	% 14g of fibre per 1000kcal is recommended, therefore 14*2.4 = 33.6g

Meals = [   43.33 24.44 15.4 11.2;
            43.33 24.44 15.4 11.2;
            43.33 24.44 15.4 11.2
        ];
%% Test meals = meal time
assert( size(Meals,1) == numel(Meal_times), 'Meals does not have the same number of rows as number of meal times')
% define patient
% sex: male = 0
% sex: female = 1
sex = 0;
weight = 70; %kg
height = 180; %cm
age = 25; %years
patient = [ sex, weight, height, age ];
initialise_gut_params(5, Gut(2), ArterialInsulin, time_step, start_time, Meal_times, Meals, patient);

% creating storage vectors for things we want to plot
Gut_SpO2_vector = zeros(1,duration/time_step);
Gut_Glucose_vector = zeros(1,duration/time_step);
Gut_Glucose_Absorption_vector = zeros(1,duration/time_step);
Venous_SpO2_vector = zeros(1,duration/time_step);
Venous_Glucose_vector = zeros(1,duration/time_step);
Insulin_vector = zeros(1,duration/time_step);
Time_vector = zeros(1,duration/time_step);
Time_since_last_meal_vector = zeros(1,duration/time_step);
Glycemic_load_vector = zeros(1,duration/time_step);
Gut_Glucose_Output_vector = zeros(1,duration/time_step);
Gut_Oxygen_vector = zeros(1,duration/time_step);
Gut_Co2_vector = zeros(1,duration/time_step);

for i = 0:time_step:duration-0.5 % looping over seconds in a day
	[Gut,GutOut] = GutCalc(GutFlowRate,Gut,Arterial,time_step);

	Gut_SpO2_vector((i/time_step)+1) = Gut(1);

	Gut_Glucose_vector((i/time_step)+1) = Gut(2);

	Gut_Glucose_Absorption_vector((i/time_step)+1) = GUT_PARAMS.setget_glucose_absorption;

	Time_vector((i/time_step)+1) = GUT_PARAMS.setget_time-0.5;

	Time_since_last_meal_vector((i/time_step)+1) = GUT_PARAMS.setget_time_since_last_meal;

	Glycemic_load_vector((i/time_step)+1) = GUT_PARAMS.setget_current_glycemic_load;

	Venous_SpO2_vector((i/time_step)+1) = GutOut(1);

	Venous_Glucose_vector((i/time_step)+1) = GutOut(2);

	Insulin_vector((i/time_step)+1) = GutOut(3);

	Gut_Glucose_Output_vector((i/time_step)+1) = GUT_PARAMS.setget_glucose_output;

    Gut_Oxygen_vector((i/time_step)+1) = GUT_PARAMS.setget_gut_O2;

    Gut_Co2_vector((i/time_step)+1) = GUT_PARAMS.setget_gut_CO2;
end

% plotting things
% convert time vector to hours -> 24h00 format
Time_vector = Time_vector/3600;
%fprintf('Time: %d\n', Time_vector(1))
%for i = 1:duration/3600
%	index = i*2*3600;
%	fprintf('Time: %d\n', int8(Time_vector(index)))
%end        
% convert time since last meal to minutes
Time_since_last_meal_vector = Time_since_last_meal_vector/3600;
% plotting Gut things
figure(1)

subplot(4,1,1)
plot(Time_vector,Gut_Glucose_vector)
title('Gut Glucose')
xlabel('Time (hrs)')
ylabel('Glucose (mmol/L)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(4,1,2)
plot(Time_vector, Gut_Glucose_Absorption_vector)
title('Change in Gut Glucose Absorption')
xlabel('Time (hrs)')
ylabel('Glucose (mmol/L)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(4,1,3)
plot(Time_vector,Glycemic_load_vector)
title('Glycemic load')
xlabel('Time (hrs)')
ylabel('Glycemic load', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(4,1,4)
plot(Time_vector,Gut_Glucose_Output_vector)
title('Gut Glucose Output')
xlabel('Time (hrs)')
ylabel('Glucose (mmol/L)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

% plotting Arterial things
figure(2)

subplot(3,2,1)
plot(Time_vector,Venous_Glucose_vector)
title('Change in Venous Glucose')
xlabel('Time (hrs)')
ylabel('Glucose (mmol/L)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,2)
plot(Time_vector,Insulin_vector)
title('Change in Insulin')
xlabel('Time (hrs)')
ylabel('Insulin (\muU/L)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,3)
Gut_Oxygen_vector = Gut_Oxygen_vector * 60; % mol/min -> mol/sec
plot(Time_vector,Gut_Oxygen_vector)
title('Change of Gut O2')
xlabel('Time (hrs)')
ylabel('Oxygen (mole)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,4)
Gut_Co2_vector = Gut_Co2_vector * 60; % mol/min -> mol/sec 
plot(Time_vector,Gut_Co2_vector)
title('Change of Gut CO2')
xlabel('Time (hrs)')
ylabel('CO2 (mole)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,5)
Venous_SpO2_vector = Venous_SpO2_vector * 100; % decimal -> percentage
plot(Time_vector,Venous_SpO2_vector)
title('Venous SpO2')
xlabel('Time (hrs)')
ylabel('SpO2 (%)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,6)
%figure(3)
Gut_SpO2_vector = Gut_SpO2_vector * 100; % decimal -> percentage
plot(Time_vector,Gut_SpO2_vector) 
title('Gut SpO2')
xlabel('Time (hrs)')
ylabel('SpO2 (%)', 'Rotation', 0)
grid on
xlim([0,duration/3600])
xticks(0:1:duration/3600)

% print the first 20 values of the Gut_SpO2_vector
%for i = 1:20
%    fprintf('Gut SpO2: %d\n', Gut_SpO2_vector(i))
%end


