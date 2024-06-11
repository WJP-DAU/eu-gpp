/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Merge Crafting
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	January, 2024

Description:
Master dofile for the cleaning an wrangling of individual country-year datasets within the EU-S framework.

=================================================================================================================*/

clear
cls

/*=================================================================================================================
					Pre-settings
=================================================================================================================*/

*--- Stata Version
version 15

*--- Required packages:
* NONE

*--- Defining paths to SharePoint & your local Git Repo copy:

*------ (a) Carlos Toruno:
if (inlist("`c(username)'", "ctoruno")) {
	global path2SP "/Users/ctoruno/OneDrive - World Justice Project/EU Subnational"
	global path2GH "/Users/ctoruno/OneDrive - World Justice Project/EU Subnational/EU-S Data"
}

*------ (b) Santiago Pardo:
else if (inlist("`c(username)'", "santiagopardo")) {
	global path2SP "/Users/santiagopardo/OneDrive - World Justice Project/EU Subnational"
	global path2GH "/Users/santiagopardo/Documents/GitHub"
}

*------ (b) Natalia Rodriguez:
else if (inlist("`c(username)'", "nrodriguez")) {
	global path2SP "C:\Users\nrodriguez\OneDrive - World Justice Project\Programmatic\EU Subnational"
	global path2GH "C:\Users\nrodriguez\OneDrive - World Justice Project\Natalia\GitHub"
}

*------ (c) Dalia Habiby:
else if (inlist("`c(username)'", "Dhabiby")) {
	global path2SP "/Users/Dhabiby/World Justice Project/Research - EU Subnational"
	global path2GH "/Users/Dhabiby/Documents/GitHub"
}

*------ (d) Artha Pillai:
else if (inlist("`c(username)'", "apillai")) {
	global path2SP "/Users/apillai/OneDrive - World Justice Project/EU Subnational"
	global path2GH ""
}

*------ (e) Any other user: PLEASE INPUT YOUR PERSONAL PATH TO THE SHAREPOINT DIRECTORY:
else {
	global path2SP "INSERT_PATH_TO_EU_SUBNATIONAL_SHARE_POINT_HERE"
	global path2GH "INSERT_PATH_TO_EU_SUBNATIONAL_SHARE_POINT_HERE"
}

*--- Defining path to Data and DoFiles:
global path2data "${path2SP}/EU-S Data/eu-gpp/1. Data"
global path2dos  "${path2SP}/EU-S Data/eu-gpp/2. Code"

*--- Defining path to DoFiles (for country wrangling):
global path2wr "${path2GH}/eu-gpp/2. Code"


/*=================================================================================================================
					Merging individual datasets
=================================================================================================================*/

cd "${path2data}/2. FFW"
local subdirs : dir . dirs "*", respectcase
local c = 1
foreach country in `subdirs' {
	if !regexm("`country'", "0_") == 1 {
		dis "============"
		dis "`country'"
		dis "============"
		qui cd "${path2data}/2. FFW/`country'/1. Clean Data"
		local target : dir . files "*_clean.dta", respectcase
		foreach td in `target' {
			if (length("`td'") > 0) {
				use "${path2data}/2. FFW/`country'/1. Clean Data/`td'", clear
				 recast str150 relig ethni voteintention
				if (`c' > 1) {
					append using "${path2data}/3. Merge/EU_GPP_2024.dta"
				}
				save "${path2data}/3. Merge/EU_GPP_2024.dta", replace
				local ++c
			}
		}
	}
}


/*=================================================================================================================
					Extra Cleaning
=================================================================================================================*/
sort country_name_ltn nuts_id id
drop NUTS2 agegroup weight_nuts2_1 weight_nuts2_2 weight_nuts2_3 weight_nuts2_4 weight_national ///
	Q60_G4 Q60_G3 Q60_G2 Q60_G0 Q60_G1 Weight2 weight_nuts1_1 weight_nuts1_2 weight_nuts1_3
save "${path2data}/3. Merge/EU_GPP_2024.dta", replace