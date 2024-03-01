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

decode Region, g(region)
decode City, g(city)

gen nuts_ltn=""
replace nuts_ltn="Jadranska Hrvatska" if region=="Dalmatia"
replace nuts_ltn="Jadranska Hrvatska" if region=="Istria, Hrvatsko Primorj, Gorski Kotar"
replace nuts_ltn="Panonska Hrvatska" if region=="Lika, Kordun, Banija"
replace nuts_ltn="Panonska Hrvatska" if region=="Slavonia"
replace nuts_ltn="Grad Zagreb" if city=="Ivanja Reka"
replace nuts_ltn="Sjeverna Hrvatska" if City==5 //Madžarevo
replace nuts_ltn="Sjeverna Hrvatska" if city=="Nedeljanec"
replace nuts_ltn="Panonska Hrvatska" if city=="Veliko Trojstvo"
replace nuts_ltn="Sjeverna Hrvatska" if City==8 //Varaždin
replace nuts_ltn="Grad Zagreb" if region=="Zagreb"

gen nuts_id=""
replace nuts_id="HR02" if nuts_ltn=="Panonska Hrvatska"
replace nuts_id="HR03" if nuts_ltn=="Jadranska Hrvatska"
replace nuts_id="HR05" if nuts_ltn=="Grad Zagreb"
replace nuts_id="HR06" if nuts_ltn=="Sjeverna Hrvatska"

drop Region City
rename city City
rename region Region 

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

g q60_G1_98 = .
g q60_G1_99 = .
g q60_G2_98 = .
g q60_G2_99 = .
g q60_G3_98 = .
g q60_G3_99 = .


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/



	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename income1 Income2
rename income_cur1 income_cur 
rename income1a income

replace q17=. if q17>38 & q17!=.
rename q17 q17a
decode q17a, g(q17)
drop q17a

forvalues i=1/3 {
forvalues y=1/3 {
replace q60_G`i'_`y'=. if q60_G`i'_`y'==98
replace q60_G`i'_`y'=. if q60_G`i'_`y'==99
}
}

foreach v in q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 {
rename `v' `v'n
decode `v'n, g(`v')
drop `v'n
}

foreach v in q16_A1 q16_A2 q16_A3 q16_B1 q16_B2 q16_B3 q16_B4 q16_C1 q16_C2 q16_C3 q16_C4 q16_D1 q16_D2 q16_D3 q16_D4 q16_D5 q16_D6 q16_E1 q16_E2 q16_E3 q16_F1 q16_F2 q16_G1 q16_G2 q16_G3 q16_H1 q16_H2 q16_H3 q16_I1 q16_J1 q16_J2 q16_J3 q16_J4 q16_K1 q16_K2 q16_K3 q16_L1 q16_L2 {
replace `v'=`v'-1
}

recode q33b (98 = -8888) (99 = -9999)

replace Interview_length=Interview_length/60

foreach x of varlist ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

/* Note:
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

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 

replace q17="C3" if q17=="C2" & q15_C2==2 & q15_C3==1

gen p18a=.

local qset "A1 A2 A3 B1 B2 B3 B4 C1 F1 I1 J4 K1 K2 K3 L1 L2" 
foreach v in `qset' {
replace p18a=1 if q17=="`v'"
}

replace q18a=. if p18a!=1
drop p18a

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
