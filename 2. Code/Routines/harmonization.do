/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Harmonization with the Global GPP
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
				Santiago Pardo		(spardo@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:

This dofile performs a set of data transformation routines in order to harmonize the data with the Global
GPP merge data file.

=================================================================================================================*/

/*=================================================================================================================
					Transforming data
=================================================================================================================*/

*--- Dropping variables
drop country_name_off country_code_nuts nuts_ltn nuts_id CP_protest CP_consultation CP_cso ///
	CTZ_accountability_A CTZ_gendereq CTZ_consrights CTZ_laborcond CTZ_envprotect CTZ_euvalues ///
	CTZ_headgovteval CTZ_localgovteval CTZ_accountability_B ethni_groups incpp

*--- Merging DK and NA values
ds, has(type numeric)
foreach x in `r(varlist)' {
	if !inlist("`x'", "id", "age") {
		replace `x' = 99 if `x' == 98
	}
}
foreach x in AJD_adviser AJE_description DIS_exp {
	replace `x'_99 = 1 if `x'_98 == 1 
	drop `x'_98
}

*--- Generating new variables
egen country_year = concat(country_name_ltn year)

*--- Merging variables together


/*=================================================================================================================
					Renaming variables
=================================================================================================================*/

rename country_name_ltn country
rename country_code_iso country_code
rename income_quintile income_aux
rename income_text income
rename TRT_people q1a
rename TRT_govt_local q1b
rename TRT_govt_national q1c
rename TRT_inst_eu EU_q1d
rename TRT_police q1d
rename TRT_prosecutors q1e
rename TRT_pda q1f
rename TRT_judges q1g
rename TRT_media q1i
rename TRT_pparties q1j
rename TRT_parliament EU_q1k
rename ATC_recruitment_public CAR_q2a
rename ATC_brbrequest_public CAR_q2b
rename ATC_brboffer_public CAR_q2c
rename ATC_embezz_priv CAR_q2d
rename ATC_embezz_community CAR_q2e
rename ATC_brbrequest_police CAR_q2f
rename COR_parliament q2a
rename COR_govt_national q2b
rename COR_govt_local q2c
rename COR_judges q2g
rename COR_prosecutors q2e
rename COR_pda q2f
rename COR_police q2d
rename COR_landreg CAR_q6n
rename COR_carreg CAR_q6o
rename COR_pparties CAR_q6q
rename COR_inst_eu EU_q3k
rename ORC_business_culture EU_q4a
rename ORC_pconnections EU_q4b
rename ORC_corimpact EU_q4c
rename ORC_govtefforts EU_q4d
rename ORC_impartial_measures EU_q4e
rename ORC_citizen_fight EU_q4f
rename COR_3year_change EU_q5
rename BRB_permit_A q3a
rename BRB_benefits_A q3b
rename BRB_id_A q3c
rename BRB_school_A q3d
rename BRB_health_A q3e
rename BRB_permit_B q4a
rename BRB_benefits_B q4b
rename BRB_id_B q4c
rename BRB_school_B q4d
rename BRB_health_B q4e
rename IPR_rights EU_q8a
rename IPR_easy2read EU_q8b
rename IPR_easy2find EU_q8c
rename IPR_easy2find_online EU_q8d
rename IRE_govtbudget q7a
rename IRE_govtcontracts q7b
rename IRE_disclosure q7c
rename IRE_campaign EU_q9d
rename SEC_walking q9
rename SEC_home EU_q11
rename SEC_children EU_q12a
rename SEC_women EU_q12b
rename SEC_lgbt EU_q12c
rename SEC_immigrant EU_q12d
rename SEC_race EU_q12e
rename SEC_street EU_q12f
rename SEC_orgcrime EU_q12g
rename SEC_police EU_q12h
rename DIS_sex EU_q13a
rename DIS_age EU_q13b
rename DIS_health EU_q13c
rename DIS_ethni EU_q13d
rename DIS_migration EU_q13e
rename DIS_ses EU_q13f
rename DIS_location EU_q13g
rename DIS_religion EU_q13h
rename DIS_family EU_q13i
rename DIS_gender EU_q13j
rename DIS_politics EU_q13k
rename DIS_exp_1 EU_q14_1
rename DIS_exp_2 EU_q14_2
rename DIS_exp_3 EU_q14_3
rename DIS_exp_4 EU_q14_4
rename DIS_exp_5 EU_q14_5
rename DIS_exp_6 EU_q14_6
rename DIS_exp_7 EU_q14_7
rename DIS_exp_8 EU_q14_8
rename DIS_exp_9 EU_q14_9
rename DIS_exp_10 EU_q14_10
rename DIS_exp_11 EU_q14_11
rename DIS_exp_12 EU_q14_12
rename DIS_exp_99 EU_q14_99
rename AJP_A1_bin q19_A1
rename AJP_A2_bin q19_A2
rename AJP_A3_bin q19_A3
rename AJP_B1_bin q19_B1
rename AJP_B2_bin q19_B2
rename AJP_B3_bin q19_B3
rename AJP_B4_bin q19_B4
rename AJP_C1_bin q19_C1
rename AJP_C2_bin q19_C2
rename AJP_C3_bin q19_C3
rename AJP_C4_bin q19_C4
rename AJP_D1_bin q19_D1
rename AJP_D2_bin q19_D2
rename AJP_D3_bin q19_D3
rename AJP_D4_bin q19_D4
rename AJP_D5_bin q19_D5
rename AJP_D6_bin q19_D6
rename AJP_E1_bin q19_E1
rename AJP_E2_bin q19_E2
rename AJP_E3_bin q19_E3
rename AJP_F1_bin q19_F1
rename AJP_F2_bin q19_F2
rename AJP_G1_bin q19_G1
rename AJP_G2_bin q19_G2
rename AJP_G3_bin q19_G3
rename AJP_H1_bin q19_H1
rename AJP_H2_bin q19_H2
rename AJP_H3_bin q19_H3
rename AJP_I1_bin q19_I1
rename AJP_J1_bin q19_J1
rename AJP_J2_bin q19_J2
rename AJP_J3_bin q19_J3
rename AJP_J4_bin q19_J4
rename AJP_K1_bin q19_K1
rename AJP_K2_bin q19_K2
rename AJP_K3_bin q19_K3
rename AJP_L1_bin q19_L1
rename AJP_L2_bin q19_L2
rename AJP_A1_sev q20_A1
rename AJP_A2_sev q20_A2
rename AJP_A3_sev q20_A3
rename AJP_B1_sev q20_B1
rename AJP_B2_sev q20_B2
rename AJP_B3_sev q20_B3
rename AJP_B4_sev q20_B4
rename AJP_C1_sev q20_C1
rename AJP_C2_sev q20_C2
rename AJP_C3_sev q20_C3
rename AJP_C4_sev q20_C4
rename AJP_D1_sev q20_D1
rename AJP_D2_sev q20_D2
rename AJP_D3_sev q20_D3
rename AJP_D4_sev q20_D4
rename AJP_D5_sev q20_D5
rename AJP_D6_sev q20_D6
rename AJP_E1_sev q20_E1
rename AJP_E2_sev q20_E2
rename AJP_E3_sev q20_E3
rename AJP_F1_sev q20_F1
rename AJP_F2_sev q20_F2
rename AJP_G1_sev q20_G1
rename AJP_G2_sev q20_G2
rename AJP_G3_sev q20_G3
rename AJP_H1_sev q20_H1
rename AJP_H2_sev q20_H2
rename AJP_H3_sev q20_H3
rename AJP_I1_sev q20_I1
rename AJP_J1_sev q20_J1
rename AJP_J2_sev q20_J2
rename AJP_J3_sev q20_J3
rename AJP_J4_sev q20_J4
rename AJP_K1_sev q20_K1
rename AJP_K2_sev q20_K2
rename AJP_K3_sev q20_K3
rename AJP_L1_sev q20_L1
rename AJP_L2_sev q20_L2
rename AJP_problem q21
rename AJD_selfemployment q22a
rename AJD_violence q22b
rename AJD_information q23
rename AJD_inst_advice q24
rename AJD_adviser_1 q25_1
rename AJD_adviser_2 q25_2
rename AJD_adviser_3 q25_3
rename AJD_adviser_4 q25_4
rename AJD_adviser_5 q25_5
rename AJD_adviser_6 q25_6
rename AJD_adviser_7 q25_7
rename AJD_adviser_8 q25_8
rename AJD_adviser_9 q25_9
rename AJD_adviser_99 q25_99
rename AJD_expert_adviser q26
rename AJD_noadvice_reason q27
rename AJR_resolution q28
rename AJR_noresol_reason q29
rename AJR_state_noresol q30
rename AJR_settle_noresol q31
rename AJR_court_bin q32a
rename AJR_court_contact q33a
rename AJR_police_bin q32b
rename AJR_police_contact q33b
rename AJR_office_bin q32c
rename AJR_office_contact q33c
rename AJR_relig_bin q32d
rename AJR_relig_contact q33d
rename AJR_arbitration_bin q32e
rename AJR_arbitration_contact q33e
rename AJR_appeal_bin q32f
rename AJR_appeal_contact q33f
rename AJR_other_bin q32g
rename AJR_other_contact q33g
rename AJR_state_resol q34
rename AJR_settle_resol q35
rename AJR_fair q36a
rename AJR_slow q36b
rename AJR_expensive q36c
rename AJR_outcome q37a
rename AJR_solvingtime q37b
rename AJR_solvingcosts q37c
rename AJR_costdiff q37d
rename AJR_satis_outcome q38
rename AJR_satis_ongoing q39
rename AJE_description_1 q40_1
rename AJE_description_2 q40_2
rename AJE_description_3 q40_3
rename AJE_description_4 q40_4
rename AJE_description_5 q40_5
rename AJE_description_6 q40_6
rename AJE_description_7 q40_7
rename AJE_description_8 EU_q36_8
rename AJE_description_99 q40_99
rename AJE_legalrights q41a
rename AJE_infosource q41b
rename AJE_advice q41c
rename AJE_fairoutcome q41d
rename AJE_health q42a
rename AJE_emotional q42b
rename AJE_income q42c
rename AJE_drugs q42d
rename AJE_offwork_time q42e
rename AJE_income_loss q42f
rename AJE_healthcare q42g
rename AJE_healthcare_visits q42g_1
rename AJE_hospital q42h
rename AJE_hospital_time q42h_1
rename CPA_law_langaval q46b_G1
rename CPA_media_freeop q46c_G1
rename CPA_cleanelec_local q46d_G1
rename CPA_freevote q46e_G1
rename CPA_freepolassoc q46f_G1
rename CPA_partdem_congress q46g_G1
rename CPA_partdem_localgvt q46h_G1
rename CPA_freemedia q46i_G1
rename CPA_cons_cso q46j_G1
rename CPA_cons_citizen EU_q39j_G1
rename CPA_protest q47_G1
rename CPA_consultation EU_q41_G1
rename CPA_cso EU_q42_G1
rename CPB_compl_pservices EU_q39a_G2
rename CPB_compl_officials EU_q39b_G2
rename CPB_freeassoc q46a_G2
rename CPB_unions q46b_G2
rename CPB_freexp q46c_G2
rename CPB_community q46d_G2
rename CPB_freemedia q46e_G2
rename CPB_freexp_cso q46f_G2
rename CPB_freexp_pp q46g_G2
rename CPB_freeassem EU_q39j_G2
rename CPB_protest q47_G2
rename CPB_consultation EU_q41_G2
rename CPB_cso EU_q42_G2
rename LEP_lawacts EU_q43a_G1
rename LEP_investigations EU_q43b_G1
rename LEP_rightsresp EU_q43c_G1
rename LEP_accountability EU_q43d_G1
rename LEP_exforce EU_q43e_G1
rename LEP_bribesreq EU_q43f_G1
rename LEP_bribesacc EU_q43g_G1
rename LEP_accusation EU_q43h_G1
rename LEP_pdaperformance EU_q43i_G1
rename CJP_effective q49a_G1
rename CJP_efficient q49b_G1
rename CJP_access q49c_G1
rename CJP_consistent EXP_q23d_G1
rename CJP_fairpunishment q49e_G1
rename CJP_resprights EXP_q23f_G1
rename CJP_egalitarian q49b_G2
rename CJP_fairtrial q49c_G2
rename CJP_victimsupport q49d_G2
rename CJP_proofburden q49e_G2
rename CJP_saferights EU_q44k_G1
rename CTZ_gendereq_A EU_q45a_G1
rename CTZ_consrights_A EU_q45b_G1
rename CTZ_laborcond_A EU_q45c_G1
rename CTZ_envprotect_A EU_q45d_G1
rename CTZ_euvalues_A EU_q45e_G1
rename CTZ_headgovteval_A CAR_q58_G1
rename CTZ_localgovteval_A EU_q47_G1
rename PAB_censorinfo CAR_q60_G1
rename PAB_censorvoices CAR_q61_G1
rename PAB_blamesoc CAR_q62_G1
rename PAB_blameext CAR_q63_G1
rename PAB_freecourts CAR_q64_G1
rename PAB_overcourts CAR_q65_G1
rename PAB_judgeprom CAR_q66_G1
rename PAB_attackopp CAR_q67_G1
rename PAB_prosecuteopp CAR_q68_G1
rename LEP_safecom EU_q43a_G2
rename LEP_safefam EU_q43b_G2
rename LEP_policehelp EU_q43c_G2
rename LEP_kindpol EU_q43d_G2
rename LEP_indpolinv q48e_G2
rename LEP_indprosecutors q48f_G2
rename LEP_polservpeopl EXP_q22h_G2
rename LEP_polservcom EXP_q22i_G2
rename JSE_rightsaware EU_q44a_G2
rename JSE_access2info EU_q44b_G2
rename JSE_access2assis EU_q44c_G2
rename JSE_affordcosts EU_q44d_G2
rename JSE_quickresol EU_q44e_G2
rename JSE_fairoutcomes EU_q44f_G2
rename JSE_equality EU_q44g_G2
rename JSE_freecorr EU_q44h_G2
rename JSE_polinfluence EU_q44i_G2
rename JSE_indjudges q48g_G2
rename JSE_fairtrial EU_q44k_G2
rename JSE_enforce EU_q44l_G2
rename JSE_mediation EU_q44m_G2
rename CTZ_gendereq_B EU_q45a_G2
rename CTZ_consrights_B EU_q45b_G2
rename CTZ_laborcond_B EU_q45c_G2
rename CTZ_envprotect_B EU_q45d_G2
rename CTZ_euvalues_B EU_q45e_G2
rename CTZ_headgovteval_B CAR_q58_G2
rename CTZ_localgovteval_B EU_q47_G2
rename PAB_misinfo CAR_q60_G2
rename PAB_distract CAR_q61_G2
rename PAB_credibility CAR_q62_G2
rename PAB_centralize CAR_q63_G2
rename PAB_attackmedia CAR_q64_G2
rename PAB_prosecutejourn CAR_q65_G2
rename PAB_emergpower CAR_q66_G2
rename PAB_attackelect CAR_q67_G2
rename PAB_manipulelect CAR_q68_G2
rename CTZ_accountability q43_G2
rename ROL_equality_sig EU_q58a
rename ROL_indcontrols_sig EU_q58b
rename ROL_abusepower_sig EU_q58c
rename ROL_corruption_sig EU_q58d
rename ROL_constprotection_sig EU_q58e
rename ROL_courtrulings_sig EU_q58f
rename ROL_freespeech_sig EU_q58g
rename ROL_indgovtbodies_sig EU_q58h
rename ROL_csoinput_sig EU_q58i
rename ROL_civilobedience_sig EU_q58j
rename ROL_equality_imp EU_q59a
rename ROL_indcontrols_imp EU_q59b
rename ROL_abusepower_imp EU_q59c
rename ROL_corruption_imp EU_q59d
rename ROL_constprotection_imp EU_q59e
rename ROL_courtrulings_imp EU_q59f
rename ROL_freespeech_imp EU_q59g
rename ROL_indgovtbodies_imp EU_q59h
rename ROL_csoinput_imp EU_q59i
rename ROL_civilobedience_imp EU_q59j
rename KNW_rol_1 EU_q60_G1_1
rename KNW_rol_2 EU_q60_G1_2
rename KNW_rol_3 EU_q60_G1_3
rename KNW_justice_1 EU_q60_G2_1
rename KNW_justice_2 EU_q60_G2_2
rename KNW_justice_3 EU_q60_G2_3
rename KNW_governance_1 EU_q60_G3_1
rename KNW_governance_2 EU_q60_G3_2
rename KNW_governance_3 EU_q60_G3_3
rename polid EU_paff1
rename voteintention EU_paff2
rename A4 A5
rename A3 A4
rename A2 A3
rename A5_1 A6_1
rename A5_2 A6_2
rename A5b A6b
rename A5c A6c
rename A6 A9
rename A7 A16
rename income2 Income2
rename interview_length Interview_length
rename region Country_region
rename urban Urban