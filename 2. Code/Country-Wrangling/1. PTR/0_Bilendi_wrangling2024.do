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

*Austria - regions


g city = .
g region =
g urban = .


g year =2024
g q60_g1_98 = .
g q60_g1_99 = .
g q60_g2_98 = .
g q60_g2_99 = .
g q60_g3_98 = .
g q60_g3_99 = .

g psu = .
g ssu = .
g b1 = .
g b2 = .
g b3 = .
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
g color = .
g dweight = .
g strata = .

/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

*drop id0 id1 record uuid date status sample_flag total_country_sample survey_language intro rec_genquo age_rec incom2 incom3 incom0 incom1 nuts1_aut var_nuts1_aut var_n1y var_n1z var_nuts1text_aut var_n1w var_n1x nuts2_aut var_nuts2_aut var_n1u var_n1v var_nuts2text_aut var_n1s var_n1t nuts3_aut var_nuts3_aut var_n1q var_n1r var_nuts3text_aut var_n1o var_n1p lau_aut lau_a0 lau_a1 var_laucode_aut var_la var_lb var_degurba_aut var_da var_db nuts1_ger var_nuts1_ger var_n1m var_n1n var_nuts1text_ger var_n1k var_n1l nuts2_ger var_nuts2_ger var_n1i var_n1j var_nuts2text_ger var_n1g var_n1h nuts3_ger var_nuts3_ger var_n1e var_n1f var_nuts3text_ger var_n1c var_n1d lau_ger lau_g0 lau_g1 var_laucode_ger var_l8 var_l9 var_degurba_ger var_d8 var_d9 nuts1_nld var_nuts1_nld var_n1a var_n1b var_nuts1text_nld var_n18 var_n19 nuts2_nld var_nuts2_nld var_n16 var_n17 var_nuts2text_nld var_n14 var_n15 nuts3_nld var_nuts3_nld var_n12 var_n13 var_nuts3text_nld var_n10 var_n11 lau_nld lau_n0 lau_n1 var_laucode_nld var_l6 var_l7 var_degurba_nld var_d6 var_d7 nuts1_dnk var_nuts1_dnk var_ny var_nz var_nuts1text_dnk var_nw var_nx nuts2_dnk var_nuts2_dnk var_nu var_nv var_nuts2text_dnk var_ns var_nt nuts3_dnk var_nuts3_dnk var_nq var_nr var_nuts3text_dnk var_no var_np lau_dnk lau_d0 lau_d1 var_laucode_dnk var_l4 var_l5 var_degurba_dnk var_d4 var_d5 nuts1_bel var_nuts1_bel var_nm var_nn var_nuts1text_bel var_nk var_nl nuts2_bel var_nuts2_bel var_ni var_nj var_nuts2text_bel var_ng var_nh nuts3_bel var_nuts3_bel var_ne var_nf var_nuts3text_bel var_nc var_nd lau_bel lau_b0 lau_b1 var_laucode_bel var_l2 var_l3 var_degurba_bel var_d2 var_d3 nuts1_ita var_nuts1_ita var_na var_nb var_nuts1text_ita var_n8 var_n9 nuts2_ita var_nuts2_ita var_n6 var_n7 var_nuts2text_ita var_n4 var_n5 nuts3_ita var_nuts3_ita var_n2 var_n3 var_nuts3text_ita var_n0 var_n1 lau_ita lau_i0 lau_i1 var_laucode_ita var_l0 var_l1 var_degurba_ita var_d0 var_d1 degurba rec_quoq17a1 rec_quoq17a2 rec_quoq17a3 rec_quoq17b1 rec_quoq17b2 rec_quoq17b3 rec_quoq17b4 rec_quoq17c1 rec_quoq17c2 rec_quoq17c3 rec_quoq17c4 rec_quoq17d1 rec_quoq17d2 rec_quoq17d3 rec_quoq17d4 rec_quoq17d5 rec_quoq17d6 rec_quoq17e1 rec_quoq17e2 rec_quoq17e3 rec_quoq17f1 rec_quoq17f2 rec_quoq17g1 rec_quoq17g2 rec_quoq17g3 rec_quoq17h1 rec_quoq17h2 rec_quoq17h3 rec_quoq17i1 rec_quoq17j1 rec_quoq17j2 rec_quoq17j3 rec_quoq17j4 rec_quoq17k1 rec_quoq17k2 rec_quoq17k3 rec_quoq17l1 rec_quoq17l2 rec_quofina1 rec_quofina2 rec_quofina3 rec_quofinb1 rec_quofinb2 rec_quofinb3 rec_quofinb4 rec_quofinc1 rec_quofinc2 rec_quofinc3 rec_quofinc4 rec_quofind1 rec_quofind2 rec_quofind3 rec_quofind4 rec_quofind5 rec_quofind6 rec_quofine1 rec_quofine2 rec_quofine3 rec_quofinf1 rec_quofinf2 rec_quofing1 rec_quofing2 rec_quofing3 rec_quofinh1 rec_quofinh2 rec_quofinh3 rec_quofini1 rec_quofinj1 rec_quofinj2 rec_quofinj3 rec_quofinj4 rec_quofink1 rec_quofink2 rec_quofink3 rec_quofinl1 rec_quofinl2 q170 q171 random_alloc_sec7 random_alloc_sec8 rec_q46 rec_q47 random_alloc_sec9 q60_gg q60_gh q60_ge q60_gf q60_gc q60_gd noanswerq60_g1_r4 noanswerq60_g1_r5 q60_ga q60_gb q60_g8 q60_g9 q60_g6 q60_g7 noanswerq60_g2_r4 noanswerq60_g2_r5 q60_g4 q60_g5 q60_g2 q60_g3 q60_g0 q60_g1 noanswerq60_g3_r4 noanswerq60_g3_r5 ethni_rec a5_98 a5_99 incpp ethni_groups
	
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
