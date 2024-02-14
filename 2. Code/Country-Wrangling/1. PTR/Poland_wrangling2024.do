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

gen nuts_ltn=.
gen nuts_id=.


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

g q36_8    = .

forvalues i=1/12 {
rename Q14a_`i' q14_`i'
}

rename Q14a_98 q14_98 
rename Q14a_99 q14_99

gen City=.
gen Region=.
gen Urban=.
g income_cur = .
g income_time = .
g PSU = .
g SSU = .
g dweight = .
g Strata = .

/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop INCOM0 INCOM1 INCOM2 Q38F0 Q38F1 Q38F2 Q38f_2 Q38F_0 Q38F_1 Q38F_3 Q38G_0 Q38G_2 Q38G_3 Q38H_0 Q38H_2 Q38H_3 Q60_GO Q60_GP Q60_GQ Q60_GL Q60_GM Q60_GN Q60_GI ///
Q60_GJ Q60_GK Q60_GF Q60_GG Q60_GH Q60_GC Q60_GD Q60_GE Q60_G9 Q60_GA Q60_GB Q60_G6 Q60_G7 Q60_G8 Q60_G3 Q60_G4 Q60_G5 Q60_G0 Q60_G1 Q60_G2 Relig_13_other ///
RELIG0 RELIG1 RELIG2 Ethni_97_other ETHNI0 ETHNI1 ETHNI2 PAFF20 PAFF21 PAFF22

drop Q14A_0 Q14A_A Q14A_B
	
g q60_G1_98 = .
g q60_G1_99 = .
g q60_G2_98 = .
g q60_G2_99 = .
g q60_G3_98 = .
g q60_G3_99 = .

drop Incomex Income__99 Q14a_12_other Q14b_1 Q14b_2 Q14b_3 Q14b_4 Q14b_5 Q14b_6 Q14b_7 Q14b_8 Q14b_9 Q14b_10 Q14b_11 Q14b_12 Q14b_12_other Q14B_0 Q14B_A Q14B_B Q14b_98 Q14b_99 Q14c_1 Q14c_2 Q14c_3 Q14c_4 Q14c_5 Q14c_6 Q14c_7 Q14c_8 Q14c_9 Q14c_10 Q14c_11 Q14c_12 Q14c_12_other Q14C_0 Q14C_A Q14C_B Q14c_98 Q14c_99 Q14d_1 Q14d_2 Q14d_3 Q14d_4 Q14d_5 Q14d_6 Q14d_7 Q14d_8 Q14d_9 Q14d_10 Q14d_11 Q14d_12 Q14d_12_other Q14D_0 Q14D_A Q14D_B Q14d_98 Q14d_99 Q14e_1 Q14e_2 Q14e_3 Q14e_4 Q14e_5 Q14e_6 Q14e_7 Q14e_8 Q14e_9 Q14e_10 Q14e_11 Q14e_12 Q14e_12_other Q14E_0 Q14E_A Q14E_B Q14e_98 Q14e_99 Q14f_1 Q14f_2 Q14f_3 Q14f_4 Q14f_5 Q14f_6 Q14f_7 Q14f_8 Q14f_9 Q14f_10 Q14f_11 Q14f_12 Q14f_12_other Q14F_0 Q14F_A Q14F_B Q14f_98 Q14f_99 Q14g_1 Q14g_2 Q14g_3 Q14g_4 Q14g_5 Q14g_6 Q14g_7 Q14g_8 Q14g_9 Q14g_10 Q14g_11 Q14g_12 Q14g_12_other Q14G_0 Q14G_A Q14G_B Q14g_98 Q14g_99 Q14h_1 Q14h_2 Q14h_3 Q14h_4 Q14h_5 Q14h_6 Q14h_7 Q14h_8 Q14h_9 Q14h_10 Q14h_11 Q14h_12 Q14h_12_other Q14H_0 Q14H_A Q14H_B Q14h_98 Q14h_99 Q14i_1 Q14i_2 Q14i_3 Q14i_4 Q14i_5 Q14i_6 Q14i_7 Q14i_8 Q14i_9 Q14i_10 Q14i_11 Q14i_12 Q14i_12_other Q14I_0 Q14I_A Q14I_B Q14i_98 Q14i_99 Q14j_1 Q14j_2 Q14j_3 Q14j_4 Q14j_5 Q14j_6 Q14j_7 Q14j_8 Q14j_9 Q14j_10 Q14j_11 Q14j_12 Q14j_12_other Q14J_0 Q14J_A Q14J_B Q14j_98 Q14j_99 Q14k_1 Q14k_2 Q14k_3 Q14k_4 Q14k_5 Q14k_6 Q14k_7 Q14k_8 Q14k_9 Q14k_10 Q14k_11 Q14k_12 Q14k_12_other Q14K_0 Q14K_A Q14K_B Q14k_98 Q14k_99 Q39_LOS G1_LOS G1_98 G1_99 Paff2_6_other

/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename Gend AGE Income, lower
rename Income_1 Income2

rename Q1a-Q13k, lower

local cat A1 A2	A3	B1	B2	B3	B4	C1	C2	C3	C4	D1	D2	D3	D4	D5	D6	E1	E2	E3	F1	F2	G1	G2	G3	H1	H2	H3	I1	J1	J2	J3	J4	K1	K2	K3	L1	L2
foreach v in `cat' {
rename Q15_`v' q15_`v'
rename Q16_`v' q16_`v'
}

rename Q17-Q38f, lower
rename Q38g Q38g_1 Q38h Q38h_1, lower

forvalues i=46/57 {
rename Q`i'_G1 q`i'_G1 
rename Q`i'_G2 q`i'_G2
}

rename Q58a Q58b Q58c Q58d Q58e Q58f Q58g Q58h Q58i Q58j Q59a Q59b Q59c Q59d Q59e Q59f Q59g Q59h Q59i Q59j, lower
rename Relig Ethni Nation Fin Edu Emp Work Wagreement Marital Mcertificate Disability Disability2 Politics Paff1 Paff2, lower
rename QPI1 QPI2a QPI2b QPI2c QPI2d QPI2e QPI2f QPI3a QPI3b QPI3c QPI3d, lower
rename Color COLOR

foreach v in q14_1 q14_2 q14_3 q14_4 q14_5 q14_6 q14_7 q14_8 q14_9 q14_10 q14_11 q14_12 q14_98 q14_99 {
recode `v' (0 = 2)
}

recode q15_A3 (98 =.)

foreach v in q21_1 q21_2 q21_3 q21_4 q21_5 q21_6 q21_7 q21_8 q21_9 q21_98 q21_99 {
recode `v' (0 = 2)
}

foreach v in q36_1 q36_2 q36_3 q36_4 q36_5 q36_6 q36_7 q36_98 q36_99 {
recode `v' (0 = 2)
}

destring q38f q38g_1 q38h_1 Income2, replace
replace Interview_length=Interview_length/60


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

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 

replace q7e=. if q6e!= 1
replace mcertificate=. if marital<3 & marital!=. & mcertificate!=.


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
