> Documentation for [Food.m](../src/Food.m)

```Matlab
function [glucose] = Food(carbs, lipids, protein, fibre, time_step)
    gl = GlycemicLoad(carbs, lipids, protein, fibre);
    glucose = find_gl_glucose(time_step, gl);
end
```

This function uses [GlycemicLoad](GlycemicLoad.md) & [find_gl_glucose](find_gl_glucose.md) to return the [glucose] in the blood after a meal.