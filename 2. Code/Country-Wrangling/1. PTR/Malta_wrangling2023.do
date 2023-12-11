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
*/


gen nuts_ltn = "Malta"
gen nuts_id = "MT00"


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

foreach v in q36_8 {
g `v'=.
}

foreach v in q60_G1_98 q60_G1_99 q60_G2_98 q60_G2_99 q60_G3_98 q60_G3_99  {
g `v'= ""

}

/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

/*
drop gend_quota age2 quota_group ///
	q60_G1_1_99 q60_G1_2_99 q60_G1_3_99 q60_G2_1_99 q60_G2_2_99 q60_G2_3_99 q60_G3_1_99 q60_G3_2_99 q60_G3_3_99 ///
	consent_relig consent_ethni consent_disability consent_politics Income2_check 
*/
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename (*_g1) (*_G1)
rename (*_g2) (*_G2)
rename a1 a2 a3 a4 a5_1 a5_2 a6 a7 b1-b3, proper
rename (a5b a5c) (A5b A5c)

rename (q15_G1 q15_G2 q16_G1 q16_G2) (q15_g1 q15_g2 q16_g1 q16_g2)

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

rename urban income2 city region strata, p
rename color psu ssu, u
rename interview_length Interview_length

forvalues i=1/3 {
forvalues y=1/3 {
rename q60_g`i'_`y' q60_G`i'_`y'
}
}

foreach x of varlist q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 {
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

*--- Ethnicity groups:
* recode ethni (x=y)	 	// Recode following the European Standard Classification of Cultural and Ethnic Groups
* recode ethni (x=1)(y=2)(z=3)(98/99 = .), g(ethni_groups)

g ethni_groups = . 

/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 

foreach x in a b c d e f g h i j k {
recode q13`x' (1 = 1)(2 98 99 = .), g(aux_q13_`x')
}

egen d_total=rowtotal(aux_q13_*)

forvalues i=1/12 {
replace q14_`i'=0 if q14_`i'==. & d_total>0
}

drop aux_q13* d_total

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

* WRITE HERE ANY COMMENTS REGARDING THE QUALITY CHECKS


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the EU-S DATA / GPP / 2. Code / Country-Wrangling folder
	in the SharePoint.
*
