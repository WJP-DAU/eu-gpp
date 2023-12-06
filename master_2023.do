/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (master do file)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	June, 2023

Description:
Master dofile for the cleaning an wrangling of individual country-year datasets within the EU-S framework.

=================================================================================================================*/

clear
cls

/*=================================================================================================================
					PARAMETERS !!!PLEASE FILL EVERYTIME YOU RUN THIS MASTER DO FILE!!!
=================================================================================================================*/

*--- Parameters:

*------ (a) For which country are we going to run this do-file?
global country_name "Malta"

*------ (b) What data stage is this?
			// Pretest: 		Please input "1. PTR"
			// Full Fieldwork:	Please input "2. FFW"
global dataStage "1. PTR"

*------ (c) Year
global year 2023

*------ (c) Original file name
global dataName "Portugal_PRT_20231128.sav"	

/*	IMPORTANT:
	 Please confirm with the GPP team that this is INDEED the latest data file submitted by the polling company.

	Notes:
	 Please make sure the following tasks from the EU-GPP cleaning and validation protocol have already 
	 been performed:
		* File conversion (Step 1)
		* UTF-8 encoding check (Step 1)
*/ 

/*=================================================================================================================
					Pre-settings
=================================================================================================================*/

*--- Stata Version
version 15

*--- Required packages:
* NONE

*--- Defining paths to SharePoint:

*------ (a) Carlos Toruno:
if (inlist("`c(username)'", "ctoruno")) {
	global path2SP "/Users/ctoruno/OneDrive - World Justice Project/EU Subnational"
}

*------ (b) Santiago Pardo:
else if (inlist("`c(username)'", "santiagopardo")) {
	global path2SP "/Users/santiagopardo/OneDrive - World Justice Project/EU Subnational"
}

*------ (b) Natalia Rodriguez:
else if (inlist("`c(username)'", "nrodriguez")) {
	global path2SP "C:\Users\nrodriguez\OneDrive - World Justice Project\Programmatic\EU Subnational"
}

*------ (c) Dalia Habiby:
else if (inlist("`c(username)'", "Dhabiby")) {
	global path2SP "Users/Dhabiby/World Justice Project/Research - EU Subnational"
}

*------ (d) Artha Pillai:
else if (inlist("`c(username)'", "apillai")) {
	global path2SP "/Users/apillai/OneDrive - World Justice Project/EU Subnational"
}

*------ (e) Any other user: PLEASE INPUT YOUR PERSONAL PATH TO THE SHAREPOINT DIRECTORY:
else {
	global path2SP "INSERT_PATH_TO_EU_SUBNATIONAL_SHARE_POINT_HERE"
}

*--- Defining path to Data and DoFiles:
global path2meta "${path2SP}/EU-S Data/eu-gpp/0. Metadata"
global path2data "${path2SP}/EU-S Data/eu-gpp/1. Data"
global path2dos  "${path2SP}/EU-S Data/eu-gpp/2. Code"

/*=================================================================================================================
					Data Loading
=================================================================================================================*/

*--- Using the original name of the file to save it as DTA
global dtaFile = ustrregexrf("${dataName}", "\..+", ".dta")

*--- Loading paths to the data files submitted by the polling companies
do "${path2dos}/Routines/rawData_paths.do"

*--- Reading the data into STATA and saving the original raw dataset
if (inlist("`c(username)'", "nrodriguez")) {
	usespss "${RD_path}/${dataName}", clear
}
else {
	import spss using "${RD_path}/${dataName}", clear
}

save "${path2data}/${dataStage}/${country_name}/0. Raw Data/${dtaFile}", replace

/* Note:
	Please make sure that the character encodings are UTF-8 (STEP 1). See the step_1.do file.
*/

*--- Creating CODEBOOK log file:
log using "${path2data}/${dataStage}/${country_name}/0. Raw Data/${country_name}_${year}_Original.log", ///
	replace text
