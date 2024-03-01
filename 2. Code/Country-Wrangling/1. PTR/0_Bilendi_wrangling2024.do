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

gen nuts_id =VAR_NUTS1_AUT

foreach v in VAR_NUTS1_GER VAR_NUTS1_NLD VAR_NUTS2_DNK VAR_NUTS1_BEL VAR_NUTS1_ITA {
replace nuts_id=`v' if nuts_id=="" & `v'!=""
}

gen nuts_ltn =VAR_NUTS1TEXT_AUT
foreach v in VAR_NUTS1TEXT_GER VAR_NUTS1TEXT_NLD VAR_NUTS2TEXT_DNK VAR_NUTS1TEXT_ITA {
replace nuts_ltn=`v' if nuts_ltn=="" & `v'!=""
}

*Denmark
replace nuts_ltn="Sjaelland" if nuts_ltn=="Sjælland"

*Belgium
replace nuts_ltn="Région de Bruxelles-Capitale/Brussels Hoofdstedelijk Gewest" if nuts_id=="BE1"
replace nuts_ltn="Vlaams Gewest" if nuts_id=="BE2"
replace nuts_ltn="Région wallonne" if nuts_id=="BE3"

*Italy
replace nuts_ltn="Centro (IT)" if nuts_ltn=="Centro"


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

rename country country1
decode country, g(country)
drop country1
foreach x of varlist ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

g year = .

***City - includes municipalities
g City =""

replace City=LAU_AUT if country=="Austria"
replace City=LAU_GER if country=="Germany"
replace City=LAU_NLD if country=="Netherlands"
replace City=LAU_DNK if country=="Denmark"
replace City=LAU_BEL if country=="Belgium"
replace City=LAU_ITA if country=="Italy"

***Region
g Region =""

replace Region=VAR_NUTS2TEXT_AUT if country=="Austria"
replace Region=VAR_NUTS1TEXT_GER if country=="Germany"
replace Region=VAR_NUTS2TEXT_NLD if country=="Netherlands"
replace Region=VAR_NUTS2TEXT_DNK if country=="Denmark"
replace Region="Sjaelland" if Region=="Sjælland"
replace Region=VAR_NUTS2TEXT_BEL if country=="Belgium"
replace Region=VAR_NUTS2TEXT_ITA if country=="Italy"

***Urban
g Urban = DEGURBA
recode Urban (1 2=1) (3=2)

***Missing variables

g q60_G1_98 = .
g q60_G1_99 = .
g q60_G2_98 = .
g q60_G2_99 = .
g q60_G3_98 = .
g q60_G3_99 = .
g PSU = .
g SSU = .
g B1 = .
g B2 = .
g B3 = .
g qpi1 = .
g qpi2a = .
g qpi2b = .
g qpi2c = .
g qpi2d = .
g qpi2e = .
g qpi2f = .
g qpi3a = .
g qpi3b = .
g qpi3c = .
g qpi3d = .
g COLOR = .
g dweight = .
g Strata = .

