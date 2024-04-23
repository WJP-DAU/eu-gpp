/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Cyprus - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the Cyprus pretest data received on 29/03/2024.

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

g nuts_ltn = "Kýpros"	// Cyprus is mapped at the NUTS 1 level and it has only one single NUTS 1 region
g nuts_id  = "CY0"


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

* None

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x in labels3 labels353 labels354 labels367 {
	label define `x' 98 "Don't know" 99 "No answer", modify	
}
foreach x of varlist income_cur income_time City Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}
tostring PSU SSU, replace
foreach x of varlist q60_G* {
	replace `x' = "Don't know" if `x' == "98"
	replace `x' = "No answer"  if `x' == "99"
}
drop Strata
g aux_1 = " - "
decode Urban, g(aux_2)
egen Strata = concat(Region aux_1 aux_2)
drop aux_*

/* Notes:
		- Q60 answers are not in english
		- No Survey weights submitted
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "DISI"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Greek-Cypriot"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

/* Note:
	The following issues couldn't be fixed by the analyst:
	- Respondents with ID == [231, 352] do not have any recorded answer in q18a even though a qualified problem
	was selected in q17. Doesn't seem a programatic issue given that 25 people got problem "A3" selected but only
	one of them got q18a skipped.
*/

*--- Routing issues in q15 to q16:
replace q15_C3 = 1 if id == "676"
replace q15_D2 = 1 if id == "456"
replace q15_E1 = 1 if id == "372"
replace q15_J4 = 1 if id == "107"
replace q15_K2 = 1 if id == "483"

*--- Issues with the problem selection
replace q15_F1 = 1 if id == "349"
replace q15_A1 = 2 if id == "979"
replace q15_G3 = 1 if id == "557"
replace q15_B4 = 1 if id == "674"

*--- Routing issues in BRB
replace q7d = . if q6d == 2

*--- Routing issues in DIS
replace q13a = 2 if id == "979"

*--- Routing issues in q18a
replace q18a = . if inlist(id, "107", "471", "557", "664", "705")

*--- Routing issues in q23
replace q23 = . if id == "396"

*--- Routing issues in q24
replace q25 = . if id == "349"
foreach x in a b c d e f g {
	replace q28`x' = . if id == "396"
	replace q29`x' = . if id == "396"
}

*--- Routing issues in q26
foreach x of varlist q27 q32a q32b q32c q33a {
	replace `x' = . if id == "349"
}

*--- Routing issues in q38a-q38d when skipping q38e-q38h_1
foreach x of varlist q38e q38f {
	replace `x' = . if inlist(id, "364", "498", "565")
}

*--- Routing issues in A5b
replace A5b = 1 if id == "78"

*--- Routing issues in B2
replace B2 = 1 if id == "749"

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Note:
	- 7 obs have more than 50 DK/NA values in the target variables.
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
