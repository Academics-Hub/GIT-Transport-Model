% main script to test functions

% testing overall model things
GutFlowRate = 500;
% intialising Arterial things
ArterialSpO2 = 0.98;
ArterialGlucose = 4;
ArterialInsulin = 10;
Arterial = [ArterialSpO2,ArterialGlucose,ArterialInsulin];
time_step = 0.5; % seconds
Gut = [40,1,0,-1,0]; % initialising Gut to what we'll recommend

% creating storage vectors for things we want to plot
Gut_SpO2_vector = zeros(1,86400/time_step);
Gut_Glucose_vector = zeros(1,86400/time_step);
Arterial_SpO2_vector = zeros(1,86400/time_step);
Arterial_Glucose_vector = zeros(1,86400/time_step);
Insulin_vector = zeros(1,86400/time_step);
Time_vector = zeros(1,86400/time_step);
Time_since_last_meal_vector = zeros(1,86400/time_step);
Glycemic_load_vector = zeros(1,86400/time_step);

for i = 0:time_step:86400 % looping over seconds in a day
    [Gut,GutOut] = GutCalc(GutFlowRate,Gut,Arterial,time_step);
    Gut_SpO2_vector((i/time_step)+1) = Gut(1);
    Gut_Glucose_vector((i/time_step)+1) = Gut(2);
    Time_vector((i/time_step)+1) = Gut(3);
    Time_since_last_meal_vector((i/time_step)+1) = Gut(4);
    Glycemic_load_vector((i/time_step)+1) = Gut(5);
    Arterial_SpO2_vector((i/time_step)+1) = GutOut(1);
    Arterial_Glucose_vector((i/time_step)+1) = GutOut(2);
    Insulin_vector((i/time_step)+1) = GutOut(3);
end

% plotting things
% convert time vector to hours -> 24h00 format
Time_vector = Time_vector/3600;
% convert time since last meal to minutes
Time_since_last_meal_vector = Time_since_last_meal_vector/60;
% plotting Gut things
figure(1)
subplot(2,1,1)
plot(Time_vector,Gut_SpO2_vector)
title('Gut SpO2')
xlabel('Time (s)')
ylabel('SpO2')
subplot(2,1,2)
plot(Time_vector,Gut_Glucose_vector)
title('Gut Glucose')
xlabel('Time (s)')
ylabel('Glucose')
subplot(2,2,1)
plot(Time_vector,Time_since_last_meal_vector)
title('Time since last meal')
xlabel('Time (s)')
ylabel('Time since last meal (s)')
subplot(2,2,2)
plot(Time_vector,Glycemic_load_vector)
title('Glycemic load')
xlabel('Time (s)')
ylabel('Glycemic load')
% plotting Arterial things
figure(2)
subplot(3,1,1)
plot(Time_vector,Arterial_SpO2_vector)
title('Arterial SpO2')
xlabel('Time (s)')
ylabel('SpO2')
subplot(3,1,2)
plot(Time_vector,Arterial_Glucose_vector)
title('Arterial Glucose')
xlabel('Time (s)')
ylabel('Glucose')
subplot(3,1,3)
plot(Time_vector,Insulin_vector)
title('Insulin')
xlabel('Time (s)')
ylabel('Insulin')
