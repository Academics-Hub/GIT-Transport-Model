clear
clc
cla

% main script to test functions

% testing overall model things
GutFlowRate = 500; %ml / min
GutFlowRate = GutFlowRate /1000;
Cb = 1.92;
Hb = 140;

% initializing Arterial things
ArterialSpO2 = 0.98;
ArterialGlucose = 5;  %mmol / L
ArterialInsulin = 10; %μU / mL
ArterialInsulin = ArterialInsulin * 0.039 * 6000 / 1000; %mmol/L
Arterial = [ArterialSpO2, ArterialGlucose, ArterialInsulin];

step = 0.5; % seconds
Gut = [40, 1]; % initializing Gut to what we'll recommend
Gut(2) = cast(Gut(2)*10, 'double'); % conversion to mmol/L
% Simulation time
duration = 24 * 3600; % 24 hours in seconds
time = 0:step:duration;

% Initialize arrays to store results
Gut_O2_values = zeros(size(time));
Gut_spO2_values = zeros(size(time));
Gut_CO2_values = zeros(size(time));

%GutOut_glucose_values = zeros(size(time));
%GutNew_glucose_values = zeros(size(time));
%J_glucose_values = zeros(size(time));

% Run the simulation
for i = 1:length(time)
    [gut_O2, gut_spO2, gut_CO2] = O2_fed_fasting(GutFlowRate, Cb, Hb);

    % Store results
    Gut_O2_values(i) = gut_O2;
    Gut_spO2_values(i) = gut_spO2;
    Gut_CO2_values(i) = gut_CO2;
    %J_glucose_values(i)= J_glucose;

    % Update Gut for the next iteration
    %Gut = [GutNew_glucose, 1]; % assuming 1 for simplicity, update as needed
end

% Plot the results
figure;
plot(time, Gut_O2_values, 'b', 'LineWidth', 2);
hold on;
plot(time, Gut_CO2_values, 'r', 'LineWidth', 2);
xlabel('Time (seconds)');
ylabel('mg');
legend('Gut O2', 'Gut CO2');
title('Glucose Absorption in the Gut Over 24 Hours');
grid on;
hold off; 