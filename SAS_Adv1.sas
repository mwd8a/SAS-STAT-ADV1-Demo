/* first, run chol_raw.sas to create sas data set CHOL in the work directory */

proc format;
    value gender 0='Male' 1='Female';
run;

proc print data=chol round;
	format gender gender.;
run;

/* Part 1. */

/* check collinearity */
proc reg data=chol plots=none;
	model hdl = gender age ht wt sbp dbp / vif ;
run;

/* employ the ALL SUBSETS METHOD to find a parsimonious model */
proc reg data=chol plots=none;
	model hdl = gender age ht wt sbp dbp / selection=cp ;
	ods output SubsetSelSummary = subset_out;
run;
data subset_out;
	set subset_out;
	Diff = abs(NumInModel - Cp);
run;
proc sort data=subset_out;
	by Diff NumInModel Cp RSquare;
run;
proc print data=subset_out (obs=5);
	var Cp Diff VarsInModel RSquare;
	id NumInModel;
	title "Top Five Parsimonious Models";
run;
title;

/* the parsimonious model has all six explanatory variables */
proc reg data=chol plots=none;
	model hdl = gender age ht wt sbp dbp;
run;

/* Part 2. */

/* introduce interaction term age_gen for age and gender */
data chol2;
	set chol;
	age_gen=age*gender;
run;

/* regression model with interaction */
proc reg data=chol2 plots=none;
	model hdl = age gender age_gen;
run; 

/* restricted study of only males */
proc glm data=chol;
	where gender=0;
	model hdl = age;
	title "Linear Model for HDL by AGE (Males)";
run; 

/* restricted study of only females */
proc glm data=chol;
	where gender=1;
	model hdl = age;
	title "Linear Model for HDL by AGE (Females)";
run; 

/* Part 3. */

/* check the simple regression model for TG and BMI */
proc glm data=chol;
	model tg = bmi;
run; 

/* then include x2=gender */
proc glm data=chol;
	class gender;
	model tg = bmi gender / solution;
	title "TRIGLYCERIDE by BMI and GENDER";
	format gender gender.;
run; 

/* then include x2=age */
proc glm data=chol;
	model tg = bmi age / solution;
	title "TRIGLYCERIDE by BMI and AGE";
run; 