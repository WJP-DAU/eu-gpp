/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Portugal - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	November, 2023

Description:
Data wrangling cleaning and harmonization routine for the Portugal pretest data received on 29/11/2023.

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

g nuts_ltn = "Continente"
g nuts_id  = "PT1"


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
} // The Copilot says g q60_g1_98 = . which is wrong: 1) Upper caps, 2) Not numeric


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

* No dropping needed

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

/* Note:
	City is numeric with no value labels. Therefore, we only have access to the city codes and we have no 
	access to the actual city names.
*/

foreach x of varlist q17 Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

foreach x of varlist City Strata PSU SSU {
	tostring `x', replace
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

*--- Routing issues
foreach x of varlist q13* {
	gen aux_`x' = (`x' == 1)
}
egen aux_T = rowtotal(aux_*)
foreach x of varlist q14_* {
	replace `x' = . if aux_T == 0
}
drop aux_*

*--- Randomization
/* Note:
	2. Unbalanced groups in q60: 22 answered Option B while only 13 answered Option A. 15 for Option C.
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 22 obs (44%) have more than 10 DK/NA values in the target variables.
	2. Unbalanced demographics
	3. q3k, q8c, q12c, q39a_G1, q39a_G2, q39b_G2, q45e_G1, q48_G1, q49_G1, q50_G1, q51_G1, q54_G1, q54_G2, 
	q44f_G2, q44h_G2, q44i_G2, and q44l_G2 have more than 25% of valid answers as DK/NA.
	4. I individual answered the survey in less than 20 min.
*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the EU-S DATA / GPP / 2. Code / Country-Wrangling folder
	in the SharePoint.
*