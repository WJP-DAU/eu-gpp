/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Luxembourg - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the Luxembourg pretest data received on 13/03/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Our sampling plan includes only a single NUTS 1 region. However, the country is divided into four different
	regions: Center, South, North, East.
	
	Variable CANTON contains the information that we require for variable CITY
*/

g nuts_ltn = "Luxembourg"
g nuts_id  = "LU00"

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
g City = ""
foreach x in PSU SSU Strata {
	g `x' = ""
}
g COLOR = .
forvalues j=1/3 {
	g B`j' = .
}
g qpi1 = .
foreach x in a b c d e f {
	g qpi2`x' = .
}
foreach x in a b c d {
	g qpi3`x' = .
}


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop City // Empty variable, information is contained in variable CANTON

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename YEAR Gend Age INCOME q28A q29A q28B q29B q28C q29C q28D q29D q28E q29E q28F q29F q28G q29G ///
	Relig Ethni Nation Fin Edu Emp Work Marital, lower
rename (CANTON D_WEIGHT REGION) (City dweight Region)


foreach x of varlist income_cur income_time q17 City Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

foreach x of varlist relig ethni paff2 q60* {
	replace `x' = "Don't know" if `x' == "Don t know"
	replace `x' = "No answer"  if `x' == "Prefer not to say"
}

replace income_cur = "Euros"

foreach x of varlist q33b q38e q38f q38g_1 q38h_1 {
	replace `x' = -8888 if `x' == 8888
	replace `x' = -9999 if `x' == 9999
}
replace Income2 = -8888 if Income2 == 98
replace Income2 = -9999 if Income2 == 99

replace q16_L2 = q16_L2-1
replace A7 = A7 - 1 if A7 < 98

/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "DP"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Luxembourger"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* None found

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 39 obs have more than 50 DK/NA values in the target variables.
	2. Variable q39b_G2 has more than 40% of valid observations as DK/NA.
	3. 7 individual(s) are flagged as speeders (1% of the sample).
	4. 3 individual(s) have a high incidence of straight-lining (<1% of the sample).

*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
