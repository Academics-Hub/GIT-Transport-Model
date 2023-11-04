**Absorption in the GIT**

Interesting reads on blood sugar:

<https://www.otsuka.co.jp/en/health-and-illness/glycemic-index/>

![[../Attachments/Pasted image 20231025174301.png]]
# Step 1:

How much energy does the GI system use?

This can then be used to estimate O2 and CO2 usage.

We will need to do this per system:

1)  Mouth (how much energy is used in mastication)
    
    1.  Will then need to input 1) how long chewed and 2) how hard the
        food was to chew
        
        1.  <https://www.science.org/doi/10.1126/sciadv.abn8351>

2)  Oesophagus

3)  Stomach

4)  Small intestine

5)  Large intestine

6)  Defection

With this section, it will be time dependent as food moving through will
cause more energy to be utilised by each subsystem. So we will need to
look at that.

With this whole section it may be time dependent as blood sugar will
also change over time.

# Step 2:

Based on the food content, what is the change experienced in the blood
glucose?

From the literature, I think the best way would be:

Have some sort of user interface where the user / Dr Stacey can input:

1)  Fasting blood glucose or glucose levels prior to the meal (we can
    also give an option to choose the normal level of glucose (The
    expected values for normal fasting blood glucose concentration
    are between 70 mg/dL (3.9 mmol/L) and 100 mg/dL (5.6 mmol/L) -WHO,
    we can use a value of )

2)  Food content:
    
    1.  g carbohydrate
    
    2.  g fat
    
    3.  g protein
    
    4.  g fiber

Option 1:

Using this we can predict the GL of the food using:

GL = 19.27 + (0.39 × available carbohydrate) – (0.21 × fat) – (0.01 ×
protein<sup>2</sup>) – (0.01 × fiber<sup>2</sup>)

Reference for this predictive model:

<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8625555/>

![[../Attachments/Pasted image 20231025174348.png]]

Then based of the GL – predict blood glucose spike using research such
as:
- Study on how GL effects blood glucose: [https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5240084/](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5240084/)
	- normal group (BMI = 18.5-24.9)
	- overweight group (BMI=25.0-29.9)
	- Low GL meal (66% carbs, 17% proteins and 17% fats)
	- High GL meal (60, 10, 20%)
	- Total 483 kcal
	- Capillary blood test
	- No difference between males and females
	- Average calorie intake
		- Males overweight: 2211.4+-368.7
		- Males normal: 2514.3 +- 223.8
		- Females overweight: 2495+-918
		- Females normal: 2064+-562
	- Results:
		- ![[../Attachments/Pasted image 20231025174942.png]]
	
Option 2:

More complicated approach <https://arxiv.org/pdf/1901.07467.pdf>

Option 3:

Somewhere in between those two but still quite complex:

<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3320833/>

It seems that the more complex models would help with insulin levels as
well but insulin levels can be step 3

# Step 3 

Blood insulin levels – need to find some type of correlation to raise in
sugar to raise in insulin

May only be able to indicate raised, normal ect but will continue to
look.

Assumptions of the model:

1)  General vitamin and mineral absorption does not contribute to blood
    glucose leves

Exceptions: we can include these as a checklist (i.e., did you consume
these) and then decrease the glucose concentration by what is linked in
the literature?

  - <https://www.healthline.com/nutrition/blood-sugar-supplements#TOC_TITLE_HDR_5>

<!-- end list -->

2)  The person has normal insulin responses
