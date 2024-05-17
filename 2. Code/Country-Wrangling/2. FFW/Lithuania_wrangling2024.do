/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Lithuania - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the Lithuania pretest data received on 15/05/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Lithuania is divided into 10 counties for administrative reasons. This info is captured in variable Region.
	Lithuania is divided into two NUTS regions: LT01 and LT02, captured in variable location.
*/

g nuts_ltn = ""
replace nuts_ltn = "Sostinės regionas" if location == 1
replace nuts_ltn = "Vidurio ir vakarų Lietuvos regionas " if location == 2
decode location, g(nuts_id)

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

* Q60s added afterwards


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop location

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x in labels31 labels30 labels43 {
	label define `x' 98 "Don't know", modify
}
foreach x of varlist City Region ethni relig paff2 q60_G* {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
}
forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}

egen Strata = concat(nuts_id Region Urban), punct(" - ")

/* Note:
	1. Variables q60s are grouped.
*/

/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2_aux == 1

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni_aux == 1

drop *_aux


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

/* Note:
	1. No cross randomization between CP and IP module
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Note:
	1. 27 obs have more than 50 DK/NA values in the target variables.
	2. 35 individual(s) have a high difficulty score.
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
