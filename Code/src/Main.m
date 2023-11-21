clear
clc
cla
% main script to test functions

% testing overall model things
GutFlowRate = 500/1000;
% intialising Arterial things
ArterialSpO2 = 0.98;
ArterialGlucose = 4;
ArterialInsulin = 10;
ArterialInsulin = ArterialInsulin * 0.039 * 6000 / 1000; %conversion to mmol/L
ArterialSpO2 = cast(ArterialSpO2, 'double');
ArterialGlucose = cast(ArterialGlucose, 'double');
ArterialInsulin = cast(ArterialInsulin, 'double');
Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
time_step = 0.5; % seconds
Gut = [0.4,1]; % initialising Gut to what we'll recommend
Gut(1) = cast(Gut(1), 'double');
Gut(2) = cast(Gut(2), 'double');
if isnan(Gut(2))
	fprintf('Glucose input is a NaN')
	return
end
duration = 24*3600; % seconds


% storing gut parameters
GUT_PARAMS.setget_time(0); % always intialise time to 0
GUT_PARAMS.setget_previous_time(0); % always intialise previous time to 0
GUT_PARAMS.setget_time_since_last_meal(-1); % always intialise time since last meal to -1
GUT_PARAMS.setget_current_glycemic_load(0); % always intialise glycemic load to 0
GUT_PARAMS.setget_glucose_output(0); % always intialise glucose output to 0
GUT_PARAMS.setget_glucose_absorption(cast(0.0035, 'double'));
GUT_PARAMS.setget_initial_insulin_input(ArterialInsulin);

% creating storage vectors for things we want to plot
Gut_SpO2_vector = zeros(1,duration/time_step);
Gut_Glucose_vector = zeros(1,duration/time_step);
Gut_Glucose_Absorption_vector = zeros(1,duration/time_step);
Venous_SpO2_vector = zeros(1,duration/time_step);
Arterial_Glucose_vector = zeros(1,duration/time_step);
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

	Arterial_Glucose_vector((i/time_step)+1) = GutOut(2);

	Insulin_vector((i/time_step)+1) = GutOut(3);

	Gut_Glucose_Output_vector((i/time_step)+1) = GUT_PARAMS.setget_glucose_output;

    Gut_Oxygen_vector((i/time_step)+1) = GUT_PARAMS.setget_gut_O2;

    Gut_Co2_vector((i/time_step)+1) = GUT_PARAMS.setget_gut_CO2;
end

% plotting things
% convert time vector to hours -> 24h00 format
Time_vector = Time_vector/3600;
fprintf('Time: %d\n', Time_vector(1))
for i = 1:duration/3600
	index = i*2*3600;
	fprintf('Time: %d\n', int8(Time_vector(index)))
end        
% convert time since last meal to minutes
Time_since_last_meal_vector = Time_since_last_meal_vector/3600;
%% plotting Gut things
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
title('Gut Glucose Absorption')
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
plot(Time_vector,Arterial_Glucose_vector)
title('Change in Arterial Glucose')
xlabel('Time (hrs)')
ylabel('Glucose (mmol/L)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,2)
plot(Time_vector,Insulin_vector)
title('Change in Insulin')
xlabel('Time (hrs)')
ylabel('Insulin (mmol/dL)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,3)
Gut_Oxygen_vector = Gut_Oxygen_vector * 60; % mol/min -> mol/sec
plot(Time_vector,Gut_Oxygen_vector)
title('Change in Gut Oxygen')
xlabel('Time (hrs)')
ylabel('Oxygen (mole)', 'Rotation', 0)
grid on
xlim([0, duration/3600])
xticks(0:1:duration/3600)

subplot(3,2,4)
Gut_Co2_vector = Gut_Co2_vector * 60; % mol/min -> mol/sec 
plot(Time_vector,Gut_Co2_vector)
title('Change in Gut CO2')
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
