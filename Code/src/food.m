function [food_glucose,GL] = food(carbs, lipids, protein, fibre, time_since_last_meal)
    GL = glycemic_load(carbs, lipids, protein, fibre);
    food_glucose = find_gl_glucose(time_since_last_meal, GL);
end



