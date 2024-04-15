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


decode NUTS1, g(nuts_ltn)

gen nuts_id=""
replace nuts_id="HU1" if NUTS1==1
replace nuts_id="HU2" if NUTS1==2
replace nuts_id="HU3" if NUTS1==3

drop NUTS1

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

/* Note:
	Online polls will be missing the following variables (just uncomment): */
	
	forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}
	
	foreach x in Strata {
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



/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop INCOM3 INCOM4 INCOM5 INCOM0 INCOM1 INCOM2 Q170 Q171 Q172 CITY0 CITY1 CITY2 agegroup ///
Q60_GO Q60_GP Q60_GQ Q60_GL Q60_GM Q60_GN Q60_GI Q60_GJ Q60_GK Q60_GF Q60_GG Q60_GH Q60_GC Q60_GD Q60_GE Q60_G9 Q60_GA Q60_GB Q60_G6 Q60_G7 Q60_G8 Q60_G3 Q60_G4 Q60_G5 Q60_G0 Q60_G1 Q60_G2 


	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename weight_national dweight

br income_cur income_time q17 City Region Strata PSU SSU ethni relig paff2 q60_G*

foreach x of varlist Region ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}


cls
foreach x of varlist income_cur income_time q17 City Region Strata PSU SSU ethni relig paff2 {
	tab `x'
}

foreach x of varlist q60_G* {
	tab `x'
}

cls
numlabel, add
foreach x of varlist q33b q38e q38f q38g_1 q38h_1 Income2 {
	tab `x'
}

tostring PSU SSU, replace

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
replace incpp = 1 if paff2 == "Alliance of Young Democrats"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Hungarian"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 

replace q7e=. if q7e!=. & q6e==2


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
