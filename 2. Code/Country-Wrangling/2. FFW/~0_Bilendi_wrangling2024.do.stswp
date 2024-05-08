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

*** Removing pretest data
drop if SAMPLE_FLAG==1

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

/* Note:
	Online polls will be missing the following variables (just uncomment): */
	
	forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}

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

g year = .

rename country country1
decode country, g(country)
drop country1

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


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/


drop ID0 ID1 record uuid date status Interview_length_sec TOTAL_COUNTRY_SAMPLE survey_language INTRO REC_GENQUO Age_rec INCOM6 INCOM7 INCOM8 INCOM9 INCOMA INCOMB INCOM0 INCOM1 INCOM2 INCOM3 INCOM4 INCOM5 ///
REC_QUOQ17A1 REC_QUOQ17A2 REC_QUOQ17A3 REC_QUOQ17B1 REC_QUOQ17B2 REC_QUOQ17B3 REC_QUOQ17B4 REC_QUOQ17C1 REC_QUOQ17C2 REC_QUOQ17C3 REC_QUOQ17C4 REC_QUOQ17D1 REC_QUOQ17D2 REC_QUOQ17D3 REC_QUOQ17D4 REC_QUOQ17D5 ///
REC_QUOQ17D6 REC_QUOQ17E1 REC_QUOQ17E2 REC_QUOQ17E3 REC_QUOQ17F1 REC_QUOQ17F2 REC_QUOQ17G1 REC_QUOQ17G2 REC_QUOQ17G3 REC_QUOQ17H1 REC_QUOQ17H2 REC_QUOQ17H3 REC_QUOQ17I1 REC_QUOQ17J1 REC_QUOQ17J2 REC_QUOQ17J3 ///
REC_QUOQ17J4 REC_QUOQ17K1 REC_QUOQ17K2 REC_QUOQ17K3 REC_QUOQ17L1 REC_QUOQ17L2 REC_QUOFINA1 REC_QUOFINA2 REC_QUOFINA3 REC_QUOFINB1 REC_QUOFINB2 REC_QUOFINB3 REC_QUOFINB4 REC_QUOFINC1 REC_QUOFINC2 REC_QUOFINC3 ///
REC_QUOFINC4 REC_QUOFIND1 REC_QUOFIND2 REC_QUOFIND3 REC_QUOFIND4 REC_QUOFIND5 REC_QUOFIND6 REC_QUOFINE1 REC_QUOFINE2 REC_QUOFINE3 REC_QUOFINF1 REC_QUOFINF2 REC_QUOFING1 REC_QUOFING2 REC_QUOFING3 REC_QUOFINH1 ///
REC_QUOFINH2 REC_QUOFINH3 REC_QUOFINI1 REC_QUOFINJ1 REC_QUOFINJ2 REC_QUOFINJ3 REC_QUOFINJ4 REC_QUOFINK1 REC_QUOFINK2 REC_QUOFINK3 REC_QUOFINL1 REC_QUOFINL2 ///
Q170 Q171 Q172 Q173 Q174 Q175 Random_Alloc_SEC7 Random_Alloc_SEC8 REC_Q46 REC_Q47 Random_Alloc_SEC9 ///
Q60_G1H Q60_G1I Q60_G1J Q60_G1K Q60_G1L Q60_G1M Q60_G1B Q60_G1C Q60_G1D Q60_G1E Q60_G1F Q60_G1G Q60_G15 Q60_G16 Q60_G17 Q60_G18 Q60_G19 Q60_G1A noanswerq60_G1_r4 noanswerq60_G1_r5 Q60_GZ Q60_G10 Q60_G11 Q60_G12 ///
Q60_G13 Q60_G14 Q60_GT Q60_GU Q60_GV Q60_GW Q60_GX Q60_GY Q60_GN Q60_GO Q60_GP Q60_GQ Q60_GR Q60_GS noanswerq60_G2_r4 noanswerq60_G2_r5 Q60_GH Q60_GI Q60_GJ Q60_GK Q60_GL Q60_GM Q60_GB Q60_GC Q60_GD Q60_GE Q60_GF ///
Q60_GG Q60_G5 Q60_G6 Q60_G7 Q60_G8 Q60_G9 Q60_GA noanswerq60_G3_r4 noanswerq60_G3_r5 ///
NUTS1_AUT VAR_NUTS1_AUT VAR_N5U VAR_N5V VAR_N5W VAR_N5X VAR_N5Y VAR_N5Z VAR_NUTS1TEXT_AUT VAR_N5O VAR_N5P VAR_N5Q VAR_N5R VAR_N5S VAR_N5T NUTS2_AUT VAR_NUTS2_AUT VAR_N5I VAR_N5J VAR_N5K VAR_N5L VAR_N5M VAR_N5N VAR_NUTS2TEXT_AUT VAR_N5C VAR_N5D VAR_N5E VAR_N5F VAR_N5G VAR_N5H NUTS3_AUT VAR_NUTS3_AUT VAR_N56 VAR_N57 VAR_N58 VAR_N59 VAR_N5A VAR_N5B VAR_NUTS3TEXT_AUT VAR_N50 VAR_N51 VAR_N52 VAR_N53 VAR_N54 VAR_N55 LAU_AUT LAU_A0 LAU_A1 LAU_A2 LAU_A3 LAU_A4 LAU_A5 VAR_LAUCODE_AUT VAR_LU VAR_LV VAR_LW VAR_LX VAR_LY VAR_LZ VAR_DEGURBA_AUT VAR_DU VAR_DV VAR_DW VAR_DX VAR_DY VAR_DZ NUTS1_GER VAR_NUTS1_GER VAR_N4U VAR_N4V VAR_N4W VAR_N4X VAR_N4Y VAR_N4Z VAR_NUTS1TEXT_GER VAR_N4O VAR_N4P VAR_N4Q VAR_N4R VAR_N4S VAR_N4T NUTS2_GER VAR_NUTS2_GER VAR_N4I VAR_N4J VAR_N4K VAR_N4L VAR_N4M VAR_N4N VAR_NUTS2TEXT_GER VAR_N4C VAR_N4D VAR_N4E VAR_N4F VAR_N4G VAR_N4H NUTS3_GER VAR_NUTS3_GER VAR_N46 VAR_N47 VAR_N48 VAR_N49 VAR_N4A VAR_N4B VAR_NUTS3TEXT_GER VAR_N40 VAR_N41 VAR_N42 VAR_N43 VAR_N44 VAR_N45 LAU_GER LAU_G0 LAU_G1 LAU_G2 LAU_G3 LAU_G4 LAU_G5 VAR_LAUCODE_GER VAR_LO VAR_LP VAR_LQ VAR_LR VAR_LS VAR_LT VAR_DEGURBA_GER VAR_DO VAR_DP VAR_DQ VAR_DR VAR_DS VAR_DT NUTS1_NLD VAR_NUTS1_NLD VAR_N3U VAR_N3V VAR_N3W VAR_N3X VAR_N3Y VAR_N3Z VAR_NUTS1TEXT_NLD VAR_N3O VAR_N3P VAR_N3Q VAR_N3R VAR_N3S VAR_N3T NUTS2_NLD VAR_NUTS2_NLD VAR_N3I VAR_N3J VAR_N3K VAR_N3L VAR_N3M VAR_N3N VAR_NUTS2TEXT_NLD VAR_N3C VAR_N3D VAR_N3E VAR_N3F VAR_N3G VAR_N3H NUTS3_NLD VAR_NUTS3_NLD VAR_N36 VAR_N37 VAR_N38 VAR_N39 VAR_N3A VAR_N3B VAR_NUTS3TEXT_NLD VAR_N30 VAR_N31 VAR_N32 VAR_N33 VAR_N34 VAR_N35 LAU_NLD LAU_N0 LAU_N1 LAU_N2 LAU_N3 LAU_N4 LAU_N5 VAR_LAUCODE_NLD VAR_LI VAR_LJ VAR_LK VAR_LL VAR_LM VAR_LN VAR_DEGURBA_NLD VAR_DI VAR_DJ VAR_DK VAR_DL VAR_DM VAR_DN NUTS1_DNK VAR_NUTS1_DNK VAR_N2U VAR_N2V VAR_N2W VAR_N2X VAR_N2Y VAR_N2Z VAR_NUTS1TEXT_DNK VAR_N2O VAR_N2P VAR_N2Q VAR_N2R VAR_N2S VAR_N2T NUTS2_DNK VAR_NUTS2_DNK VAR_N2I VAR_N2J VAR_N2K VAR_N2L VAR_N2M VAR_N2N VAR_NUTS2TEXT_DNK VAR_N2C VAR_N2D VAR_N2E VAR_N2F VAR_N2G VAR_N2H NUTS3_DNK VAR_NUTS3_DNK VAR_N26 VAR_N27 VAR_N28 VAR_N29 VAR_N2A VAR_N2B VAR_NUTS3TEXT_DNK VAR_N20 VAR_N21 VAR_N22 VAR_N23 VAR_N24 VAR_N25 LAU_DNK LAU_D0 LAU_D1 LAU_D2 LAU_D3 LAU_D4 LAU_D5 VAR_LAUCODE_DNK VAR_LC VAR_LD VAR_LE VAR_LF VAR_LG VAR_LH VAR_DEGURBA_DNK VAR_DC VAR_DD VAR_DE VAR_DF VAR_DG VAR_DH NUTS1_BEL VAR_NUTS1_BEL VAR_N1U VAR_N1V VAR_N1W VAR_N1X VAR_N1Y VAR_N1Z VAR_NUTS1TEXT_BEL VAR_N1O VAR_N1P VAR_N1Q VAR_N1R VAR_N1S VAR_N1T NUTS2_BEL VAR_NUTS2_BEL VAR_N1I VAR_N1J VAR_N1K VAR_N1L VAR_N1M VAR_N1N VAR_NUTS2TEXT_BEL VAR_N1C VAR_N1D VAR_N1E VAR_N1F VAR_N1G VAR_N1H NUTS3_BEL VAR_NUTS3_BEL VAR_N16 VAR_N17 VAR_N18 VAR_N19 VAR_N1A VAR_N1B VAR_NUTS3TEXT_BEL VAR_N10 VAR_N11 VAR_N12 VAR_N13 VAR_N14 VAR_N15 LAU_BEL LAU_B0 LAU_B1 LAU_B2 LAU_B3 LAU_B4 LAU_B5 VAR_LAUCODE_BEL VAR_L6 VAR_L7 VAR_L8 VAR_L9 VAR_LA VAR_LB VAR_DEGURBA_BEL VAR_D6 VAR_D7 VAR_D8 VAR_D9 VAR_DA VAR_DB NUTS1_ITA VAR_NUTS1_ITA VAR_NU VAR_NV VAR_NW VAR_NX VAR_NY VAR_NZ VAR_NUTS1TEXT_ITA VAR_NO VAR_NP VAR_NQ VAR_NR VAR_NS VAR_NT NUTS2_ITA VAR_NUTS2_ITA VAR_NI VAR_NJ VAR_NK VAR_NL VAR_NM VAR_NN VAR_NUTS2TEXT_ITA VAR_NC VAR_ND VAR_NE VAR_NF VAR_NG VAR_NH NUTS3_ITA VAR_NUTS3_ITA VAR_N6 VAR_N7 VAR_N8 VAR_N9 VAR_NA VAR_NB VAR_NUTS3TEXT_ITA VAR_N0 VAR_N1 VAR_N2 VAR_N3 VAR_N4 VAR_N5 LAU_ITA LAU_I0 LAU_I1 LAU_I2 LAU_I3 LAU_I4 LAU_I5 VAR_LAUCODE_ITA VAR_L0 VAR_L1 VAR_L2 VAR_L3 VAR_L4 VAR_L5 VAR_DEGURBA_ITA VAR_D0 VAR_D1 VAR_D2 VAR_D3 VAR_D4 VAR_D5 ///
ethni_rec A5_98 A5_99 SAMPLE_FLAG DEGURBA 

