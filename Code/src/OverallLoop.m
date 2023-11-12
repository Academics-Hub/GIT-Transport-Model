clear;
clc;
cla;
KidneyFlowRate = 1000;
BrainFlowRate = 700;
GutFlowRate = 500;
LiverFlowRate = 1500;%ml/min of blood
MuscleFlowRate = 1300;
PancreasFlowRate   =   300;
TotalFlowRate  =  KidneyFlowRate+BrainFlowRate+GutFlowRate+LiverFlowRate+MuscleFlowRate+PancreasFlowRate;
%Remember to remove gut from this later
ArterialSpO2 = 0.98; % initializing the blood saturation at 98%
VenousMixedSpO2 = 0.98;%initializing venous SpO2 at same as ArterialSpO2 for testing the 'nothing happening' condition
ArterialGlucose = 4; %mmol/dL initializing at normal level
ArterialInsulin = 10;%μU/mL initializing at normal level
%Convention for organ levels is [PO2, Glucose], we'll do PO2 in Torr for now I
%guess, glucose in grams I guess? I have no idea how much glucose is stored in
%tissues at any given time
%Convention for blood levels is [SpO2, Glucose concentration, Insulin
%concentration]; %, mmol/dL, μU/mL respectively
Arterial = [ArterialSpO2, ArterialGlucose, ArterialInsulin];
Kidney = [40,1];
Liver = [40, 1];
Gut = [40, 1];
Brain = [40,1];
Pancreas = [40,1];
Lung = [40,1];
Muscle = [40,1];
step = 0.5;%step size in seconds

for i = 0:1:5 %overall outer loop. We'll just designate a time-step
    [Kidney,KidneyOut] = KidneyCalc(KidneyFlowRate,Kidney,Arterial, step);

    [Gut,GutOut] = GutCalc(GutFlowRate,Gut,Arterial, step);

    [Brain,BrainOut] = BrainCalc(BrainFlowRate,Brain,Arterial, step);

    [Pancreas,PancreasOut] = PancreasCalc(PancreasFlowRate,Pancreas,Arterial, step);

    [Liver,LiverOut] = LiverCalc(LiverFlowRate,Liver,Arterial);%This has to be changed to include the stream from the gut, will fiddle later

    [Muscle,MuscleOut] = MuscleCalc(MuscleFlowRate,Muscle,Arterial);

    MixedVenousSpO2 = (LiverOut(1)*LiverFlowRate+PancreasOut(1)*PancreasFlowRate+KidneyOut(1)*KidneyFlowRate+BrainOut(1)*BrainFlowRate+GutOut(1)*GutFlowRate+MuscleFlowRate*MuscleOut(1))/TotalFlowRate;

    MixedVenousGlucose = (LiverOut(2)*LiverFlowRate+PancreasOut(2)*PancreasFlowRate+KidneyOut(2)*KidneyFlowRate+BrainOut(2)*BrainFlowRate+GutOut(2)*GutFlowRate+MuscleFlowRate*MuscleOut(2))/TotalFlowRate;

    MixedVenousInsulin = (LiverOut(3)*LiverFlowRate+PancreasOut(3)*PancreasFlowRate+KidneyOut(3)*KidneyFlowRate+BrainOut(3)*BrainFlowRate+GutOut(3)*GutFlowRate+MuscleFlowRate*MuscleOut(3))/TotalFlowRate;
    %Will crunch these down into a single matrix operation once I've troubleshooted a bit
    %Remember to cut the Gut terms later once gut and liver are in series

    Venous = [MixedVenousSpO2, MixedVenousGlucose, MixedVenousInsulin];

    [Lung,LungOut] = LungCalc(TotalFlowRate,Lung,Venous, step);

    Arterial = LungOut;
end
