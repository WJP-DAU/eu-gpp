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



rename *, lower
decode region, g(nuts_ltn)
g nuts_id = ""
replace nuts_id = "SK01" if region == 1
replace nuts_id = "SK02" if region == 2
replace nuts_id = "SK03" if region == 3
replace nuts_id = "SK04" if region == 4

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

/* Note:
	Online polls will be missing the following variables (just uncomment): */
	
	forvalues j = 1/3 {
		g q60_G`j'_98 = ""
		g q60_G`j'_99 = ""
	}
	g City = ""
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

/* drop age2 quota_group ///
	q60_G1_1_99 q60_G1_2_99 q60_G1_3_99 q60_G2_1_99 q60_G2_2_99 q60_G2_3_99 q60_G3_1_99 q60_G3_2_99 q60_G3_3_99 ///
	consent_relig consent_ethni consent_disability consent_politics Income2_check */

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/


/* Notes:
	No non-binary or do not recognize yourself responses.
	
	Fix wrong capitalization:
*/
		rename region Region
		rename income2 Income2
			
/*			
		Decode categorical variables: */
			foreach x of varlist relig ethni paff2 Region  {
				rename `x' `x'_aux
				decode `x'_aux, g(`x')
				drop `x'_aux
			}
			
	/*	Remove "nationality" from the ethnicity labels */
	gen ethni_new = subinstr(ethni, " nationality", "", .)
	drop ethni
	rename ethni_new ethni
	
	/* Code DKNA */
	
	label define DKNA -8888 "Don't know" -9999 "No answer"

	label values q38g_1 DKNA

	label values q33b DKNA

	label values q38e DKNA

	label values q38f DKNA

	label values q38h_1 DKNA

	label values Income2 DKNA

	/* Update income labels with ranges */
label define labels1 1 "<1100 euros/month" 2 "1100 - 1600 euros/month" 3 "1601 - 2000 euros/month" 4 "2001 - 2400 euros/month" 5 ">2400 euros/month", modify 
	
/*	
		
				
	7. Check the dweight -- note: no dweight, several other weights instead (ask TO about this)
	
*/

/* Correct caps for G1/G2 */
foreach var of varlist q39* q40* q41* q42* q43* q44* q45* q46* q47* q48* q49* q50* q51* q52* q53* q54* q55* q56* q57* q60* { 
    local newname = subinstr("`var'", "g", "G", .)
    rename `var' `newname'
}

/* Revert the vars that have a lowercase g in them in addition to the capital */
rename q39G_G1 q39g_G1
rename q39G_G2 q39g_G2
rename q43G_G1 q43g_G1
rename q43G_G2 q43g_G2
rename q44G_G1 q44g_G1
rename q44G_G2 q44g_G2

/* Correct caps for A's */
foreach var of varlist a* {
	local newname = subinstr("`var'", "a", "A", .)
	rename `var' `newname'
}

/* Revert age vars */
rename Age age
rename Agegroup agegroup

/* Correct caps for q15 */
foreach var of varlist q15_a* {
	local newname = subinstr("`var'", "a", "A", .)
	rename `var' `newname'
}

foreach var of varlist q15_b* {
	local newname = subinstr("`var'", "b", "B", .)
	rename `var' `newname'
}

foreach var of varlist q15_c* {
	local newname = subinstr("`var'", "c", "C", .)
	rename `var' `newname'
}

foreach var of varlist q15_d* {
	local newname = subinstr("`var'", "d", "D", .)
	rename `var' `newname'
}

foreach var of varlist q15_e* {
	local newname = subinstr("`var'", "e", "E", .)
	rename `var' `newname'
}

foreach var of varlist q15_f* {
	local newname = subinstr("`var'", "f", "F", .)
	rename `var' `newname'
}

foreach var of varlist q15_g* {
	local newname = subinstr("`var'", "g", "G", .)
	rename `var' `newname'
}

foreach var of varlist q15_h* {
	local newname = subinstr("`var'", "h", "H", .)
	rename `var' `newname'
}

foreach var of varlist q15_i* {
	local newname = subinstr("`var'", "i", "I", .)
	rename `var' `newname'
}

foreach var of varlist q15_j* {
	local newname = subinstr("`var'", "j", "J", .)
	rename `var' `newname'
}

foreach var of varlist q15_k* {
	local newname = subinstr("`var'", "k", "K", .)
	rename `var' `newname'
}

foreach var of varlist q15_l* {
	local newname = subinstr("`var'", "l", "L", .)
	rename `var' `newname'
}

/* Correct caps for urban */
rename urban Urban

/* Correct caps for q16 */
foreach var of varlist q16_a* {
	local newname = subinstr("`var'", "a", "A", .)
	rename `var' `newname'
}

foreach var of varlist q16_b* {
	local newname = subinstr("`var'", "b", "B", .)
	rename `var' `newname'
}

foreach var of varlist q16_c* {
	local newname = subinstr("`var'", "c", "C", .)
	rename `var' `newname'
}

foreach var of varlist q16_d* {
	local newname = subinstr("`var'", "d", "D", .)
	rename `var' `newname'
}

foreach var of varlist q16_e* {
	local newname = subinstr("`var'", "e", "E", .)
	rename `var' `newname'
}

foreach var of varlist q16_f* {
	local newname = subinstr("`var'", "f", "F", .)
	rename `var' `newname'
}

foreach var of varlist q16_g* {
	local newname = subinstr("`var'", "g", "G", .)
	rename `var' `newname'
}

foreach var of varlist q16_h* {
	local newname = subinstr("`var'", "h", "H", .)
	rename `var' `newname'
}

foreach var of varlist q16_i* {
	local newname = subinstr("`var'", "i", "I", .)
	rename `var' `newname'
}

foreach var of varlist q16_j* {
	local newname = subinstr("`var'", "j", "J", .)
	rename `var' `newname'
}

foreach var of varlist q16_k* {
	local newname = subinstr("`var'", "k", "K", .)
	rename `var' `newname'
}

foreach var of varlist q16_l* {
	local newname = subinstr("`var'", "l", "L", .)
	rename `var' `newname'
}

/* Prevent code from running into an error with interview length, city */
rename interview_length Interview_length
drop City
rename city City

/* Create an empty var for dweight until we get word from TO */
generate dweight = .



/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "Smer"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Slovak"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 


/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/*
54 individual(s) have a high incidence of straight-lining (small relative to total sample of 2200 ~ 2-3%)

227 have >50 DKNA (small relative to total sample of 2200 ~ 10%)

Females overrepresented in DKNA overall (57% of DKNA but 53% of target sample) and high incidence of DKNA (67%) -- I don't think this is too surprising

Lower quintiles (esp 1 & 2) are overrepresented in DKNA (esp high incidence - 31% and 30%)
-- again, not overly concerning
*/


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
