time_series = [0.00000000001,900,1800,2700,3600,5400,7200]; % seconds
low_gl_glucose_data = [83,89.1,96.1,97.9,93.4,89.7,88.6];
%low_gl_glucose_data = zscore(low_gl_glucose_data);
high_gl_glucose_data = [82.3,95.1,110.2,106.1,105.5,93.3,93.3];
%high_gl_glucose_data = zscore(high_gl_glucose_data);
% fitting polynomials to the data -> currently a 5th degree polynomial fit
%low_gl_glucose = polyfit(time_series,low_gl_glucose_data,3);
%high_gl_glucose = polyfit(time_series,high_gl_glucose_data,3);

% Fit: Low Glucose
[xData, yData] = prepareCurveData( time_series, low_gl_glucose_data );

% Set up fittype and options.
ft = fittype( 'logistic' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-1.5998328635923 -0.000253244130341171 -315.483379754011];

% Fit model to data.
low_gl_glucose = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'Low GL fit' );
h = plot( low_gl_glucose, xData, yData );
legend( h, 'low_gl_glucose_data vs. time_series', 'Sigmoid fit', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'time_series', 'Interpreter', 'none' );
ylabel( 'low_gl_glucose_data', 'Interpreter', 'none' );
grid on

% Fit: High Glucose
[xData, yData] = prepareCurveData( time_series, high_gl_glucose_data );

% Set up fittype and options.
ft = fittype( 'logistic' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [-1.5998328635923 -0.000253244130341171 -315.483379754011];

% Fit model to data.
high_gl_glucose = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'High GL fit' );
h = plot( high_gl_glucose, xData, yData );
legend( h, 'high_gl_glucose_data vs. time_series', 'Sigmoid fit', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'time_series', 'Interpreter', 'none' );
ylabel( 'high_gl_glucose_data', 'Interpreter', 'none' );
grid on
