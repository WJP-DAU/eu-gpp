/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Slovakia - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	January, 2024

Description:
Data wrangling cleaning and harmonization routine for the Slovakia pretest data received on 16/01/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Slovakia is divided into 8 kraje (usually translated as "region"), each of which is named after its 
	principal city. These "kraje" are equal to the NUTS 03 division of the country. We are missing this info.
*/

rename *, lower
decode region, g(nuts_ltn)
g nuts_id = ""
replace nuts_id = "SK01" if region == 1
replace nuts_id = "SK02" if region == 2
replace nuts_id = "SK03" if region == 3
replace nuts_id = "SK04" if region == 4


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
foreach x in PSU SSU Strata {
	g `x' = ""
}
g COLOR = .
g dweight = .
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

drop a5_98 a5_99 
	
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

rename a1 a2 a3 a4 a5_1 a5_2 a6 a7, upper
rename 	(income2 interview_length city region urban a5b a5c) ///
		(Income2 Interview_length City Region Urban A5b A5c)
		
foreach x of varlist Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

replace Interview_length = Interview_length/60
		
/* Note:
	- Please translate the value labels used for relig and ethni to english
	- Multiple choice questions (q14, q21, q36) are missing the NO values. Only YES values are mapped
	- Interview_length appears to be in seconds... not sure, please confirm
*/

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
foreach x of varlist q16_* {
	replace `x' = `x'-1 if `x' < 98
}

*--- Routing issues
foreach x of varlist q13* {
		recode `x' (2 98 99 = 0), g(aux_`x')
	}
egen aux_T = rowtotal(aux_*)
foreach x of varlist q14_* {
	replace `x' = 0 if aux_T > 0
}
drop aux_*

foreach x of varlist q21_* {
	replace `x' = 0 if q20 == 1 & `x' == .
}

*--- A2J problem selection
/* Note:
	1. Individual with id == 4 had "E3" as the selected problem in q17 when the severity for this problem was 
	zero and another problem (H2) had the maximum severity (10).
*/

*--- Randomization
/* Note:
	1. Unbalanced groups in the CP module: 40 answered Option A while 56 answered Option B.
	2. Unbalanced groups in q60: 39 answered Option B while only 27 answered Option C. 30 for Option A
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 15 obs (16%) have more than 30 DK/NA values in the target variables.
	2. Unbalanced demographics.
	3. q12c, q39a_G1, q39a_G2, q39b_G2, q43d_G1, q43f_G1, q43g_G1, q43h_G1, and q44l_G2 have more than 25% of 
	valid answers as DK/NA.
	4. Five individuals answered the survey in less than 15 min.
	5. 14 individuals have a high incidence of straight-lining across question sets.
*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
