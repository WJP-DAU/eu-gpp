/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Quality Checks
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:

This dofile performs a set of data transformation routines in order to harmonize the data with the Global
GPP merge data file.

=================================================================================================================*/

/*=================================================================================================================
					Demographic distribution
=================================================================================================================*/

log using "${path2data}/${dataStage}/${country_name}/1. Clean Data/${country_name}_Demographics.log", replace text

recode age (18/24 = 1 "18-24")(25/35 = 2 "25-35")(36/50 = 3 "36-50")(50/max = 4 "+50"), g(age_groups)
tab	nuts_id gend, row miss
tab	nuts_id age_groups, row miss
tab	nuts_id relig, row miss
tab	nuts_id ethni, row miss
tab	nuts_id nation, row miss
tab	nuts_id income_quintile, row miss
tab	nuts_id fin, row miss
tab	nuts_id edu, row miss
tab	nuts_id emp, row miss

log close


/*=================================================================================================================
					DK/NA values
=================================================================================================================*/

*--- Counting DKNA
egen DKNA = anycount(	TRT_* ATC_* COR_* BRB_* IPR_* IRE_* SEC_* DIS_* ///
						AJD_* AJR_* AJE_* ///
						CPA_* CPB_* LEP_* CJP_* CTZ_* PAB_* JSE_* ROL_*), values(98 99)

*--- Overall count
qui inspect DKNA if DKNA > 10
if r(N) > 0 {
	di as error r(N) " obs have more than 10 DK/NA values in the target variables."
}

*--- Disaggregated count
recode DKNA (0/10 = 0 "Low incidence")(11/max = 1 "High Incidence"), g(DKNA_bin)
foreach x of varlist gend age_groups relig ethni income_quintile edu {
	tab DKNA_bin `x', row
}
drop DKNA DKNA_bin age_groups


/*=================================================================================================================
					Answering flags
=================================================================================================================*/

*--- Speeder flag
qui inspect interview_length if interview_length < 25
if r(N) > 0 {
	di as error r(N) " individuals answered the survey in less than 25 minutes."
}

*--- Straight-lining flag (only for Online Surveys)
qui count if method == "Face-to-Face"
if r(N) == 0 {
	g prev_answer = 0
	foreach set in TRT ATC COR ORC IPR IRE CPA CPB LEP CJP PAB JSE ROL {
		replace prev_answer = 0
		g str_count_`set' = 0
		g n_`set' = 0
		local c = 1
		
		foreach x of varlist `set'_* {
			replace n_`set' = n_`set' + 1 if `x' != .
			replace str_count_`set' = str_count_`set' + 1 if `x' == prev_answer & n_`set' > 1 & `x' != .
			replace prev_answer = `x'
			local ++c
		}
		
		g prop_`set' = str_count_`set'/n_`set'
	}
	
	egen avg_prop = rowmean(prop_*)
	tab avg_prop if avg_prop > 0.6666
	qui inspect avg_prop if avg_prop > 0.6666
	if r(N) > 0 {
		di as error r(N) " individual(s) have a high incidence of straight-lining."
	}

	drop prev_answer str_count_* n_* prop_* avg_prop
}

/*=================================================================================================================
					Difficulty Score (only for face-to-face surveys)
=================================================================================================================*/

*--- Normalizing value
recode qpi1 (2=0), g(qpi1_norm)
foreach x of varlist qpi2a qpi2b qpi2c qpi2d qpi2e qpi2f {
	g `x'_norm = ((`x'-1)/2) if `x' < 98
}

qui count if method == "Face-to-Face"
if r(N) > 0 {
	tab qpi1, miss
	tab qpi2a, miss
	tab qpi2b, miss
	tab qpi2c, miss
	tab qpi2d, miss
	tab qpi2e, miss
	tab qpi2f, miss

	egen difficulty_score = rowmean(qpi1_norm qpi2a_norm qpi2b_norm	qpi2c_norm qpi2d_norm qpi2e_norm qpi2f_norm)   

	tab difficulty_score if difficulty_score > 0.5
	qui inspect difficulty_score if difficulty_score > 0.5
	if r(N) > 0 {
		di as error r(N) " individual(s) have a high difficulty score."
	}
}

drop *_norm difficulty_score

