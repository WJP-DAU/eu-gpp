/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Bulgaria - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:
Data wrangling cleaning and harmonization routine for the BULGARIA pretest data received on 12/11/2023.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:

	Bulgaria is divided into 2 NUTS-1 regions: BG3 & BG4, this info is not in the data. However, the variable
	Region captures the admin division of Bulgaria into 28 provinces/districts, which is equivalent to the
	NUTS-3 level.
	
	For example, Region "Blagoevgrad" is BG413, which should be classified as BG4 in the nuts_id.
*/

recode Region (3 6 11 18  20 21 27 = 1 "BG3")(3 16 23 24 = 2 "BG4"), g(nuts_id_aux)
decode nuts_id_aux, g(nuts_id)
drop nuts_id_aux
g nuts_ltn = ""
replace nuts_ltn = "Severna i Yugoiztochna" if nuts_id == "BG3"
replace nuts_ltn = "Yugozapadna i Yuzhna tsentralna" if nuts_id == "BG4"

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

* No dropping needed
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename income2 Income2
foreach x of varlist City Region Strata PSU ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
* recode paff2 (x=y)		// Recode following the Party Coding Units from the V-Party Dataset
* g incpp = (paff2 == xx) if paff2 != .
g incpp = . 
	// Alway gen an empty vector for the pretest

*--- Ethnicity groups:
* recode ethni (x=y)	 	// Recode following the European Standard Classification of Cultural and Ethnic Groups
* recode ethni (x=1)(y=2)(z=3)(98/99 = .), g(ethni_groups)
g ethni_groups = . 
	// Alway gen an empty vector for the pretest

/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

*--- Randomization
/* Note:
	1. Unbalanced groups in q60: 22 answered Option C while only 12 answered Option A. 16 for Option B.
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 12 obs (24%) have more than 10 DK/NA values in the target variables.
	2. Unbalanced demographics
	3. q12a, q12b, and q12h have more than 15% of valid answers as DK/NA.
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
