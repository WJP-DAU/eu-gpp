/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (ROMANIA - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	May, 2024

Description:
Data wrangling cleaning and harmonization routine for the ROMANIA pretest data received on 28/05/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Romania is divided into 41 counties + the municipality of Bucharest (equal to a NUTS-3 division). 
	However, for the purposes of this study, using the 8 Development Regions (equal to a NUTS-2 division) is 
	sufficient.
*/

g nuts_id = ""
replace nuts_id = "RO1" if NUTS2 == 1
replace nuts_id = "RO2" if NUTS2 == 2
replace nuts_id = "RO3" if NUTS2 == 3
replace nuts_id = "RO4" if NUTS2 == 4

decode NUTS2, g(nuts_ltn)
drop NUTS2

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

** None

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x in q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 {
	rename `x'_EN `x'
}

rename (income1 income2 income_cur1) (income Income2 income_cur)
foreach x of varlist income_cur income_time q17  City Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}
drop Strata
egen Strata = concat(PSU Urban City), p(" - ")

g hours   = hh(Interview_length)
g minutes = mm(Interview_length)
g seconds = ss(Interview_length)
g double Interview_length_aux = (hours*60) + minutes + (seconds/60)
drop Interview_length hours minutes seconds
rename Interview_length_aux Interview_length

foreach x of varlist q16_* {
	replace `x' = `x'-1 if inrange(`x', 1,11)  
}

/* Note:
	1. No information regarding the income quintiles.
	2. q60 answers seem to be processed and grouped, we want the raw translated answers.
*/

/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "PNL (Partidul National Liberal)"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Romanian"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

/* Note:
	1. Respondents in rows 1201 and 1965 have "H2" as an answer in q17. However, they confirmed not having 
	experienced this problem. Looking at the pattern of answers, it seems that the most likely answer could have
	been C3 and H1.
*/

replace q17 = "C3" in 1201
replace q17 = "H1" in 1965

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Note:
	1. 5 obs have more than 50 DK/NA values in the target variables (<1% of total sample).
	2. 52 individual(s) have a high difficulty score (<5% of total sample).
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
