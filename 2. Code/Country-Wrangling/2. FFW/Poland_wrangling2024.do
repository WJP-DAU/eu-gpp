/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Poland - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the Poland pretest data received on 28/05/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Poland is divided into 16 provinces (voivodeships) which are roughly equal to a NUTS-2 division. There are 17
	NUTS-2 regions. The difference relies in the Masovia Province being divided between the Masovia region and the
	capital region. Therefore, with information on the NUTS-2 we can derive the REGION variable.
*/

g nuts_ltn = ""
replace nuts_ltn = "Makroregion północny" if Region == 1
replace nuts_ltn = "Makroregion północno-zachodni" if Region == 2
replace nuts_ltn = "Makroregion południowo-zachodni" if Region == 3
replace nuts_ltn = "Makroregion południowy" if Region == 4
replace nuts_ltn = "Makroregion centralny" if Region == 5
replace nuts_ltn = "Makroregion województwo mazowieckie" if Region == 6
replace nuts_ltn = "Makroregion wschodni" if Region == 7

g nuts_id  = ""
replace nuts_id = "PL6" if Region == 1
replace nuts_id = "PL4" if Region == 2
replace nuts_id = "PL5" if Region == 3
replace nuts_id = "PL2" if Region == 4
replace nuts_id = "PL7" if Region == 5
replace nuts_id = "PL9" if Region == 6
replace nuts_id = "PL8" if Region == 7


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
g SSU = ""
egen Strata = concat(nuts_ltn Urban), p(" - ")  


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop age_x Income__99 q38f2 G1_LOS q60_G*_kod relig_13_other paff2_other
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename Gend qpI*, lower
destring Income2, replace dpcomma
recode Urban (1 = 2)(2/3 = 1)

foreach x in labels118 labels119 labels131 {
	label define `x' 98 "Don't know", modify
	label define `x' 99 "No answer", modify
}
label define labels119 ///
	1 "Polish" ///
	2 "Belarussian" ///
	3 "Czech" ///
	4 "Karaite" ///
	5 "Kashubian" ///
	6 "Lithuanian" ///
	7 "Lemko" ///
	9 "Armenian" ///
	13 "Silesian" ///
	14 "Tatar" ///
	15 "Ukrainian" ///
	17 "Jewish", modify

g hours   = hh(Interview_length)
g minutes = mm(Interview_length)
g seconds = ss(Interview_length)
g double Interview_length_aux = (hours*60) + minutes + (seconds/60)
drop Interview_length hours minutes seconds
rename Interview_length_aux Interview_length

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == 1

drop Region
rename NUTS2 Region
foreach x of varlist Region relig ethni paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

foreach x of varlist q14* q21* q36* {
	replace `x' = 2 if `x' == 0
}

/* Notes:
	1. Variables q33b and q38f have 99s. Please confirm with the polling companies if those are encoded as DK/NA.
	2. We are missing the labels for the variable Ethni.
	3. Variable REGION has only information on the NUTS-1 division. Could you also provide information on the
	NUTS-2 division?
	4. We only have information about income on only 40% of the sample.
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
** DONE ABOVE

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Polish"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 


/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 45 obs have more than 50 DK/NA values in the target variables (<1% of sample).
	2. 176 individual(s) have a high difficulty score (<5% of sample).
*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
