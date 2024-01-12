/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Luxembourg - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	January, 2024

Description:
Data wrangling cleaning and harmonization routine for the Luxembourg pretest data received on 11/01/2024.

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
*/

g nuts_ltn = "Luxembourg"
g nuts_id  = "LU00"

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/
g q36_8 = .
forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
g City = ""
drop q17
foreach x in PSU SSU Strata q17 {
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

// No added variables identified

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename paff1_1 paff1
rename REGION Region
rename 	(YEAR Gend Age INCOME q28* q29* Relig Ethni Nation Fin Edu Emp Work Marital), lower
foreach x of varlist income_cur income_time Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = . 
	// Alway gen an empty vector for the PRETEST!!!

*--- Ethnicity groups:
g ethni_groups = . 
	// Alway gen an empty vector for the PRETEST!!!


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

*--- Out of range
foreach x of varlis q16_* A7 {
	replace `x' = `x' - 1 if `x' < 98
}

*--- Logic/encoding issues
replace q33b = -8888 if q33b == 999
foreach x of varlist q38e q38f q38g_1 q38h_1 Income2 {
	replace `x' = -8888 if `x' == 98
	replace `x' = -9999 if `x' == 99
}

*--- Routing issues
replace q23 = . if q20 == 1

*--- Randomization
/* Note:
	1. Unbalanced groups in q60: 36 answered Option B while only 18 answered Option C. 30 for Option A.
	2. q3h, q12c*, q12d, q12g*, q12h, q37d, q39c_G1, q39a_G2, q39b_G2, q39d_G2, q39f_G2, q39g_G2, q39h_G2, q43f_G1,
	q43h_G1, q43i_G1*, q43d_G2*, q43e_G2*, q43f_G2, q45b_G2, q57_G2, q48_G1*, q49_G1*, q51_G1, q52_G1*, q53_G1,
	q54_G1, q55_G1*, q56_G1*, q49_G2*, q50_G2*, q51_G2*, q53_G2*, q54_G2*, q55_G2, q44c_G2, q44d_G2*, q44e_G2*, 
	q44f_G2*, q44g_G2, q44h_G2*, q44i_G2*, q44j_G2*, q44k_G2, q44l_G2*,  have more than 25% of valid answers as DK/NA.
	3. 20 individual answered the survey in less than 20 min. One even under 10 minutes.
	4. 8 individuals were flagged with having a high incidence of straight-lining
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 25 obs (30%) have more than 30 DK/NA values in the target variables.
	2. Unbalanced demographics
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
