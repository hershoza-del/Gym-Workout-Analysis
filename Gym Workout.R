library(readxl)
gym <- read_excel("Downloads/Gym Workout.xlsx")

#t-test of average bpm and gender
t.test(Avg_BPM ~ Gender, data = gym)

      Welch Two Sample t-test

data:  Avg_BPM by Gender
t = -0.30056, df = 959.7, p-value = 0.7638
alternative hypothesis: true difference in means between group Female and group Male is not equal to 0
95 percent confidence interval:
 -2.085839  1.531786
sample estimates:
mean in group Female   mean in group Male 
            143.6212             143.8982 

#anova test of average bpm and workout type
anova_model <- aov(Avg_BPM ~ Workout_Type, data = gym)
summary(anova_model)
              Df Sum Sq Mean Sq F value Pr(>F)
Workout_Type   3    154   51.19   0.248  0.863
Residuals    969 199866  206.26    

TukeyHSD(anova_model)
Tukey multiple comparisons of means
  95% family-wise confidence level

Fit: aov(formula = Avg_BPM ~ Workout_Type, data = gym)

$Workout_Type
                      diff       lwr      upr     p adj
HIIT-Cardio     -0.3653092 -3.762099 3.031480 0.9925952
Strength-Cardio  0.4237574 -2.839942 3.687456 0.9871390
Yoga-Cardio     -0.6224137 -3.949973 2.705146 0.9632231
Strength-HIIT    0.7890666 -2.598541 4.176674 0.9322306
Yoga-HIIT       -0.2571045 -3.706279 3.192070 0.9974974
Yoga-Strength   -1.0461711 -4.364357 2.272015 0.8491107

#chi-square test of gender and workout type 
chisq.test(table(gym$Gender, gym$Workout_Type))

      Pearson's Chi-squared test

data:  table(gym$Gender, gym$Workout_Type)
X-squared = 1.4013, df = 3, p-value = 0.7052

#correlation test 
cor.test(gym$`Session_Duration (hours)`, gym$Calories_Burned)

	    Pearson's product-moment correlation
      
data:  gym$`Session_Duration (hours)` and gym$Calories_Burned
t = 67.592, df = 971, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 0.8964576 0.9185616
sample estimates:
      cor 
0.9081404

#linear regression model 
reg <- lm(Fat_Percentage ~ Calories_Burned + Avg_BPM, data = gym)
summary(reg)

Call:
lm(formula = Fat_Percentage ~ Calories_Burned + Avg_BPM, data = gym)

Residuals:
     Min       1Q   Median       3Q      Max 
-13.5256  -3.5689  -0.0687   3.7317  11.7744 

Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)     25.0847369  1.5674317  16.004   <2e-16 ***
Calories_Burned -0.0154453  0.0006069 -25.451   <2e-16 ***
Avg_BPM          0.0965211  0.0115341   8.368   <2e-16 ***
  ---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.852 on 970 degrees of freedom
Multiple R-squared:  0.4004,	Adjusted R-squared:  0.3992 
F-statistic: 323.9 on 2 and 970 DF,  p-value: < 2.2e-16

#poisson regression model
pois <- glm(Fat_Percentage ~ Calories_Burned + Avg_BPM, data = gym)
summary(pois)

Call:
glm(formula = Fat_Percentage ~ Calories_Burned + Avg_BPM, data = gym)

Coefficients:
                  Estimate Std. Error t value Pr(>|t|)    
(Intercept)     25.0847369  1.5674317  16.004   <2e-16 ***
Calories_Burned -0.0154453  0.0006069 -25.451   <2e-16 ***
Avg_BPM          0.0965211  0.0115341   8.368   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

(Dispersion parameter for gaussian family taken to be 23.53979)

    Null deviance: 38083  on 972  degrees of freedom
Residual deviance: 22834  on 970  degrees of freedom
AIC: 5839.7

Number of Fisher Scoring iterations: 2

