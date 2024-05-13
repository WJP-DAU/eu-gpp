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


gen nuts_ltn = "Malta"
gen nuts_id = "MT00"

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

/* Note:
	Online polls will be missing the following variables:
*/	

forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}
	
g q36_8 = .

gen A5c = .
replace A5c = 1 if a5c_1 == 1 
replace A5c = 2 if a5c_2 == 1 & A5c == .
replace A5c = 3 if a5c_3 == 1 & A5c == .
replace A5c = 99 if A5c == .
replace A5c = . if a5b != 1


drop a5c_1 a5c_2 a5c_3
* Ask about a5c, make sense that they split the variable.


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/


/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

tokenize "a1 a2 a3 b1 b2 b3 b4 c1 c2 c3 c4 d1 d2 d3 d4 d5 d6 e1 e2 e3 f1 f2 g1 g2 g3 h1 h2 h3 i1 j1 j2 j3 j4 k1 k2 k3 l1 l2"
forvalues i=1/38{
rename q15_``i'' q15_`i'
rename q16_``i'' q16_`i'
}

tokenize "A1 A2 A3 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4 D5 D6 E1 E2 E3 F1 F2 G1 G2 G3 H1 H2 H3 I1 J1 J2 J3 J4 K1 K2 K3 L1 L2"
forvalues i=1/38{
rename q15_`i' q15_``i''
rename q16_`i' q16_``i''
}

rename (*_g1) (*_G1)
rename (*_g2) (*_G2)
rename a1 a2 a3 a4 a5_1 a5_2 a6 a7 b1-b3, proper
rename a5b A5b

rename urban income2 city region strata, p
rename color psu ssu, u
rename interview_length Interview_length

forvalues i=1/3 {
forvalues y=1/3 {
rename q60_g`i'_`y' q60_G`i'_`y'
}
}

foreach x of varlist q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 relig ethni paff2 City Region q17{
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

tostring PSU SSU Strata, replace

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
replace incpp = 1 if paff2 == "Labour Party"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Maltese"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

*HUGE PROBLEM WITH PROBLEM SELECTED
* PROBLEM WITH EMP and WORK

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