/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop record uuid date status SAMPLE_FLAG TOTAL_COUNTRY_SAMPLE survey_language INTRO REC_GENQUO Age_rec NUTS1_AUT VAR_NUTS1_AUT VAR_NUTS1TEXT_AUT NUTS2_AUT VAR_NUTS2_AUT VAR_NUTS2TEXT_AUT NUTS3_AUT VAR_NUTS3_AUT VAR_NUTS3TEXT_AUT LAU_AUT VAR_LAUCODE_AUT VAR_DEGURBA_AUT NUTS1_GER VAR_NUTS1_GER VAR_NUTS1TEXT_GER NUTS2_GER VAR_NUTS2_GER VAR_NUTS2TEXT_GER NUTS3_GER VAR_NUTS3_GER VAR_NUTS3TEXT_GER LAU_GER VAR_LAUCODE_GER VAR_DEGURBA_GER NUTS1_NLD VAR_NUTS1_NLD VAR_NUTS1TEXT_NLD NUTS2_NLD VAR_NUTS2_NLD VAR_NUTS2TEXT_NLD NUTS3_NLD VAR_NUTS3_NLD VAR_NUTS3TEXT_NLD LAU_NLD VAR_LAUCODE_NLD VAR_DEGURBA_NLD NUTS1_DNK VAR_NUTS1_DNK VAR_NUTS1TEXT_DNK NUTS2_DNK VAR_NUTS2_DNK VAR_NUTS2TEXT_DNK NUTS3_DNK VAR_NUTS3_DNK VAR_NUTS3TEXT_DNK LAU_DNK VAR_LAUCODE_DNK VAR_DEGURBA_DNK NUTS1_BEL VAR_NUTS1_BEL VAR_NUTS1TEXT_BEL NUTS2_BEL VAR_NUTS2_BEL VAR_NUTS2TEXT_BEL NUTS3_BEL VAR_NUTS3_BEL VAR_NUTS3TEXT_BEL LAU_BEL VAR_LAUCODE_BEL VAR_DEGURBA_BEL NUTS1_ITA VAR_NUTS1_ITA VAR_NUTS1TEXT_ITA NUTS2_ITA VAR_NUTS2_ITA VAR_NUTS2TEXT_ITA NUTS3_ITA VAR_NUTS3_ITA VAR_NUTS3TEXT_ITA LAU_ITA VAR_LAUCODE_ITA VAR_DEGURBA_ITA DEGURBA REC_QUOQ17A1 REC_QUOQ17A2 REC_QUOQ17A3 REC_QUOQ17B1 REC_QUOQ17B2 REC_QUOQ17B3 REC_QUOQ17B4 REC_QUOQ17C1 REC_QUOQ17C2 REC_QUOQ17C3 REC_QUOQ17C4 REC_QUOQ17D1 REC_QUOQ17D2 REC_QUOQ17D3 REC_QUOQ17D4 REC_QUOQ17D5 REC_QUOQ17D6 REC_QUOQ17E1 REC_QUOQ17E2 REC_QUOQ17E3 REC_QUOQ17F1 REC_QUOQ17F2 REC_QUOQ17G1 REC_QUOQ17G2 REC_QUOQ17G3 REC_QUOQ17H1 REC_QUOQ17H2 REC_QUOQ17H3 REC_QUOQ17I1 REC_QUOQ17J1 REC_QUOQ17J2 REC_QUOQ17J3 REC_QUOQ17J4 REC_QUOQ17K1 REC_QUOQ17K2 REC_QUOQ17K3 REC_QUOQ17L1 REC_QUOQ17L2 REC_QUOFINA1 REC_QUOFINA2 REC_QUOFINA3 REC_QUOFINB1 REC_QUOFINB2 REC_QUOFINB3 REC_QUOFINB4 REC_QUOFINC1 REC_QUOFINC2 REC_QUOFINC3 REC_QUOFINC4 REC_QUOFIND1 REC_QUOFIND2 REC_QUOFIND3 REC_QUOFIND4 REC_QUOFIND5 REC_QUOFIND6 REC_QUOFINE1 REC_QUOFINE2 REC_QUOFINE3 REC_QUOFINF1 REC_QUOFINF2 REC_QUOFING1 REC_QUOFING2 REC_QUOFING3 REC_QUOFINH1 REC_QUOFINH2 REC_QUOFINH3 REC_QUOFINI1 REC_QUOFINJ1 REC_QUOFINJ2 REC_QUOFINJ3 REC_QUOFINJ4 REC_QUOFINK1 REC_QUOFINK2 REC_QUOFINK3 REC_QUOFINL1 REC_QUOFINL2 Random_Alloc_SEC7 Random_Alloc_SEC8 REC_Q46 REC_Q47 Random_Alloc_SEC9 noanswerq60_G1_r4 noanswerq60_G1_r5 noanswerq60_G2_r4 noanswerq60_G2_r5 noanswerq60_G3_r4 noanswerq60_G3_r5 ethni_rec A5_98 A5_99
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

*rename Politics politics

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

recode A5_1 A5_2 (0=2)
replace Interview_length=Interview_length/60

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
