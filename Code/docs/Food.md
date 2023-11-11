> Documentation for [Food.m](../src/Food.m)

```Matlab
function [glucose] = Food(carbs, proteins, lipids, fiber)
glucose = 19.27+(0.39*carbs)-(0.21*lipids)-(0.01*proteins^2)-(0.01*fiber^2);
end
```

This function outputs the glucose concentration for the macro-nutrients in the ingested food. 

It first calculates the **Glycemic Load** of the food:
$$
GL=19.27+(0.39*[carbs])-(0.21*[lipids])-(0.01*[proteins]^2)-(0.01*[fibre]^2)
$$


