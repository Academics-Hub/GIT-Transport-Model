> Documentation for [find_gl_glucose.m](Code/src/find_gl_glucose.m)

```Matlab
function [glucose] = find_gl_glucose(time_step, glycemic_load)
    % defining data
    time_series = [0;900;1800;2700;3600;5400;7200]; % seconds
    low_gl_glucose_data = [83;89.1;96.1;97.9;93.4;89.7;88.6];
    high_gl_glucose_data = [82.3;95.1;110.2;106.1;105.5;93.3;93.3];
    % fitting polynomials to the data -> currently a 5th degree polynomial fit
    low_gl_glucose = polyfit(time_series,low_gl_glucose_data,5);
    high_gl_glucose = polyfit(time_series,high_gl_glucose_data,5);
    % doing calculations
    if glycemic_load >= 20
        glucose = polyval(high_gl_glucose, time_step);
    elseif glycemic_load >= 10 && glycemic_load < 20
        glucose = polyval(low_gl_glucose, time_step);
    end
end
```
Using information from [The effects of meal glycemic load on blood glucose levels of adults with different body mass indexes](../../Research/The%20effects%20of%20meal%20glycemic%20load%20on%20blood%20glucose%20levels%20of%20adults%20with%20different%20body%20mass%20indexes.pdf), we can use this table:
![](../../Attachments/Pasted%20image%2020231111150050.png)
To estimate the new blood glucose level after a period of time following the meal.
If we assume a normal BMI (project brief said assume normal physiological conditions), then we can just use the left table.
According to the paper:
$$
\begin{align}
GL\geq20~&\implies~HIGH \\
10\leq GL < 20~&\implies~LOW
\end{align}
$$
We use `polyfit` to fit a polynomial to the data from the paper, for both high and low glycemic loads.
We then use `polyval` to find the glucose at a given time step after a meal.
==Note: we need to experiment with the extrapolation of the polynomial fit==
