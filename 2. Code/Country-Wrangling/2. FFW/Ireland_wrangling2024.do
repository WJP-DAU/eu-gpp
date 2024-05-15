/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Ireland - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the Ireland pretest data received on 10/05/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	The information on which NUTS region or administrative division every observation belongs to is missing. 
	The administrative divisions follow the 26 counties in the Republic of Ireland, and this information should be 
	recorded in the variable "Region". Even if all of the pretest data was collected in the same city or region, 
	we need a variable that allows us to connect each observation to a specific NUTS region.
*/

// rename *, lower
g nuts_ltn = ""
replace nuts_ltn = "Northern and Western" if nuts2 == 1
replace nuts_ltn = "Southern" if nuts2 == 2
replace nuts_ltn = "Eastern & Midland" if nuts2 == 3

g nuts_id  = ""
replace nuts_id = "IE04" if nuts2 == 1
replace nuts_id = "IE05" if nuts2 == 2
replace nuts_id = "IE06" if nuts2 == 3

drop nuts2 nuts3


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

*--- Missing variables (Online Polls)
forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
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

foreach x in a b c {
	g q32`x' = .
}
foreach x in a b c d{
	g q33`x' = .
}

*--- Missing variables:
g Region = ""
g dweight = .


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop degurba dublin *_Time qincome_time JobDescription

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename lau City
rename tot_time Interview_length
replace Interview_length = Interview_length/60

foreach x of varlist City relig ethni paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

foreach x of varlist ethni paff2 relig {
	replace `x' = "No answer" if `x' == "Prefer not to say"
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
rename (urban a5b a5c income2)(Urban A5b A5c Income2)

drop q14_99
rename q14_97 q14_99

/* Notes:	
		1. Variable Region is missing. They had a question about the county in the online survey.
		2. Survey weights are missing
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "Fine Gael"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "White Irish"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

replace wagreement = . if work == 8
replace wagreement = 99 if (work == 98 | work == 99) & wagreement == . 

/* Notes:	
		1. Routing issues between work-wagreement
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 1 obs have more than 50 DK/NA values in the target variables (<1% of sample)
	2. 101 individuals are flagged as speeders (7.8% sample)
		- 23 obs answered under 8 minutes (<5% of sample)
	3. 8 individual(s) have a high incidence of straight-lining (<1% of sample)
	4. 18 individuals were flagged as speeders & straight-liners (<5% of sample)
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
