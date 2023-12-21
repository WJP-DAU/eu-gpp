/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (Ireland - Pretest)
Author(s):		Dalia Habiby 		(dhabiby@worldjusticeproject.org)
				Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	December, 2023

Description:
Data wrangling cleaning and harmonization routine for the Ireland pretest data received on 20/12/2023.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/* IMPORTANT NOTE: THERE ARE NO RECORDED VALUES FOR DK/NA IN ANY VARIABLE. */

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	The information on which NUTS region or administrative division every observation belongs to is missing. 
	The administrative divisions follow the 26 counties in the Republic of Ireland, and this information should be 
	recorded in the variable "Region". Even if all of the pretest data was collected in the same city or region, 
	we need a variable that allows us to connect each observation to a specific NUTS region.
*/

rename *, lower
g nuts_ltn = ""
g nuts_id  = .

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

*--- Missing Variables from the data
g country = ""
g year    = .
g income_cur = ""
g Interview_length = .
g City = ""
g Region = ""

*--- Missing Variables due to the Abridged Questionnaire 
foreach x in a b c d {
	g q9`x' = .
}

foreach x in a b c d e f g h{
	g q12`x' = .
	g q38`x' = .
}
g q38g_1 = .
g q38h_1 = .

foreach x in A1 A2 A3 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4 D5 D6 ///
 E1 E2 E3 F1 F2 G1 G2 G3 H1 H2 H3 I1 J1 J2 J3 J4 K1 K2 K3 L1 L2{
	g q15_`x' = .
	g q16_`x' = .
}

g q17 = ""

foreach x in 18a 18b 19 20 22 23 24 25 26 27 30 31 34 35{
	g q`x' = .
}

foreach x in 1 2 3 4 5 6 7 8 9 98 99{
	g q21_`x' = .
	g q36_`x' = .
}
drop q36_9

foreach x in a b c d e f g {
	g q28`x' = .
	g q29`x' = .
}

foreach x in a b c d{
	g q37`x' = .
}

g PSU = ""
g SSU = ""
g Strata = ""

forvalues j = 1/3{
	g B`j' = .
}

g qpi1 = .

foreach x in a b c d e f  {
	g qpi2`x' = .
	g qpi3`x' = .
}
drop qpi3e qpi3f

g COLOR = .
g dweight = .


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop *_time 
g income_time = ""	// They have an income_Time variable that captures the time it takes to answer the question. 
					// According to the datamap we require income_time
drop a53 a54 // Check this
drop income2_codes // This variable probably captures NAs
drop datacollection_finishtime optionab paff1slider_1_paff1_codes
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

recode income (1/4 = 1)(5/8 = 2)(9/12 = 3)(13/16 = 4)(17/20 = 5)(98 = 98)(99 = 99)
// No recorded DK/NA in income. Probably an issue. Income only has 46 observations (we are missing 4). Where are the DK/NA?
rename respondent_serial id
rename gender gend
rename q10 q11
rename q9 q10
foreach x in a b c d e f g h i j k {
	rename q11`x' q13`x'
}
foreach x of varlist q1201-q1209 {
	local a = subinstr("`x'", "120", "14_", 1)
	rename `x' `a'
}
foreach x of varlist q1210-q1212 {
	local a = subinstr("`x'", "12", "14_", 1)
	rename `x' `a'
}
rename q1213 q14_98
rename q1214 q14_99
local c = 1
foreach g in g1 g2 {
	
	foreach x of varlist q13`g'* {
		local a = subinstr("`x'", "13`g'_", "39", 1)
		rename `x' `a'
		rename `a' `a'_G`c'
	}
	local ++c
}

foreach g in g1 g2 {
	local c = 40
	foreach x of varlist q14`g'_*{
		local a = subinstr("`g'", "g", "G", 1)
		rename `x' q`c'_`a'
		local ++c
	}
}

foreach x of varlist q17g1* {
	local a = subinstr("`x'", "17g1", "43", 1)
	rename `x' `a'
	rename `a' `a'_G1
}

foreach x of varlist q17g2_*{
	local a = subinstr("`x'", "17g2_", "43", 1)
	rename `x' `a'
	rename `a' `a'_G2
}

local c = 1
foreach g in g1 g2 {
	
	foreach x of varlist q18`g'* {
		local a = subinstr("`x'", "18`g'_", "44", 1)
		rename `x' `a'
		rename `a' `a'_G`c'
	}
	local ++c
}

local c = 1
foreach g in g1 g2 {
	
	foreach x of varlist q19`g'* {
		local a = subinstr("`x'", "19`g'_", "45", 1)
		rename `x' `a'
		rename `a' `a'_G`c'
	}
	local ++c
}

local c = 1
foreach g in g1 g2 {
	forvalues j = 20/31 {
		local a = `j' + 26
		local b = subinstr("q`j'`g'", "`j'`g'", "`a'_", 1)
		rename q`j'`g' `b'
		rename `b' `b'G`c'
	}
	local ++c
}

local c = 58
forvalues j = 32/33{
	
	foreach x in a b c d e f g h i j {
		rename q`j'`x' q`c'`x'
	}
	local ++c
}

forvalues j = 1/3 {
	g q60_G`j'_1  = ""
	g q60_G`j'_2  = ""
	g q60_G`j'_3  = ""
	g q60_G`j'_98 = .
	g q60_G`j'_99 = .
	
	replace q60_G`j'_1 = q34_1st if q34q35q36word == `j'
	replace q60_G`j'_2 = q35_2nd if q34q35q36word == `j'
	replace q60_G`j'_3 = q36_3rd if q34q35q36word == `j'
	replace q60_G`j'_98 = q34_dk if q34q35q36word == `j'
	replace q60_G`j'_99 = q34_ref if q34q35q36word == `j'
}

drop q34q35q36word q34_1st q35_2nd q36_3rd q34_none q35_none q36_none q34_ref q34_dk 

foreach x of varlist a51 a52 {
	local a = subinstr("`x'", "a5", "A5_", 1)
	rename `x' `a'
}

rename paff1slider_1_paff1 paff1
rename a1 a2 a3 a4 a6 a7, upper
rename 	(income2 degurba a5b a5c) ///
		(Income2 Urban A5b A5c)

foreach x in a b c {
	g q32`x' = .
} // Abridged version does not have these variables
foreach x in a b c d{
	g q33`x' = .
} // Abridged version does not have these variables

foreach x of varlist q14_* A5_*{
	replace `x' = 2 if `x' == 0
}

recode Urban (1/2 = 1)(3 = 2)
replace A7 = A7-1 if A7<98

// We have missing values for the whole q6 set. Everyone should have answered these. 


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

* We have a missing value in q7e from someone who answered yes in q6e. Check the no-skip. It is probably dropping the DK/NA.

* We have people who answered 1 or 2 in emp but have missing values in work.

replace wagreement = . if work == 1 | work == .

* 20% of the sample did not answer either module in Civic Participation and in Institutional Performance. This is probably because of dropped DK/NA values.
/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

* Respondents with respondent_serial id of 113 and 156 have high incidence of straight lining

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
