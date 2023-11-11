function [glucose] = Food(carbs, lipids, protein, fibre, time_step)
    gl = GlycemicLoad(carbs, lipids, protein, fibre);
    glucose = find_gl_glucose(time_step, gl);
end



