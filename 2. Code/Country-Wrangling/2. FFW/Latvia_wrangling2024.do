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
	Latvia is divided in 43 local government units. However, these are very small. It is also often divided 
	into statistical regions equal to the NUTS 3 division: Kurzeme, Latgale, Pierīga, Rīga, Vidzeme and Zemgale,
	these are the ones used in the Regions variable.
	
	For the purpose of the EU-S project, Latvia is sampled at the NUTS-0 division "LV00"
*/

g nuts_ltn = "Latvija"
g nuts_id  = "LV00"

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/


forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}

/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

drop DEGURBA
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x of varlist City Region PSU ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}

foreach x of varlist Strata SSU {
	tostring `x', replace
}

label define response 1 "Very Confident" 2 "Fairly confident" 3 "Not very confident" 4 "Not at all confident" 98 "Don't know" 99 "No answer"

local variables q44a_G1 q44b_G1 q44c_G1 q44d_G1 q44e_G1 q44f_G1 q44g_G1 q44h_G1 q44i_G1 q44j_G1 q44k_G1

foreach var of local variables {
    label values `var' response
}

label define nation 1 "National [Citizen]" 2 "Foreigner" 98 "Don't know" 99 "No answer"
label values nation nation
*In all the q44a and q44b Don'know is labelled as Don´t know, also it should be in capital letters
* Nation --> Foreigner is labelled as Non Citizen
* Var Paff2 are in Latvian and dweight has a value of 1
/*=================================================================================================================
					Special Cases (Only for FULL FIELDWORK)
=================================================================================================================*/

*--- Vote Intention & Incumbent Political Party:
g incpp = 0
replace incpp = 1 if paff2 == "Jaunā VIENOTĪBA"

* 32% of the people answer Don't know. The labelling is in Latvian

*--- Ethnicity groups:
g ethni_groups = 0
replace ethni_groups = 1 if ethni == "Latvian"


/*=================================================================================================================
					Adjustments from the logic, randomization, and routing checks
=================================================================================================================*/

* Observation 620 answer when they shouldn't cause the guy didn't suffer an act of discrimination

replace q14_1 = . in 620
replace q14_2 = . in 620
replace q14_3 = . in 620
replace q14_4 = . in 620
replace q14_5 = . in 620
replace q14_6 = . in 620
replace q14_7 = . in 620
replace q14_8 = . in 620
replace q14_9 = . in 620
replace q14_10 = . in 620
replace q14_11 = . in 620
replace q14_12 = . in 620
replace q14_98 = . in 620
replace q14_99 = . in 620

* Observation 973 answer mcertificate when the guy shouldn't do it

replace mcertificate = . in 973
* ADD HERE ANY ISSUES OR COMMENTS FOUND DURING THE LOGIC, RANDOMIZATION, AND ROUTING CHECKS THAT NEED TO BE FIXED 


/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

* 18 observation  have more than 50 DK/NA values
* 39 individual(s) have a high difficulty score.


/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
