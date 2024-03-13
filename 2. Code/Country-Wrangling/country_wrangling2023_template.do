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


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

/* Note:
	Face-to-Face polls will be missing the following variables (just uncomment):
	
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

drop gend_quota age2 quota_group ///
	q60_G1_1_99 q60_G1_2_99 q60_G1_3_99 q60_G2_1_99 q60_G2_2_99 q60_G2_3_99 q60_G3_1_99 q60_G3_2_99 q60_G3_3_99 ///
	consent_relig consent_ethni consent_disability consent_politics Income2_check 

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename Politics politics

/* Note:
	1. Always check that Gend is correctly coded (Male == 1)(Female == 2)(Nonbin == 3)(Not recog == 4)
	
	2. When applicable, remember to decode (convert variables to string) the following variables:
		- income_cur
		- income_time
		- q17
		- City
		- Region
		- Strata / PSU / SSU
		- ethni / relig / paff2 (only for the pretest)
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
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == [INCUMBENT POLITICAL PARTY]

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == [INCUMBENT POLITICAL PARTY]


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 


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