codebook
log close

/*=================================================================================================================
					Step 3: Country Specific Cleaning
=================================================================================================================*/

*--- Cleaning routine
/* Note: 
	Before running the cleaning routine, please use the EU-Copilot to assess unmapped/missing 
	variables (Step 2)
*/
do "${path2dos}/Country-Wrangling/${dataStage}/${country_name}_wrangling${year}.do"

*--- Do all variables fall within the expected range?  (Step 2)
cls
do "${path2dos}/Routines/range_checks.do"

/* Note: 
	Search for RED ERROR messages in the console after running the range checks.
*/

*--- Drop obvious vars
drop country year id

*--- Adding Country General Information
g country_name_ltn = "${country_name}"
g year = $year
g id = _n
merge m:1 country_name_ltn using "${path2meta}/general_info.dta", nogen keep(match) ///
	keepusing(country_name_off country_name_lt country_code_nuts country_code_iso method income_group)

/* Note: 
	Always double check that all obs should match
*/

*--- Unique identifier for merged dataset
egen country_year_id = concat(country_name_ltn year id), punct("_")

*--- Variable renaming
do "${path2dos}/Routines/variable_renaming.do"
/* Note: 
	The variable names changed. But now, the labels are the variable names in the paper questionnaire.
	This is done temporarily to help you write the pretest notes.
*/

*--- Adding transformed variables
decode income_quintile, gen(income_text)
foreach x in protest consultation cso {
	g CP_`x' = CPA_`x'
	replace CP_`x' = CPB_`x' if CP_`x' == .
}
foreach x in gendereq consrights laborcond envprotect euvalues headgovteval localgovteval accountability {
	g CTZ_`x' = CTZ_`x'_A
	replace CTZ_`x' = CTZ_`x'_B if CTZ_`x' == .
}

*--- Ordering dataset
do "${path2dos}/Routines/ordering.do"
/* Note: 
	After ordering, STRATA should be the last variable in the dataset. Double check this please.
*/

*--- Is the unique ID unique? 
isid country_year_id
/* Note: 
	If no error message is displayed, then everything's fine.
*/

/*=================================================================================================================
					Step 4/5: Logic, Randomization and Routing Checks
=================================================================================================================*/

cls
do "${path2dos}/Routines/logic_checks.do"

/* Note:
	Search for RED ERROR messages in the console after running the logic/routing/randomization checks.
	If you need to fix an issue flagged by the logic, randomization, or routing checks, please add that specific
	fix into the country wrangling dofile and run this master again.
*/

/*=================================================================================================================
					Step 7: Quality Checks
=================================================================================================================*/

cls
do "${path2dos}/Routines/quality_checks.do"

/* Note:
	Search for RED ERROR messages in the console after running the quality checks.
	Pay attention to the tabs dissaggregating the DKNA by sociodemographic (NO RED MESSAGE HERE, so pay attention)
*/


/*=================================================================================================================
					Step 6: Labelling
=================================================================================================================*/

*--- Drop ALL labels added by the company:
foreach x of varlist * {
   label var `x' ""
}
label drop _all

*--- Applying labels
do "${path2dos}/Routines/var_labels.do"
do "${path2dos}/Routines/val_labels.do"

/* Note:
	STATA has a maximum of 80 characters for variable labels. Therefore, variables have a short description
	as variable labels. However, you can find the full question phrasing as a variable note. 
	For example:
	
	note CTZ_localgovteval_B
*/


/*=================================================================================================================
					Saving Clean Data
=================================================================================================================*/

save "${path2data}/${dataStage}/${country_name}/1. Clean Data/${country_name}_clean.dta", replace


/*=================================================================================================================
					Harmonization with the Global GPP dataset
=================================================================================================================*/

do "${path2dos}/Routines/harmonization.do"
save "${path2data}/${dataStage}/${country_name}/1. Clean Data/${country_name}_global.dta", replace

