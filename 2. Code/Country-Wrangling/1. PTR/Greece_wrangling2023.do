/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Greece - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	November 2nd, 2023

Description:
Data wrangling cleaning and harmonization routine for the GREECE pretest data received on 02/Nov/2023.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	I have identified that the variable "region" contains the information on the NUTS 1 regions, which are the
	target regions according to the sampling plan. The variable "adm_region_con" contains the info for the
	admin regional units of Greece. Which are equal to the NUTS 2. This should the info in the "region" variable
	according to the datamap.
*/

// br region region_con adm_region_con prefecture_con municipality_con

rename *, lower
decode region, g(nuts_ltn)
recode region (1 = 1 "EL3")(2 = 2 "EL4")(3 = 3 "EL5")(4 = 4 "EL6"), g(nuts_id_aux)
decode nuts_id_aux, g(nuts_id)
drop nuts_id_aux

/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop intid lastconnectiondate lastconnectionstarttime connectiondurationinseconds ///
	connectiondurationinminutes totaldurationsec date_con month_con region_con adm_region_con ///
	prefecture_con municipality_con num_con split_1 split_2 split3 t_* part
	
/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

g year = 2023
forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
g PSU = ""
g SSU = ""
g dweight = ""
g Strata  = ""

/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/
rename respid id

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

foreach x of varlist a5m1 a5m2 {
	local a = subinstr("`x'", "m", "_", 1)
	rename `x' `a'
}

foreach x of varlist *_g1 *_g2 {
	local a = subinstr("`x'", "_g", "_G", 1)
	rename `x' `a'
}

foreach x of varlist *_g1_* *_g2_* *_g3_* {
	local a = subinstr("`x'", "_g", "_G", 1)
	rename `x' `a'
}

rename a1 a2 a3 a4 a5_1 a5_2 a6 a7 b1 b2 b3 color, upper
rename 	(income2 interview_length city region urban a5b a5c) ///
		(Income2 Interview_length City Region Urban A5b A5c)
		
lab define q17 ///
	1 "A1" 2 "A2" 3 "A3" 4 "B1" 5 "B2" 6 "B3" 7 "B4" 8 "C1" 9 "C2" 10 "C3" 11 "C4" 12 "D1" 13 "D2" ///
	14 "D3" 15 "D4" 16 "D5" 17 "D6" 18 "E1" 19 "E2" 20 "E3" 21 "F1" 22 "F2" 23 "G1" 24 "G2" 25 "G3" ///
	26 "H1" 27 "H2" 28 "H3" 29 "I1" 30 "J1" 31 "J2" 32 "J3" 33 "J4" 34 "K1" 35 "K2" 36 "K3" 37 "L1" ///
	38 "L2"
label values q17 q17
	// Q17 is supposed to be a string variable with the problem codes

foreach x of varlist income_cur income_time q17 City Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}


/*=================================================================================================================
					Special Cases
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
					Adjustments from the range, logic, randomization, and routing checks
=================================================================================================================*/

*--- Out of range
foreach x of varlist q44a_G1 q44f_G1 q44g_G1 q44i_G1 q44j_G1 {
	replace `x' = 98 if `x' == 5
}

*--- Routing issues
replace q7c = . if q6c == 2
replace q16_D3 = . if q15_D3 == 2
replace B3 = . if B2 == 2

*--- Multiple choice are incomplete
egen aux = rowtotal(q21_*)
foreach x of varlist q21_* {
	replace `x' = 2 if `x' == . & aux > 0
}
drop aux

*--- Randomization
/* Note:
	1. Unbalanced groups in the IP module: 29 answered Option A while only 21 answered Option B1
	2. Unbalanced groups in q60: 20 answered Option C while only 12 answered Option A. 18 for Option B
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 6 obs (12%) have more than 10 DK/NA values in the target variables.
	2. Unbalanced demographics
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the EU-S DATA / GPP / 2. Code / Country-Wrangling folder
	in the SharePoint.
*