function [glucose] = Food(carbs, lipids, protein, fibre, time_step)
    glycemic_load = GlycemicLoad(carbs, lipids, protein, fibre);
    glucose = find_gl_glucose(time_step, glycemic_load);
end



