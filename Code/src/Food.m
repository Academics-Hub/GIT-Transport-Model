function [food_glucose] = Food(carbs, lipids, protein, fibre, time)
    glycemic_load = GlycemicLoad(carbs, lipids, protein, fibre);
    food_glucose = find_gl_glucose(time, glycemic_load);
end



