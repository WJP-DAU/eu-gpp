/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (COUNTRY - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	January, 2024

Description:
Data wrangling cleaning and harmonization routine for the Hungary pretest data received on 16/01/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	I have identified that the variable "region" contains the information on the NUTS 1 regions, which are the
	target regions according to the sampling plan. There is no variable that contains the admin regional units. 
*/

* We should ask for the information at NUTS 2 level that is refered to 7 regions across the country

rename *, lower
decode region, g(nuts_ltn)
recode region (1 = 1 "HU1")(2 = 2 "HUI2")(3 = 3 "HUI3"), g(nuts_id_aux)
decode nuts_id_aux, g(nuts_id)
drop nuts_id_aux

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

* A5_98 and A5_99 must be in A5_1 and A5_2 as individual categories. It shouldn't be a variable

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
		
lab define q17 ///
	1 "A1" 2 "A2" 3 "A3" 4 "B1" 5 "B2" 6 "B3" 7 "B4" 8 "C1" 9 "C2" 10 "C3" 11 "C4" 12 "D1" 13 "D2" ///
	14 "D3" 15 "D4" 16 "D5" 17 "D6" 18 "E1" 19 "E2" 20 "E3" 21 "F1" 22 "F2" 23 "G1" 24 "G2" 25 "G3" ///
	26 "H1" 27 "H2" 28 "H3" 29 "I1" 30 "J1" 31 "J2" 32 "J3" 33 "J4" 34 "K1" 35 "K2" 36 "K3" 37 "L1" ///
	38 "L2"

* These variables should be strings
foreach x of varlist Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
} 

* etnhi, religion and paff2 are not in English.
* Interview_length measure is in seconds, transform to minutes



/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
* recode paff2 (x=y)		// Recode following the Party Coding Units from the V-Party Dataset
* g incpp = (paff2 == xx) if paff2 != .
g incpp = . 
	// Alway gen an empty vector for the PRETEST!!!

*--- Ethnicity groups:
* recode ethni (x=y)	 	// Recode following the European Standard Classification of Cultural and Ethnic Groups
* recode ethni (x=1)(y=2)(z=3)(98/99 = .), g(ethni_groups)
g ethni_groups = . 
	// Alway gen an empty vector for the PRETEST!!!


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

*A2J problems severity are out of range, they are counting from 1 not from 0. This affects variable q17 because the problem selected with severity as 4 should not be included in the routing.

*--- Out of range
foreach x of varlis q16_* {
	replace `x' = `x' - 1 if `x' < 98
}

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

* Please check randomization in the Rule of Law questions (q60) 
* Please check the proportion of Men and Women in the sample
* There 15 observations with more than 30 DK/NA values in the target variables
* There are 15 observations which have a high incidence of straight-lining

/*===========================================================================
======================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
