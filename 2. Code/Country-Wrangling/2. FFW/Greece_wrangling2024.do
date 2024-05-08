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


decode Region, g(nuts_ltn)
recode Region (1 = 1 "EL3")(2 = 2 "EL4")(3 = 3 "EL5")(4 = 4 "EL6"), g(nuts_id_aux)
decode nuts_id_aux, g(nuts_id)
drop nuts_id_aux

/* recode AdminRegion (1 = 1 "EL30") (2 = 2 "EL41") (3 = 3 "EL42") (4 = 4 "EL43") ///
	(5 = 5 "EL53") (6 = 6 "EL54") (7 = 7 "EL51") (8 = 8 "EL52") (9 = 9 "EL61") ///
	(10 = 10 "EL64") (11 = 11 "EL63") (12 = 12 "EL62") (13 = 13 "EL65"), g(admin_aux)
	
drop Region

rename admin_aux Region */

drop Region

rename AdminRegion Region



/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

g Strata = ""


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop SPLIT_1 SPLIT_2 SPLIT_3 T_* Record_Consent intid ///
	Prefecture DATE connection* TotaldurationSec AgeGrp LastconnectionStartTime
	
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/


rename q39I_G1 q39i_G1
rename q39J_G1 q39j_G1

foreach x of varlist q39* q40* q41* q42* q43* q44* q45* q46* q47* q48* q49* q50* q51* q52* q53* q54* q55* q56* q57* {
	local newname : subinstr local x "_g" "_G", all
    rename `x' `newname'
}	
foreach x of varlist q39* q40* q41* q42* q43* q44* q45* q46* q47* q48* q49* q50* q51* q52* q53* q54* q55* q56* q57* {
	local newname : subinstr local x "I" "i", all
    rename `x' `newname'
}
foreach x of varlist q39* q40* q41* q42* q43* q44* q45* q46* q47* q48* q49* q50* q51* q52* q53* q54* q55* q56* q57* {
	local newname : subinstr local x "J" "j", all
    rename `x' `newname'
}

foreach x of varlist q39* q40* q41* q42* q43* q44* q45* q46* q47* q48* q49* q50* q51* q52* q53* q54* q55* q56* q57* {
	local newname : subinstr local x "K" "k", all
    rename `x' `newname'
}

rename q44L_G2 q44l_G2
rename q44M_G2 q44m_G2

rename q58I q58i
rename q58J q58j

rename q59I q59i
rename q59J q59j

rename fIn fin

rename wgt dweight

/* Fix caps in No Answer responses */
label define labels342 99 "(DON'T READ) No Answer", modify /* paff2 */
label define labels329 99 "(DON'T READ) No Answer", modify /* ethni */
label define labels328 99 "(DON'T READ) No Answer", modify /* relig */

/* Fix DKNA coding in q32a-c, q33c */
foreach x of varlist q32* q33c {
	recode `x' (1 = 1 "Yes") (2 = 2 "No") (3 = 98 "Don't know") (4 = 99 "No Answer"), g(var_aux)
	drop `x'
	rename var_aux `x'
}

/* Fix misspelling of "disagree" */
foreach x of varlist q37* q39* q43* q44*_G2 q45* q48* q49* q50* q51* q52* q53* q54* q55* q56*  {
	recode `x' (1 = 1 "Strongly Agree") (2 = 2 "Agree") (3 = 3 "Disagree") (4 = 4 "Strongly Disagree") (98 = 98 "Don't know") (99 = 99 "No Answer"), g(x_aux)
	drop `x'
	rename x_aux `x'
}

/* Fix numerical labeling of DK/NA in q44_G1 */
foreach x of varlist q44*_G1 {
	recode `x' (1 = 1 "Very Confident") (2 = 2 "Fairly confident") (3 =3 "Not very confident") (4 = 4 "Not at all confident") (5 = 98 "Don't know") (6 = 99 "No Answer"), g(q44_aux)
	drop `x'
	rename q44_aux `x'	
}

/* Remove the "don't read" */

label dir
foreach lab in `r(names)' {
	label define `lab' 98 "Don't know", modify
	label define `lab' 99 "No Answer", modify
}

