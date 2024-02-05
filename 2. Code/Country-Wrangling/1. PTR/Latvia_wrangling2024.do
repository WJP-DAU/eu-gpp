/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (LATVIA - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:
Data wrangling cleaning and harmonization routine for the LATVIA pretest data received on 05/02/2024.

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
g nuts_id  = "nuts_id"

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

// No need to drop variables

	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

replace Income2 = -8888 if Income2 == 9998
replace Income2 = -9999 if Income2 == 9999

foreach x of varlist City Region PSU ethni relig paff2 {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}
foreach x of varlist Strata SSU {
	tostring `x', replace
}

g hours   = hh(Interview_length)
g minutes = mm(Interview_length)
g seconds = ss(Interview_length)
g double Interview_length_aux = (hours*60) + minutes + (seconds/60)
drop Interview_length hours minutes seconds
rename Interview_length_aux Interview_length

/* Note:
	1. Interview_length in in %tc format, I transformed it to minutes. No need to extend this to the 
	polling company.
	2. The value labels for answer "Not so important" in q58x are in Latvian, please provide them in English.
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

*--- Routing issues:
replace q35 = . if q34 != .

/* Note:
	1. Unbalanced groups in CP: 31 answered Option A while only 22 answered Option B.
*/

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 2 obs (4%) have more than 45 DK/NA values in the target variables. IDs = [59, 61]
	2. Unbalanced demographics
	3. q39b_G2, q43e_G1, q43g_G1, q43i_G1, q46_G1, q46_G2, q54_G2, q55_G2, q44e_G2, q44f_G2, and q44m_G2 
	have more than 30% of valid answers as DK/NA.
	4. Individuals with id = [49, 71, 98] ahve a high difficulty score
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
