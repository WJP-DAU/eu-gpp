/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (COUNTRY - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:
Data wrangling cleaning and harmonization routine for the COUNRTY_NAME pretest data received on DD/MM/YYYY.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

recode Region (8 = 1 "RO1")(4 5 = 2 "RO2")(6 = 3 "RO3")(1 7= 4 "RO4"), g(nuts_id_aux)
decode nuts_id_aux, g(nuts_id)
drop nuts_id_aux
g nuts_ltn = ""
replace nuts_ltn = "Macroregiunea Unu" if nuts_id == "RO1"
replace nuts_ltn = "Macroregiunea Doi" if nuts_id == "RO2"
replace nuts_ltn = "Macroregiunea Trei" if nuts_id == "RO3"
replace nuts_ltn = "Macroregiunea Patru" if nuts_id == "RO4"

*We need the information at NUTS level, this division of regions doesn't allow us to know precisely the NUTS where each region belongs
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

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}

gen Income2 = .

* Variable income 2 is not in the data base this variable should contain the information of the variable named as income1 in the data
* Variable income should be organized by quintiles
/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop income1a
* income1a must be part of income 1

/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename income1 income
rename income_cur1 income_cur 
foreach x of varlist income_cur income_time q17 City Region ethni relig paff2  q60_G1_1 q60_G1_2  q60_G1_3 q60_G2_1  q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2  q60_G3_3{
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}
lab define q17 ///
	1 "A1" 2 "A2" 3 "A3" 4 "B1" 5 "B2" 6 "B3" 7 "B4" 8 "C1" 9 "C2" 10 "C3" 11 "C4" 12 "D1" 13 "D2" ///
	14 "D3" 15 "D4" 16 "D5" 17 "D6" 18 "E1" 19 "E2" 20 "E3" 21 "F1" 22 "F2" 23 "G1" 24 "G2" 25 "G3" ///
	26 "H1" 27 "H2" 28 "H3" 29 "I1" 30 "J1" 31 "J2" 32 "J3" 33 "J4" 34 "K1" 35 "K2" 36 "K3" 37 "L1" ///
	38 "L2"
/* Note:
	Always check that Gend is correctly coded (Male == 1)(Female == 2)(Nonbin == 3)(Not recog == 4)
	
	When applicable, remember to decode (convert variables to string) the following variables:
		- income_cur
		- income_time
		- q17
		- City
		- Region
		- Strata / PSU / SSU
		- ethni / relig / paff2 (only for the pretest)
		- rol open ended questions
	
	- Also check their values and labels. 
	- Please standardize the DK/NA values for income, income_cur, income_time to (No need for pretest):
		- "Don't know"
		- "No Answer"
	- Please check that the DK/NA values for q33b, q38e, q38f, q38g_1, q38h_1, and Income2 are encoded as:
		- "Don't know" = -8888
		- "No Answer"  = -9999
	- Check the values for q17, they should be equal to the problem code: A2, A3, B1, L2, etc. This is VERY 
	IMPORTANT for the A2J problem selection checks.
	- Check that multiple choice questions (q14, q21, q36) are correctly encoded as binary (1 | 2)
	- Make sure that the interview lenght is in minutes
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
* recode paff2 (x=y)		// Recode following the Party Coding Units from the V-Party Dataset
* g incpp = (paff2 == xx) if paff2 != .
g incpp = . 
	// Alway gen an empty vector for the PRETEST!!!

*--- Ethnicity groups:
* recode ethni (x=y)	 	// Recode following the European Standard Classification of Cultural and Ethnic Groups
* recode ethni (x=1)(y=2)(z=3)(98/99 = .), g(ethni_groups)
g ethni_groups = . 
	// Alway gen an empty vector for the PRETEST!!!


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/


foreach x of varlist q3a q3b q3c q3d q3e q3f q3g q3h q3i q3j q3k {
	replace `x' = 98 if `x' == 5
	replace `x' = 99 if `x' == 6

}
* Variables q3a q3b q3c q3d q3e q3f q3g have not coded well, 5 should be dont know and 6 prefer not to say


* A2J problems are choosen with DK/no answer, please remember that the problem is selected if the severity is higher than 4 and less or equal 10. If the are only one problem with a lower severity this problem will be selected.

* There is one problem that is selected when the person didnt mention it

* Please remember this question must be asked only for these problems: A1, A2, A3, B1, B2, B3, B4, C1, F1, I1 J4, K1, K2, K3, L1, L2. There are 10 problems outside of these list that are answered.

* Please verify the routing, people who answer DK o Prefer not to say must answer wagreement

* Please check randomization in the Civic Participation module

* Please check randomization in the Institutional Performance module

* Please check randomization in the Rule of Law question



/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

* 3 obs have more than 45 DK/NA values in the target variables. ID=1,33,47
* aux_JSE_fairoutcomes .33333333 percent of obs with DK/NA
* 9 individual(s) have a high difficulty score. ID = 1, 29, 33, 36, 46, 47, 49, 50, 52

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
