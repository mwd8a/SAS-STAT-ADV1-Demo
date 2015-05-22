Advanced SAS Demo 1: Multilinear Regression and ANCOVA
======================================================

## Overview

In this demonstration, we build a predictive linear regression model and test some variables for *effect modification* and *confounding*. The key SAS procedures used are PROC REG and PROC GLM. 

The data set CHOL is created by running the code in **chol_raw.sas**. The variables in this data set are given below
 
* **ID** for *Subject ID*
* **AGE** for *Age*
* **HT** for *Height*
* **WT** for *Weight*
* **SBP** for *Systolic Blood Pressure*
* **DBP** for *Diastoloic Blood Pressure*
* **HDL** for *High Density Lipids*
* **GENDER** for *'male' or 'female'*
* **TG** for *Triglycerides*
* **BMI** for *Body mass index*

The values for GENDER are then coded as 0='male' and 1='female'.

The file **SAS_Adv1.sas** contains the SAS code from the analysis. The SAS output can be viewed in the file **Results / SAS_Adv1.sas.pdf**. 

A detailed account of the analysis can be read in the file **SAS_Stat_Adv1.pdf**.

## Part 1

The "all possible subsets" method was used to build a predictive model with HDL as the outcome variable, and GENDER, AGE, HT, WT, SBP, and DBP as potential explanatory variables. A parsimonius model is then chosen. This is accomplished by running PROC REG, outputing a data set SUBSETSELECT\_OUT and sorting this by a new variable DIFF; DIFF measures the difference between the numbers of variables (NumInVars) in the model and the Mallow's C_p. The top five models are analyzed further.

## Part 2

The association between HDL (X-variable) and AGE (X-variable) is investigated. In particular, we want to test whether or not GENDER modifies the association between HDL and AGE. This amounts to testing the interaction effect between AGE and GENDER. This is accomplished in SAS by running PROC REG with HDL as the response variable and AGE, GENDER, and the product of AGE and GENDER.

It turns out that there is a significant interaction, so we split-up the analysis by GENDER. That is, we investigate the association between HDL and AGE for males, then repeat for females. For these analyses, we use PROC GLM to include fit plots with 95% condidence limits and 95% prediction limits included.

## Part 3

The objective is to study the association between TG (Y-variable) and BMI (X-variable). We check whether GENDER or AGE was a cofounder. This is accomplished by running PROC GLM for various linear regression models 

* TG by BMI 
* TG by BMI and GENDER
* TG by BMI and AGE
 
and comparing the first model to each of the other two.