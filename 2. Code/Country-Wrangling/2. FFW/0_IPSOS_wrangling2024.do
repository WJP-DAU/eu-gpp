/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2024 (COUNTRY - Full Fieldwork)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	April, 2024

Description:
Data wrangling cleaning and harmonization routine for the IPSOS pretest data received on 24/04/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Admin division of countries (Variable REGION):
	-	Czechia is divided into 14 Regions, equivalent to NUTS-3
	-	Estonia (technically) is divided into 14 counties which are very small divisions, but these can be 
		aggregated into 5 regions which are equivalent to the NUTS-3 division (I guess that's fine)
	-	Finland is divided into 19 Regions, equivalent to NUTS-3
	-	France is divided into 13 Regions + Overseas territories, equivalent to NUTS-1
	-	Slovenia is divided into 212 municipalities for admin purposes. However, statistical division is also used
		so a NUTS-3 division should be sufficient.
	-	Spain is divided into 19 regions, equivalent to NUTS-2
	-	Sweden is divided into 21 regions, equivalent to NUTS-3
	
	Some countries have the NUTS levels misplaced!!!!
*/

foreach x of varlist region_nuts* {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

g nuts_ltn = ""
replace nuts_ltn = region_nuts1 if country == 1	// Czechia
replace nuts_ltn = region_nuts1 if country == 2	// Estonia
replace nuts_ltn = region_nuts1 if country == 3	// Finland
replace nuts_ltn = region_nuts1 if country == 4	// France
replace nuts_ltn = region_nuts1 if country == 5	// Slovenia
replace nuts_ltn = region_nuts1 if country == 6	// Spain
replace nuts_ltn = region_nuts1 if country == 7	// Sweden
encode nuts_ltn, g(nuts_id)

#delim ;
label define nuts_id
	/* Czechia */
	28 "CZ01" 32 "CZ02" 17 "CZ03" 31 "CZ04" 30 "CZ05" 16 "CZ06" 33 "CZ07" 19 "CZ08"
	
	/* Estonia */
	9 "EE0"
	
	/* Finland */
	18 "FI19" 14 "FI1B" 11 "FI1C" 27 "FI1D"
	
	/* France */
	15 "FR1" 5 "FRB" 2 "FRC" 21 "FRD" 13 "FRE" 12 "FRF" 26 "FRG" 3 "FRH" 24 "FRI" 25 "FRJ" 1 "FRK" 29 "FRL" 8 "FRM"

	/* Slovenia */
	36 "SI03" 37 "SI04"
	
	/* Spain */
	22 "ES1" 20 "ES2" 7 "ES3" 6 "ES4" 10 "ES5" 34 "ES6" 4 "ES7"
	
	/* Sweden */
	38 "SE1" 35 "SE2" 23 "SE1"
	
	, replace
;
#delim cr

g Region = ""
replace Region = region_nuts3 if country == 1	// Czechia
replace Region = region_nuts3 if country == 2	// Estonia
replace Region = region_nuts3 if country == 3	// Finland
replace Region = region_nuts1 if country == 4	// France
replace Region = region_nuts3 if country == 5	// Slovenia
replace Region = region_nuts2 if country == 6	// Spain
replace Region = region_nuts3 if country == 7	// Sweden


/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/
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


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop Age2 quota_q39 ///
	consent_relig consent_ethni consent_disability consent_politics Income2_check ///
	region_nuts3 region_nuts2 region_nuts1
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

rename weight dweight

rename Urban degurba
recode degurba (1 = 2)(2/3 = 1), g(Urban)
drop degurba

*--- Standardizing the DK/NA values
label define labels340 999 "No answer", modify
label define labels338 99  "No answer", modify
label define labels355 99  "No answer", modify

*--- Converting variablkes to string
foreach x of varlist nuts_id country ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

*--- Filling DK/NA into q60
foreach x of varlist q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 {
	rename `x'_99 `x'_99_aux
	decode `x'_99_aux, g(`x'_99)
	drop `x'_99_aux
	
	replace `x' = `x'_99 if `x'_99 != ""
	drop `x'_99
}

*--- Spliting income quintiles
rename income inc_sample
bys country: egen min_income_country = min(inc_sample)
g income = inc_sample - min_income_country + 1 if inc_sample < 98
decode inc_sample, g(income_text)
drop inc_sample min_income_country

/* Notes:
	1. Values for q60 are not in English!!
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0 if paff2 != "No answer"
replace incpp = 1 if country == "Czechia"  & paff2 == "ODS"
replace incpp = 1 if country == "Estonia"  & paff2 == "Eesti Reformierakond"
replace incpp = 1 if country == "Finland"  & paff2 == "Kansallinen Kokoomus (KOK)"
replace incpp = 1 if country == "France"   & paff2 == "Renaissance (ex La République En Marche)"
replace incpp = 1 if country == "Slovenia" & paff2 == "GIBANJE SVOBODA"
replace incpp = 1 if country == "Spain"    & paff2 == "PSOE"
replace incpp = 1 if country == "Sweden"   & paff2 == "Moderaterna"

*--- Ethnicity groups:
g ethni_groups = 0 if ethni != "No answer"
replace ethni_groups = 1 if country == "Czechia"  & paff2 == "Czech"
replace ethni_groups = 1 if country == "Estonia"  & paff2 == "Estonian"
replace ethni_groups = 1 if country == "Finland"  & paff2 == "Finnish-speaking Finnish"
replace ethni_groups = 1 if country == "France"   & paff2 == "French"
replace ethni_groups = 1 if country == "Slovenia" & paff2 == "Slovene"
replace ethni_groups = 1 if country == "Spain"    & paff2 == "Spanish"
replace ethni_groups = 1 if country == "Sweden"   & paff2 == "Swedish"

/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 


/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	a. 85 obs have more than 50 DK/NA values in the target variables (<1% of total sample)
	b. 43 individual(s) have a high incidence of straight-lining (<1% of total sample)
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
