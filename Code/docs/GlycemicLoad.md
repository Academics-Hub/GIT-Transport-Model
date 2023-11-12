> Documentation for [GlycemicLoad.m](Code/src/GlycemicLoad.m)

```Matlab
function [glycemic_load] = GlycemicLoad(carbs, proteins, lipids, fiber)
	glycemic_load = 19.27+(0.39*carbs)-(0.21*lipids)-(0.01*proteins^2)-(0.01*fiber^2);
end
```

This function outputs the glucose concentration for the macro-nutrients in the ingested food. 

It first calculates the **Glycemic Load** of the food:
$$
GL=19.27+(0.39*[carbs])-(0.21*[lipids])-(0.01*[proteins]^2)-(0.01*[fibre]^2)
$$
This is taken from [Development of a Prediction Model to Estimate the Glycemic Load of Ready-to-EatMeals](../../Research/Development%20of%20a%20Prediction%20Model%20to%20Estimate%20the%20Glycemic%20Load%20of%20Ready-to-EatMeals.pdf)