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

drop ID0 ID1 record uuid date status SAMPLE_FLAG TOTAL_COUNTRY_SAMPLE survey_language INTRO REC_GENQUO Age_rec INCOM2 INCOM3 INCOM0 INCOM1 NUTS1_AUT VAR_NUTS1_AUT VAR_N1Y VAR_N1Z VAR_NUTS1TEXT_AUT VAR_N1W VAR_N1X NUTS2_AUT VAR_NUTS2_AUT VAR_N1U VAR_N1V VAR_NUTS2TEXT_AUT VAR_N1S VAR_N1T NUTS3_AUT VAR_NUTS3_AUT VAR_N1Q VAR_N1R VAR_NUTS3TEXT_AUT VAR_N1O VAR_N1P LAU_AUT LAU_A0 LAU_A1 VAR_LAUCODE_AUT VAR_LA VAR_LB VAR_DEGURBA_AUT VAR_DA VAR_DB NUTS1_GER VAR_NUTS1_GER VAR_N1M VAR_N1N VAR_NUTS1TEXT_GER VAR_N1K VAR_N1L NUTS2_GER VAR_NUTS2_GER VAR_N1I VAR_N1J VAR_NUTS2TEXT_GER VAR_N1G VAR_N1H NUTS3_GER VAR_NUTS3_GER VAR_N1E VAR_N1F VAR_NUTS3TEXT_GER VAR_N1C VAR_N1D LAU_GER LAU_G0 LAU_G1 VAR_LAUCODE_GER VAR_L8 VAR_L9 VAR_DEGURBA_GER VAR_D8 VAR_D9 NUTS1_NLD VAR_NUTS1_NLD VAR_N1A VAR_N1B VAR_NUTS1TEXT_NLD VAR_N18 VAR_N19 NUTS2_NLD VAR_NUTS2_NLD VAR_N16 VAR_N17 VAR_NUTS2TEXT_NLD VAR_N14 VAR_N15 NUTS3_NLD VAR_NUTS3_NLD VAR_N12 VAR_N13 VAR_NUTS3TEXT_NLD VAR_N10 VAR_N11 LAU_NLD LAU_N0 LAU_N1 VAR_LAUCODE_NLD VAR_L6 VAR_L7 VAR_DEGURBA_NLD VAR_D6 VAR_D7 NUTS1_DNK VAR_NUTS1_DNK VAR_NY VAR_NZ VAR_NUTS1TEXT_DNK VAR_NW VAR_NX NUTS2_DNK VAR_NUTS2_DNK VAR_NU VAR_NV VAR_NUTS2TEXT_DNK VAR_NS VAR_NT NUTS3_DNK VAR_NUTS3_DNK VAR_NQ VAR_NR VAR_NUTS3TEXT_DNK VAR_NO VAR_NP LAU_DNK LAU_D0 LAU_D1 VAR_LAUCODE_DNK VAR_L4 VAR_L5 VAR_DEGURBA_DNK VAR_D4 VAR_D5 NUTS1_BEL VAR_NUTS1_BEL VAR_NM VAR_NN VAR_NUTS1TEXT_BEL VAR_NK VAR_NL NUTS2_BEL VAR_NUTS2_BEL VAR_NI VAR_NJ VAR_NUTS2TEXT_BEL VAR_NG VAR_NH NUTS3_BEL VAR_NUTS3_BEL VAR_NE VAR_NF VAR_NUTS3TEXT_BEL VAR_NC VAR_ND LAU_BEL LAU_B0 LAU_B1 VAR_LAUCODE_BEL VAR_L2 VAR_L3 VAR_DEGURBA_BEL VAR_D2 VAR_D3 NUTS1_ITA VAR_NUTS1_ITA VAR_NA VAR_NB VAR_NUTS1TEXT_ITA VAR_N8 VAR_N9 NUTS2_ITA VAR_NUTS2_ITA VAR_N6 VAR_N7 VAR_NUTS2TEXT_ITA VAR_N4 VAR_N5 NUTS3_ITA VAR_NUTS3_ITA VAR_N2 VAR_N3 VAR_NUTS3TEXT_ITA VAR_N0 VAR_N1 LAU_ITA LAU_I0 LAU_I1 VAR_LAUCODE_ITA VAR_L0 VAR_L1 VAR_DEGURBA_ITA VAR_D0 VAR_D1 DEGURBA REC_QUOQ17A1 REC_QUOQ17A2 REC_QUOQ17A3 REC_QUOQ17B1 REC_QUOQ17B2 REC_QUOQ17B3 REC_QUOQ17B4 REC_QUOQ17C1 REC_QUOQ17C2 REC_QUOQ17C3 REC_QUOQ17C4 REC_QUOQ17D1 REC_QUOQ17D2 REC_QUOQ17D3 REC_QUOQ17D4 REC_QUOQ17D5 REC_QUOQ17D6 REC_QUOQ17E1 REC_QUOQ17E2 REC_QUOQ17E3 REC_QUOQ17F1 REC_QUOQ17F2 REC_QUOQ17G1 REC_QUOQ17G2 REC_QUOQ17G3 REC_QUOQ17H1 REC_QUOQ17H2 REC_QUOQ17H3 REC_QUOQ17I1 REC_QUOQ17J1 REC_QUOQ17J2 REC_QUOQ17J3 REC_QUOQ17J4 REC_QUOQ17K1 REC_QUOQ17K2 REC_QUOQ17K3 REC_QUOQ17L1 REC_QUOQ17L2 REC_QUOFINA1 REC_QUOFINA2 REC_QUOFINA3 REC_QUOFINB1 REC_QUOFINB2 REC_QUOFINB3 REC_QUOFINB4 REC_QUOFINC1 REC_QUOFINC2 REC_QUOFINC3 REC_QUOFINC4 REC_QUOFIND1 REC_QUOFIND2 REC_QUOFIND3 REC_QUOFIND4 REC_QUOFIND5 REC_QUOFIND6 REC_QUOFINE1 REC_QUOFINE2 REC_QUOFINE3 REC_QUOFINF1 REC_QUOFINF2 REC_QUOFING1 REC_QUOFING2 REC_QUOFING3 REC_QUOFINH1 REC_QUOFINH2 REC_QUOFINH3 REC_QUOFINI1 REC_QUOFINJ1 REC_QUOFINJ2 REC_QUOFINJ3 REC_QUOFINJ4 REC_QUOFINK1 REC_QUOFINK2 REC_QUOFINK3 REC_QUOFINL1 REC_QUOFINL2 Q170 Q171 Random_Alloc_SEC7 Random_Alloc_SEC8 REC_Q46 REC_Q47 Random_Alloc_SEC9 Q60_GG Q60_GH Q60_GE Q60_GF Q60_GC Q60_GD noanswerq60_G1_r4 noanswerq60_G1_r5 Q60_GA Q60_GB Q60_G8 Q60_G9 Q60_G6 Q60_G7 noanswerq60_G2_r4 noanswerq60_G2_r5 Q60_G4 Q60_G5 Q60_G2 Q60_G3 Q60_G0 Q60_G1 noanswerq60_G3_r4 noanswerq60_G3_r5 ethni_rec A5_98 A5_99
	
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
