/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (COUNTRY - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the COUNRTY_NAME pretest data received on DD/MM/YYYY.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/


gen nuts_id=""
replace nuts_id="HR02" if nuts2 == 2
replace nuts_id="HR03" if nuts2 == 3
replace nuts_id="HR05" if nuts2 == 5
replace nuts_id="HR06" if nuts2 == 6

gen nuts_ltn=""
replace nuts_ltn="Panonska Hrvatska" if nuts2 == 2
replace nuts_ltn="Jadranska Hrvatska" if nuts2 == 3
replace nuts_ltn="Grad Zagreb" if nuts2 == 5
replace nuts_ltn="Sjeverna Hrvatska" if nuts2 == 6



/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

	
	forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}
	
	drop Strata // empty but causing problems for str100 later
	g Strata = ""


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop income_HR nuts2 nuts3

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x of varlist income_cur income_time q17 relig ethni paff2 City Region {
				rename `x' `x'_aux
				decode `x'_aux, g(`x')
				drop `x'_aux
			}
			
/* Fix typo in DK response for ethni */
label define labels319 98 "Don't know", modify

// # of family members gives 5 as an option, should be included in 4 or more
replace A7 = 4 if A7 == 5

// Most obs are missing the income var (not DK/NA, actually missing - as if they never saw the question)

// Also some people reported their income in Kuna, while the most reported it in Euro (and there are way more obs for income_cur than income)

// All obs have a value for income_time, maybe just because there's only one value

// income var doesn't have ranges in quintiles (just 1st, 2nd, etc)

// Row 780 (id 1058) has q16_A1 = 97 with no label. Should this have been DK (98)?

// Same for row 1010 (id 61) of q16_A3, row 1200 (id 73) of q16_B1, row 155 (id 404) of q16_B4, row 1101 (id 1036) of q16_F2, row 512 (id 65) of q16_G2, row 158 (id 861) of q16_H1



/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "Hrvatska demokratska zajednica (HDZ)"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Croat"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

// Logic checks flagged work/wagreement, but it's all people who responded NA to work and didn't see wagreement - can just fill in NA for wagreement for those people
replace wagreement = 99 if (work == 99 & wagreement == .)

// 24 people responded NA to A1, coded as 99 - could replace with missing?
replace A1 = -9999 if A1 == 99

// Row 1396 (country_year_id Croatia_2024_1396) had AJP_problem = B3 even though they responded DK for B3 severity and 5 for F1 severity

// Row 228 had AJP_problem = E2 even though they had responded DK for E2 and 10 for A1, D5, E1, F1, F2, G3, H2 and 6 for C3

//Row 427 had AJP_problem = E3 even though they had responded DK for E3 and 10 for C3




/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

* WRITE HERE ANY COMMENTS REGARDING THE QUALITY CHECKS


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