*q60_G1r1_OE Q60_G4 q60_G1r2_OE q60_G1r3_OE q60_G2r1_OE q60_G2r2_OE Q60_G3 q60_G2r3_OE Q60_G2 q60_G3r1_OE q60_G3r2_OE Q60_G0 Q60_G1 q60_G3r3_OE Weight1 Weight2 
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename Interview_length_min Interview_length

foreach x of varlist ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

recode A5_1 A5_2 (0=2)
rename Weight1 dweight //Not sure, double check

*br income_cur income_time q17 City Region Strata PSU SSU ethni relig paff2 q60_G*

*Checking answers
foreach x of varlist income_cur income_time q17  {
				tab `x'
			}
			
foreach x of varlist City Region Strata PSU SSU ethni relig paff2 {
				tab `x'
			}			
			
foreach x of varlist q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 {
				tab `x'
			}
			
*Checking standarized DK/NA values			
			numlabel, add
			foreach x of varlist q33b q38e q38f q38g_1 q38h_1  {
				tab `x'
			}
			
			tab Income2

*replace q33b=-9999 if q33b==999

replace q38e=-9999 if q38e==9999

replace q38f=-9999 if q38f==9999

*replace q38g_1=-9999 if q38g_1==999

replace q38h_1=-9999 if q38h_1==9999
			
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
replace incpp = 1 if paff2 == "Austrian People's Party" & country=="Austria"
replace incpp = 1 if paff2 == "CD&V" & country=="Belgium"
replace incpp = 1 if paff2 == "Social Democratic Party" & country=="Denmark"
replace incpp = 1 if paff2 == "Social Democratic Party of Germany" & country=="Germany"
replace incpp = 1 if paff2 == "Brothers of Italy" & country=="Italy"
replace incpp = 1 if paff2 == "People's Party for Freedom and Democracy" & country=="Netherlands"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Austrian" & country=="Austria"
replace ethni_groups = 1 if ethni == "Belgian" & country=="Belgium"
replace ethni_groups = 1 if ethni == "Danish" & country=="Denmark"
replace ethni_groups = 1 if ethni == "German" & country=="Germany"
replace ethni_groups = 1 if ethni == "Italian" & country=="Italy"
replace ethni_groups = 1 if ethni == "Dutch" & country=="Netherlands"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 


/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:

1. 44 obs have more than 50 DK/NA values in the target variables.
2. 255 individual(s) have a high incidence of straight-lining (>0.75) - Less than 1%
3. 1030 individual(s) have a high incidence of straight-lining. (>0.6666) - Less than 5%

*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
