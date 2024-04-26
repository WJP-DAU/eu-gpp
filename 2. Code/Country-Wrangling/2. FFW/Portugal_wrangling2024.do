/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Portugal - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	April, 2024

Description:
Data wrangling cleaning and harmonization routine for the Portugal fieldwork data received on 24/04/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Portugal is divided into 2 autonomous regions (Azores and Madeira), and the Continental Portugal, which is 
	divided into 2 metropolitan areas, and 21 intermunicipal communities.
*/

recode Region (1/5 = 1 "Continente")(6 = 2 "Região Autónoma dos Açores")(7 = 3 "Região Autónoma da Madeira"), ///
	g(nuts_ltn)
g nuts_id = nuts_ltn
label define nuts_id 1 "PT1" 2 "PT2" 3 "PT3"
label values nuts_id nuts_id

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

*None

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

replace A7 = A7-1 if A7 < 98

foreach x of varlist nuts_id nuts_ltn City Region PSU ethni relig paff2 q17 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

foreach x of varlist Strata SSU {
	tostring `x', replace
}

/* Notes:
	1. q60 answers are not in English.
	2. Data has no survey weights.
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "Partido Social Democrata"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Português"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

/* Notes:
	1. There are 264 respondents that do not have any reported answer for the CP module. Same number of respondents
	reported answers for both options of the same module.
	2. Data has no survey weights.
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 73 obs have more than 50 DK/NA values in the target variables (<5%)
	2. 49 individual(s) have a high difficulty score (<5%)
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
