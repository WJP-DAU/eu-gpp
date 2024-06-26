/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (Bulgaria - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	March, 2024

Description:
Data wrangling cleaning and harmonization routine for the Bulgaria pretest data received on 15/03/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Please create the following two variables:
		- nuts_ltn: 	Official name of the subnational NUTS region according to the 2022 edition of the 
						Statistical regions in the European Union and partner countries document. Name is 
						registered using the Latin alphabet. For example, in Greece we have:
							- Nisia Aigaiou, Kriti
							- Voreia Ellada
		- nuts_id: 		ID code of the subnational NUTS region according to the 2022 edition of the Statistical 
						regions in the European Union and partner countries document. For example, in Greece 
						we have "EL3", "EL4", "EL5", and "EL6".
						
		Be careful with the REGION variable. According to the datamap, this is supposed to be the admin division
		of the country. Which is not necessarilly the same as the NUTS division. For example, in Greece, there
		are 13 admin regions, which are equivalent to the NUTS 2. However, nuts_ltn and nuts_id are at the
		NUTS 1 level according to the sampling plan. So, be careful. If you don't know, ask.
		TIP: Check the pretest report form to check the names and distributions of "nuts_ltn" and "nuts_id"
		Please check that the whole sample has values for income. Even if someone refuses to answer it or to take this question, it should be flagged in this variable. 
		Always make sure that the income quintiles are ordered from lowest to highest. If there are more than 5 quintiles, please group them.
		NOTE FOR CARLOS: THIS IS THE COMMAND YOU ALWAYS FORGET:
			numlabel, add
*/

recode Region (101 102 103 104 = 1 "BG3")(105 106 = 2 "BG4"), g(nuts_id_aux)
decode nuts_id_aux, g(nuts_id)
drop nuts_id_aux
g nuts_ltn = ""
replace nuts_ltn = "Severna i Yugoiztochna" if nuts_id == "BG3"
replace nuts_ltn = "Yugozapadna i Yuzhna tsentralna" if nuts_id == "BG4"

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/
forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}
/* Note:
	Online polls will be missing the following variables (just uncomment):
	
	forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}
	g City = ""
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
*/


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/


	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x of varlist City Region ethni relig paff2 Strata PSU SSU {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

replace relig="Other" if relig=="Orher"

/* Label 9 for q31 was incorrect - it had the text for choice 8 */
label define labels20 9 "You and/or all other parties giving up trying to resolve the problem", modify

/* Update income labels with ranges */
label define labels1 1 "<750 BGN/month" 2 "751 - 1000 BGN/month" 3 "1001 - 1300 BGN/month" 4 "1301 - 1700 BGN/month" 5 "1701+ BGN/month", modify

/* Replace values of Region with NUTS-3 (which is contained in SSU) */
drop Region
gen Region = SSU

/* Notes:
	1. Always check that Gend is correctly coded (Male == 1)(Female == 2)(Nonbin == 3)(Not recog == 4)
	
	2. When applicable, remember to decode (convert variables to string) the following variables:
		- income_cur
		- income_time
		- q17
		- City
		- Region
		- Strata / PSU / SSU
		- ethni / relig / paff2 -> REMEMBER TO DECODE!!!
		- rol open ended questions
		
		You can do this by running:
			br income_cur income_time q17 City Region Strata PSU SSU ethni relig paff2 q60_G*
			
		If the values of a variable are shown in blue, that means the variable is categorical. We need to 
		decode it by running:
			foreach x of varlist [BLUE VARIABLES ONLY] {
				rename `x' `x'_aux
				decode `x'_aux, g(`x')
				drop `x'_aux
			}
	
		Also check their values and labels:
		- No typos 
		- Answers are in english
		
		Please standardize the DK/NA values:
		- "Don't know"
		- "No Answer"
		
		You can check for the previous by running:
			foreach x of varlist income_cur income_time q17 City Region Strata PSU SSU ethni relig paff2 q60_G* {
				tab `x'
			}
		
	3. Please check that the DK/NA values for q33b, q38e, q38f, q38g_1, q38h_1, and Income2 are encoded as:
		- "Don't know" = -8888
		- "No Answer"  = -9999
		
		You can check for the previous by running:
			numlabel, add
			foreach x of varlist q33b q38e q38f q38g_1 q38h_1 Income2 {
				tab `x'
			}
		
	4. Check the values for q17, they should be equal to the problem code: A2, A3, B1, L2, etc. This is VERY 
	IMPORTANT for the A2J problem selection checks.
	
	5. Check that multiple choice questions (q14, q21, q36) are correctly encoded as binary (1 | 2)
	
	6. Make sure that the interview lenght is in minutes
	
	7. Check the dweight
	
	8. Sometimes, variables like the q16 set, come as numeric variables with labels. The value can be miscoded or
	out of range, while the label is correct. Be careful. The previous is very common to happen in A1 and A7 
	as well.
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "GERB-SDS"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Bulgarian"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* No issues found.


/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* DKNA:
- 18-24 is overrepresented in High Incidence (16% of DKNA but only 8% of sample)
- Edu: primary & HS are overrepresented in HI and bachelors, grad, & vocational are underrepresented there
	Sample: primary 18%, HS 18%, bachelors 15%, grad 17%, vocational 31%
	DKNA HI: primary 37%, HS 26%, bachelors 65, grad 9%, vocational 20%

*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
