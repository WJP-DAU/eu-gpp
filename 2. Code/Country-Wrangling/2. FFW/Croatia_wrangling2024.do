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

// Yes/No include the routing instructions, need to get rid of those
foreach x of varlist q6a q6b q6c q6d q6e q7* q20 q22 q24 q28* q33c q38b q38g q38h disability A5b B2 {
	recode `x' (1 = 1 "Yes") (2 = 2 "No") (98 = 98 "Don't know") (99 = 99 "No Answer"), g(var_aux)
	drop `x'
	rename var_aux `x'
}

// Remove routing instructions
foreach x of varlist q26 q30 {
	recode `x' (1 = 1 "Ongoing") (2 = 2 "Too early to say") (3 = 3 "Done with, but problem persists") (4 = 4 "Done with, problem fully resolved") (98 = 98 "Don't know") (99 = 99 "No answer"), g(x_aux)
	drop `x'
	rename x_aux `x'
	}

recode q27 (1 = 1 "Agreement between you and the other party") (2 = 2 "The other party independently doing what you wanted") (3 = 3 "You independently doing what the other party wanted") (4 = 4 "The problem sorting itself out") (5 = 5 "You moving away from the problem (e.g. moving homes, changing jobs)") (6 = 6 "You and/or all other parties giving up trying to resolve the problem") (7 = 7 "None of these") (98 = 98 "Don't know") (99 = 99 "No answer"), g(q27_aux)
	
drop q27
	
rename q27_aux q27
	

foreach x of varlist q29* {
	recode `x' (1 = 1 "Myself (or someone on my behalf)") (2 =2 "The other party") (3 = 3 "Someone else") (98 = 98 "Don't know") (99 = 99 "No answer"), g(q29_aux)
	drop `x'
	rename q29_aux `x'
}

recode q34 (1 = 1 "Very satisfied") (2 = 2 "Satisfied") (3 = 3 "Dissatisfied") (4 = 4 "Very dissatisfied") (98 = 98 "Don't know") (99 = 99 "No answer"), g(q34_aux)
	
drop q34
	
rename q34_aux q34
	
foreach x of varlist q44*G1 {
	recode `x' (1 = 1 "Very Confident") (2 = 2 "Fairly confident") (3 = 3 "Not very confident") (4 = 4 "Not at all confident") (98 = 99 "Don't know") (99 = 99 "No answer"), g(q44G1_aux)
	drop `x'
	rename q44G1_aux `x'
	}

foreach x of varlist q44*G2 {
	recode `x' (1 = 1 "Strongly Agree") (2 = 2 "Agree") (3 = 3 "Disagree") (4 = 4 "Strongly Disagree") (98 = 98 "Don't know") (99 = 99 "No answer"), g(q44G2_aux)
	drop `x'
	rename q44G2_aux `x'
	}

recode emp (1 = 1 "Worked") (2 = 2 "Had work, but did not work") (3 = 3 "Looked for work") (4 = 4 "Studied") (5 = 5 "Dedicated yourself to household tasks") (6 = 6 "Were retired") (7 = 7 "Were permanently incapable of working") (8 = 8 "Did not work") (99 = 99 "No answer"), g(emp_aux)
	
drop emp
	
rename emp_aux emp

recode work (1 = 1 "Government worker") (2 = 2 "Private sector worker") (3 = 3 "Independent professional") (4 = 4 "Self-employed worker") (5 = 5 "Day laborer") (6 = 6 "Businessman or businesswomen") (7 =7 "Entrepreneur or business owner") (8 = 8 "Unpaid worker") (99 = 99 "No answer"), g(work_aux)
	
drop work
	
rename work_aux work

recode marital (1 = 1 "Single") (2 = 2 "Domestic partnership/living as married") (3 = 3 "Married") (4 = 4 "Divorced") (5 = 5 "Widowed") (99 = 99 "No answer"), g(marital_aux)
	
drop marital
	
rename marital_aux marital

recode qpi3a (1 = 1 "Not at all") (2 = 2 "Little") (3 = 3 "Somewhat") (4 = 4 "Very much") (98 = 98 "Don't know") (99 = 99 "No answer"), g(qpi3a_aux)
	
drop qpi3a
	
rename qpi3a_aux qpi3a


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
