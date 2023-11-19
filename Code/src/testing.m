clear
clc
cla

% main script to test functions

% testing overall model things
GutFlowRate = 500; %ml / min
GutFlowRate = GutFlowRate /1000;

% initializing Arterial things
ArterialSpO2 = 0.98; 
ArterialGlucose = 5;  %mmol / L
ArterialInsulin = 10; %μU / mL
ArterialInsulin = ArterialInsulin * 0.039 * 6000 / 1000; %mmol/L
Arterial = [ArterialSpO2, ArterialGlucose, ArterialInsulin];

step = 0.5; % seconds
Gut = [40, 1]; % initializing Gut to what we'll recommend

% Simulation time
duration = 24 * 3600; % 24 hours in seconds
time = 0:step:duration;

% Initialize arrays to store results
GutOut_glucose_values = zeros(size(time));
GutNew_glucose_values = zeros(size(time));
%J_glucose_values = zeros(size(time));

% Run the simulation
for i = 1:length(time)
    [GutOut_glucose, GutNew_glucose] = glucose_absorption(ArterialGlucose, 1, GutFlowRate, ArterialInsulin, step);
    
    % Store results
    GutOut_glucose_values(i) = GutOut_glucose;
    GutNew_glucose_values(i) = GutNew_glucose;
    %J_glucose_values(i)= J_glucose;
    
    % Update Gut for the next iteration
    Gut = [GutNew_glucose, 1]; % assuming 1 for simplicity, update as needed
end

% Plot the results
figure;
plot(time, GutOut_glucose_values, 'b', 'LineWidth', 2);
hold on;
plot(time, GutNew_glucose_values, 'r', 'LineWidth', 2);
xlabel('Time (seconds)');
ylabel('Glucose Concentration');
legend('Gut Out Glucose', 'Gut New Glucose');
title('Glucose Absorption in the Gut Over 24 Hours');
grid on;
hold off;
