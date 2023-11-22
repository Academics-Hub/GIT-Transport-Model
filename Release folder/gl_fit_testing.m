% defining data
time_series = [0,900,1800,2700,3600,5400,7200]; % seconds
low_gl_glucose_data = [83,89.1,96.1,97.9,93.4,89.7,88.6];
high_gl_glucose_data = [82.3,95.1,110.2,106.1,105.5,93.3,93.3];

% get fit objects
% polynomial fit
[low_gl_polynomial_fit,high_gl_polynomial_fit,low_gl_polynomial_xdata,low_gl_polynomial_ydata,high_gl_polynomial_xdata,high_gl_polynomial_ydata] = gl_polynomial_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
% fourier fit
[low_gl_fourier_fit,high_gl_fourier_fit,low_gl_fourier_xdata,low_gl_fourier_ydata,high_gl_fourier_xdata,high_gl_fourier_ydata] = gl_fourier_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
% gaussian fit
[low_gl_gaussian_fit,high_gl_gaussian_fit,low_gl_gaussian_xdata,low_gl_gaussian_ydata,high_gl_gaussian_xdata,high_gl_gaussian_ydata] = gl_gaussian_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
% interpolation fit
[low_gl_interpolation_fit,high_gl_interpolation_fit,low_gl_interpolation_xdata,low_gl_interpolation_ydata,high_gl_interpolation_xdata,high_gl_interpolation_ydata] = gl_interpolation_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
% smoothing spline fit
[low_gl_smoothing_spline_fit,high_gl_smoothing_spline_fit,low_gl_smoothing_spline_xdata,low_gl_smoothing_spline_ydata,high_gl_smoothing_spline_xdata,high_gl_smoothing_spline_ydata] = gl_smoothing_spline_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);
% sum of sines fit
[low_gl_sum_of_sines_fit,high_gl_sum_of_sines_fit,low_gl_sum_of_sines_xdata,low_gl_sum_of_sines_ydata,high_gl_sum_of_sines_xdata,high_gl_sum_of_sines_ydata] = gl_sum_of_sines_fit(time_series, low_gl_glucose_data, high_gl_glucose_data);

% plotting low gl fits
figure('Name','Low GL fits')
hold on
plot(time_series, low_gl_glucose_data, 'o', 'Color', "#A2142F");
plot(low_gl_polynomial_fit, 'r');
plot(low_gl_fourier_fit, 'g');
plot(low_gl_gaussian_fit, 'b');
plot(low_gl_interpolation_fit, 'k');
plot(low_gl_smoothing_spline_fit, 'm');
plot(low_gl_sum_of_sines_fit, 'c');
legend('low_gl_glucose_data','low_gl_polynomial_fit','low_gl_fourier_fit','low_gl_gaussian_fit','low_gl_interpolation_fit','low_gl_smoothing_spline_fit','low_gl_sum_of_sines_fit', 'Location', 'NorthWest', 'Interpreter', 'None');
xlabel( 'time_series', 'Interpreter', 'none' );
ylabel( 'low_gl_glucose_data', 'Interpreter', 'none' );
grid on
hold off

% plotting high gl fits
figure('Name','High GL fits')
hold on
plot(time_series, high_gl_glucose_data, 'o', 'Color', "#A2142F");
plot(high_gl_polynomial_fit, 'r');
plot(high_gl_fourier_fit, 'g');
plot(high_gl_gaussian_fit, 'b');
plot(high_gl_interpolation_fit, 'k');
plot(high_gl_smoothing_spline_fit, 'm');
plot(high_gl_sum_of_sines_fit, 'c');
legend('high_gl_glucose_data','high_gl_polynomial_fit','high_gl_fourier_fit','high_gl_gaussian_fit','high_gl_interpolation_fit','high_gl_smoothing_spline_fit','high_gl_sum_of_sines_fit', 'Location', 'NorthEast', 'Interpreter', 'None');
xlabel( 'time_series', 'Interpreter', 'none' );
ylabel( 'high_gl_glucose_data', 'Interpreter', 'none' );
grid on
hold off

