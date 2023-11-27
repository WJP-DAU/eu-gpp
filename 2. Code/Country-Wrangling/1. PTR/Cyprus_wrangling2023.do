/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Cyprus - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	November, 2023

Description:
Data wrangling cleaning and harmonization routine for the Cyprus pretest data received on 27/11/2023.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Cyprus is divided into six districts: Famagusta, Kyrenia, Larnaca, Limassol, Nicossia and Paphos. This info is
	stored in city and region (the district capitals have the same name). Therefore, no further modification
	needed.
*/

rename *, lower
g nuts_ltn = "Kýpros"	// Cyprus is mapped at the NUTS 1 level and it has only one single NUTS 1 region
g nuts_id  = "CY0"

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

foreach x of varlist q15* {
	local a = subinstr("`x'", "q15", "q15_", 1)
	local b = ustrregexrf("`a'", ".+_", "")
	local c = "q15_" + upper("`b'")
	rename `x' `c'
}

foreach x of varlist q16* {
	local a = subinstr("`x'", "q16", "q16_", 1)
	local b = ustrregexrf("`a'", ".+_", "")
	local c = "q16_" + upper("`b'")
	rename `x' `c'
}

foreach x of varlist *_g1 *_g2 {
	local a = subinstr("`x'", "_g", "_G", 1)
	rename `x' `a'
}

foreach x of varlist *_g1_* *_g2_* *_g3_* {
	local a = subinstr("`x'", "_g", "_G", 1)
	rename `x' `a'
}

rename a1 a2 a3 a4 a5_1 a5_2 a6 a7 b1 b2 b3 color psu ssu, upper
rename 	(income2 interview_length city region urban a5b a5c strata) ///
		(Income2 Interview_length City Region Urban A5b A5c Strata)

foreach x of varlist income_cur income_time City Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

destring Interview_length, replace


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

*--- Out of range
foreach x of varlist q14_* q21_* q36_* {
	replace `x' = 2 if `x' == 0
}
foreach x of varlist q32* {
	replace `x' = 99 if `x' == 4		// Probably the same with DK=3 instead of DK=98
}
replace marital = 99 if marital == 100

*--- Logic/encoding issues
replace Income2 = -8888 if Income2 == 98
replace Income2 = -9999 if Income2 == 99

*--- Routing issues
replace q7b = . if q6b == 2

foreach x of varlist q13* {
	gen aux_`x' = (`x' == 1)
}
egen aux_T = rowtotal(aux_*)
foreach x of varlist q14_* {
	replace `x' = . if aux_T == 0
}
drop aux_*

foreach x of varlist q21_* {
	replace `x' = . if  q20 > 1 &  q20 != .
}

*--- Randomization
/* Note:
	1. Unbalanced groups in the IP module: 29 answered Option A while only 21 answered Option B1.
	2. Unbalanced groups in q60: 22 answered Option B while only 12 answered Option A. 16 for Option C.
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 11 obs (22%) have more than 10 DK/NA values in the target variables.
	2. Unbalanced demographics
	3. q33a, q39a_G1, q39i_G1, q43c_G1, q43d_G1, q43e_G2, q43h_G2, q54_G1, q55_G2 have more than 15% of 
	valid answers as DK/NA. q39a_G1 has more than 25 percent of DK/NA.
*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the EU-S DATA / GPP / 2. Code / Country-Wrangling folder
	in the SharePoint.
*