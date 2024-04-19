/*=================================================================================================================
Project:		EU Subnational 2024
Routine:		GPP Data Cleaning and Harmonization 2024 (master do file)
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
			// Special naming for the following companies: 
			//		- Bilendi: write "0_Bilendi" as country_name
			//		- IPSOS:   write "0_IPSOS" as country_name
global country_name "Slovakia"

*------ (b) What data stage is this?
			// Pretest: 		Please input "1. PTR"
			// Full Fieldwork:	Please input "2. FFW"
global dataStage "2. FFW"

*------ (c) Year
global year 2024

*------ (c) Original file name
global dataName "Slovakia_FFW_20240311.sav"

/*	IMPORTANT:
	 1. Please confirm with the GPP team that this is INDEED the latest data file submitted by the polling company.
	 2. Polling companies collecting data in multiple countries might send a consolidated dataset with all
	 countries together. For EVERY issue found. Evaluate if the issue is present across ALL countries or ONLY in
	 specific countries. You will have to check for this in the console directly.

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

*--- Defining paths to SharePoint & your local Git Repo copy:

*------ (a) Carlos Toruno:
if (inlist("`c(username)'", "ctoruno")) {
	global path2SP "/Users/ctoruno/OneDrive - World Justice Project/EU Subnational"
	global path2GH "/Users/ctoruno/OneDrive - World Justice Project/EU Subnational/EU-S Data"
}

*------ (b) Santiago Pardo:
if (inlist("`c(username)'", "santiagopardo")) {
	global path2SP "/Users/santiagopardo/OneDrive - World Justice Project/EU Subnational"
	global path2GH "/Users/santiagopardo/Documents/GitHub"
}

*------ (b) Natalia Rodriguez:
if (inlist("`c(username)'", "nrodriguez")) {
	global path2SP "C:\Users\nrodriguez\OneDrive - World Justice Project\Programmatic\EU Subnational"
	global path2GH "C:\Users\nrodriguez\OneDrive - World Justice Project\Natalia\GitHub"
}

*------ (c) Dalia Habiby:
if (inlist("`c(username)'", "Dhabiby")) {
	global path2SP "/Users/Dhabiby/World Justice Project/Research - EU Subnational"
	global path2GH "/Users/Dhabiby/Documents/GitHub"
}

*------ (d) Allison Bostrom:
if (inlist("`c(username)'", "abostrom")) {
	global path2SP "/Users/abostrom/World Justice Project/Research - EU Subnational"
	global path2GH "/Users/abostrom/OneDrive - World Justice Project/Documents/GitHub"
}

*--- Defining path to Data and DoFiles:
global path2meta "${path2SP}/EU-S Data/eu-gpp/0. Metadata"
global path2data "${path2SP}/EU-S Data/eu-gpp/1. Data"
global path2dos  "${path2SP}/EU-S Data/eu-gpp/2. Code"

*--- Defining path to DoFiles (for country wrangling):
global path2wr "${path2GH}/eu-gpp/2. Code"


/*=================================================================================================================
					Data Loading
=================================================================================================================*/

*--- Using the original name of the file to save it as DTA
global dtaFile = ustrregexrf("${dataName}", "\..+", ".dta")

*--- Loading paths to the data files submitted by the polling companies
do "${path2dos}/Routines/rawData_paths.do"

*--- Reading the data into STATA
if (inlist("`c(username)'", "nrodriguez")) {
	usespss "${RD_path}/${dataName}", clear
}
else {
	import spss using "${RD_path}/${dataName}", clear
}

*--- Saving the DTA file
save "${path2data}/${dataStage}/${country_name}/0. Raw Data/${dtaFile}", replace

/* Note:
	1. Please make sure that the character encodings are UTF-8 (STEP 1). See the step_1.do file.
*/

/* Note:
	For some polling companies such as Bilendi, we are splitting the raw data per country but this is just
	to keep the original data bases per country. For consistency. However, you will continue working with
	the consolidated dataset.
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
do "${path2wr}/Country-Wrangling/${dataStage}/${country_name}_wrangling${year}.do"

*--- Saving a testing dta file for automatically checking value labels using the EU-Copilot app:
save "${path2data}/${dataStage}/${country_name}/0. Raw Data/${country_name}_test.dta", replace

/* Note:
	Use the previous file to check for mislabeled values using the EU-Copilot and pray that it works :happy_corgi:
	If it doesn't work, you might have issues with the character encoding system used by the polling company and,
	sadly, you will have to use the log file to check for mislabeled values :sad_corgi:
*/

*--- Do all variables fall within the expected range?  (Step 2)
cls
do "${path2dos}/Routines/range_checks.do"

/* Note: 
	Search for RED ERROR messages in the console after running the range checks.
*/

*--- Adding Country General Information
if (inlist("${country_name}", "0_Bilendi", "0_IPSOS")){
	g country_name_ltn = country
}
else {
	g country_name_ltn = "${country_name}"
}

/* Note: 
	The previous exception is only for polling companies that submitted the data of multiple countries
	in a single data file.
*/

*--- Drop obvious vars
drop country year id

g year = ${year}
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
if (!inlist("${country_name}", "0_IPSOS")){
	decode income_quintile, gen(income_text)
}
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
					Harmonizing string variables
=================================================================================================================*/

*--- Dropping KNW_*_98 & KNW_*_99
foreach x in rol justice governance {
	replace KNW_`x'_1 = KNW_`x'_98 if KNW_`x'_1 == "" & KNW_`x'_98 != ""
	replace KNW_`x'_1 = KNW_`x'_99 if KNW_`x'_1 == "" & KNW_`x'_99 != ""
	drop KNW_`x'_98 KNW_`x'_99
}

*--- Recasting strings (so we don't have to force the merge)
recast str200 nuts_ltn income_text KNW_*  
recast str100 country_year_id relig ethni voteintention city region PSU SSU Strata
recast str50 country_name_ltn country_name_off income_cur method income_group
recast str10 country_code_nuts country_code_iso nuts_id income_time AJP_problem

/*=================================================================================================================
					Saving Clean Data
=================================================================================================================*/

*--- Split data into individual countries and saving the data
if (inlist("${country_name}", "0_Bilendi")){
	foreach x in Austria Belgium Denmark Germany Italy Netherlands {
		preserve
		keep if country_name_ltn == "`x'"
		save "${path2data}/${dataStage}/`x'/1. Clean Data/`x'_clean.dta", replace
		restore
	}
}
if (inlist("${country_name}", "0_IPSOS")){
	foreach x in Czechia Estonia Finland France Slovenia Spain Sweden {
		preserve
		keep if country_name_ltn == "`x'"
		save "${path2data}/${dataStage}/`x'/1. Clean Data/`x'_clean.dta", replace
		restore
	}
}
if (!inlist("${country_name}", "0_Bilendi", "0_IPSOS")) {
	save "${path2data}/${dataStage}/${country_name}/1. Clean Data/${country_name}_clean.dta", replace
}


/*=================================================================================================================
					Harmonization with the Global GPP dataset
=================================================================================================================*/

do "${path2dos}/Routines/harmonization.do"
save "${path2data}/${dataStage}/${country_name}/1. Clean Data/${country_name}_global.dta", replace