/* Recode q57 */
foreach x of varlist q57* {
		recode `x' (1 = 1 "The accusation is completely ignored by the authorities") (2 = 2 "An investigation is opened, but it never reaches any conclusions") (3 = 3 "The high-ranking government officer is prosecuted and punished (through fines, or time in prison)") (98 = 98 "Don't know") (99 = 99 "No answer"), g(q57_aux)
		drop `x'
		rename q57_aux `x'
}

/* Recode emp */
recode emp (1 = 1 "Worked") (2 = 2 "Had work, but did not work") (3 = 3 "Looked for work") (4 = 4 "Studied") (5 = 5 "Dedicated yourself to household tasks") (6 = 6 "Were retired") (7 = 7 "Were permanently incapable of working") (8 = 8 "Did not work") (98 = 98 "Don't know") (99 = 99 "No answer"), g(emp_aux)
drop emp
rename emp_aux emp


/* Recode work */
recode work (1 = 1 "Government worker") (2 = 2 "Private sector worker") (3 = 3 "Independent professional") (4 = 4 "Self-employed worker") (5 = 5 "Day laborer") (6 = 6 "Businessman or businesswomen") (7 = 7 "Entrepreneur or business owner") (8 = 8 "Unpaid worker") (98 = 98 "Don't know") (99 = 99 "No answer"), g(work_aux)
drop work
rename work_aux work

/* Fix national label */
recode nation (1 = 1 "National [Citizen]") (2 = 2 "Foreigner") (98 = 98 "Don't know") (99 = 99 "No answer"), g(nation_aux)
drop nation
rename nation_aux nation
		
/* Recode Income2 */
recode Income2 (98 = -8888 "Don't know") (99 = -9999 "No Answer"), g(income2_aux)
drop Income2
rename income2_aux Income2

/* Decoding */
foreach x of varlist income_cur income_time q17 City Region PSU ethni relig paff2 {
			rename `x' `x'_aux
			decode `x'_aux, g(`x')
			drop `x'_aux
		}
		
/* Create q60_98/99's to avoid code errors */
forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}

replace q17 = "A1" if q17 == "Problems related to poor or incomplete professional services (for example, services from a lawyer, builder, mechanic, et"

replace q17 = "A2" if q17 == "Problems related to obtaining a refund for faulty or damaged goods"

replace q17 = "A3" if q17 == "Major disruptions in the supply of utilities (e.g., water, electricity, phone) or incorrect billing"

replace q17 = "B1" if q17 == "Problems obtaining land titles, property titles, or permission for building projects for your own home"

replace q17 = "B2" if q17 == "Problems related to squatting and land grabbing"

replace q17 = "B3" if q17 == "Problems with your neighbors over boundaries or the right to pass through property, fences, or trees"

replace q17 = "B4" if q17 == "Problems with co-owners or community members over selling property"

replace q17 = "C1" if q17 == "Problems with a landlord about rental agreements, payments, repairs, deposits, or eviction"

replace q17 = "C2" if q17 == "Problems with a tenant about rental agreements or property damage"

replace q17 = "C3" if q17 == "Problems with your neighbors over noise, litter, parking spots, or pets"

replace q17 = "C4" if q17 == "Becoming homeless"

replace q17 = "D1" if q17 == "Divorce or separation"

replace q17 = "D2" if q17 == "Difficulties obtaining child support payments"

replace q17 = "D3" if q17 == "Difficulties paying child support"

replace q17 = "D4" if q17 == "Dispute over child custody or visitation arrangements"

replace q17 = "D5" if q17 == "Threats or physical violence from a current partner, ex-partner, or other household member"

replace q17 = "D6" if q17 == "Disagreement over the content of a will or the division of property after the death of a family member"

replace q17 = "E1" if q17 == "Difficulties obtaining a place at a school or other educational institution that you or your children are eligible to at"

replace q17 = "E2" if q17 == "You or your children being bullied or harassed at school or another educational institution"

replace q17 = "E3" if q17 == "Problems with gangs, vandalism, or consumption of drugs or alcohol on the streets"

replace q17 = "F1" if q17 == "Injuries or health problems sustained as a result of an accident or due to poor working conditions"

replace q17 = "F2" if q17 == "Injuries or health problems sustained as a result of negligent or wrong medical or dental treatment"

replace q17 = "G1" if q17 == "Being dismissed from a job unfairly"

replace q17 = "G2" if q17 == "Difficulties obtaining wages or employment benefits that were agreed on in advance"

replace q17 = "G3" if q17 == "Harassment at work"

replace q17 = "H1" if q17 == "Difficulties obtaining public benefits or government assistance, such as cash transfers, pensions, or disability benefit"

replace q17 = "H2" if q17 == "Difficulties accessing care in public clinics or hospitals"

replace q17 = "H3" if q17 == "Lack of access to water, sanitation, and/or electricity"

replace q17 = "I1" if q17 == "Being beaten up or arrested without justification by a member of the police or the military."

replace q17 = "J1" if q17 == "Difficulties obtaining birth certificates for you or your children"

replace q17 = "J2" if q17 == "Difficulties obtaining a government-issued ID card"

/* replace q17 = "J3" if q17 == "Problems with you or your children's citizenship, residency, or immigration status" */

replace q17 = "J3" in 1031

replace q17 = "J3" in 172

replace q17 = "J4" if q17 == "Tax disputes or disputes with other government bodies"

replace q17 = "K1" if q17 == "Being behind on and unable to pay credit cards, utility bills (e.g., water, electricity, gas), or a loan"

replace q17 = "K2" if q17 == "Being threatened by debt collectors over unpaid loans or bills"

replace q17 = "K3" if q17 == "Being threatened, harassed, or extorted by a mob, a gang or another criminal organization."

replace q17 = "L1" if q17 == "Difficulties collecting money owed to you"

replace q17 = "L2" if q17 == "Insurance claims being denied"


	// q17 is supposed to be a string variable with the problem codes
	
destring Interview_length, replace

gen SSU_str = string(SSU)
drop SSU
rename SSU_str SSU


		
/* Allison's notes:
- City needs to be in English
- A5 got weird - instead of yes/no the answer choices are birth certificate or ID card, like the two questions somehow got smushed together -- double-check with D3 that it's just a labeling issue (the numerical options are still 1 and 2, as they should be, but for A5_2, most people responded with choice 2).
*/


/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "NEA DIMOKRATIA"

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Greek"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

/* Obs #7 has AJD_inst_advice = 2 but also AJD_expert_adviser = 2 */
/* Also answered AJD_noadvice_reason and no question in between - safe to drop that answer */
replace q22 = . in 7

/*
Obs #1997 has multiple skip errors:
AJD_inst_advice = 1 but did not see any of the AJD_adviser_* questions.
Then saw AJD_expert_adviser.
Also did not see the discrimination experience questions despite answering Yes to q13b.
Simplest solution is to replace AJD_inst_advice with No and to replace all of q14 with NA.
*/
foreach x of varlist q20 q22 q25 q26 {
	replace `x' = . in 1997
}

foreach x of varlist q14* {
	replace `x' = 99 in 1997
}



/* Obs 204 and 982 saw q35 when they should not have, so remove those obs */
replace q35 = . in 204
replace q35 = . in 982

/* Obs 1580 and 1676 saw wagreement when they should not have */
replace wagreement = . in 1580
replace wagreement = . in 1676

/* Obs 361, 741, 1827, 1980 answered No to B2 but gave responses to B3 - change B2 responses to Yes */
replace B2 = 1 in 361
replace B2 = 1 in 741
replace B2 = 1 in 1827
replace B2 = 1 in 1980





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
