% main script to test functions

% first initialise food -> use daily recommendations (grams)
carbs = 50;
proteins = 20;
lipids = 10;
fibre = 5;
% time step
time_vector = linspace(0,14400,120); % seconds
% creating glucose over time
glucose = Food(carbs,lipids,proteins,fibre, time_vector); 
glucose(glucose < 0) = 0; % cannot be greater than 0
glucose = glucose*0.00001; % conversion from mg/dL -> g/mL

plot(time_vector,glucose)
xlabel('time (s)')
ylabel('glucose (g/ml)')

% TODO, create impulse function of food input
