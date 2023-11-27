/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Variable renaming
Author(s):		Carlos A. Toruño Paniagua
Dependencies:  	World Justice Project
Creation Date:	September, 2023

Description: 
This dofile is used to rename the variables submitted by each individual polling company to fit the naming 
system defined in the EU-S Codebook. in order for this dofile to run, it is important that the submited 
dataset fullfills the structure detailed in the EU-GPP Data Map. If the data submitted by the polling company
does not match the data map, please run the respective Country-Wrangling file before applying this routine.

=================================================================================================================*/


/*=================================================================================================================
					1. Variable renaming
=================================================================================================================*/

rename income income_quintile
rename q1a TRT_people
rename q1b TRT_govt_local
rename q1c TRT_govt_national
rename q1d TRT_inst_eu
rename q1e TRT_police
rename q1f TRT_prosecutors
rename q1g TRT_pda
rename q1h TRT_judges
rename q1i TRT_media
rename q1j TRT_pparties
rename q1k TRT_parliament
rename q2a ATC_recruitment_public
rename q2b ATC_brbrequest_public
rename q2c ATC_brboffer_public
rename q2d ATC_embezz_priv
rename q2e ATC_embezz_community
rename q2f ATC_brbrequest_police
rename q3a COR_parliament
rename q3b COR_govt_national
rename q3c COR_govt_local
rename q3d COR_judges
rename q3e COR_prosecutors
rename q3f COR_pda
rename q3g COR_police
rename q3h COR_landreg
rename q3i COR_carreg
rename q3j COR_pparties
rename q3k COR_inst_eu
rename q4a ORC_business_culture
rename q4b ORC_pconnections
rename q4c ORC_corimpact
rename q4d ORC_govtefforts
rename q4e ORC_impartial_measures
rename q4f ORC_citizen_fight
rename q5  COR_3year_change
rename q6a BRB_permit_A
rename q6b BRB_benefits_A
rename q6c BRB_id_A
rename q6d BRB_school_A
rename q6e BRB_health_A
rename q7a BRB_permit_B
rename q7b BRB_benefits_B
rename q7c BRB_id_B
rename q7d BRB_school_B
rename q7e BRB_health_B
rename q8a IPR_rights
rename q8b IPR_easy2read
rename q8c IPR_easy2find
rename q8d IPR_easy2find_online
rename q9a IRE_govtbudget
rename q9b IRE_govtcontracts
rename q9c IRE_disclosure
rename q9d IRE_campaign
rename q10 SEC_walking
rename q11 SEC_home
rename q12a SEC_children
rename q12b SEC_women
rename q12c SEC_lgbt
rename q12d SEC_immigrant
rename q12e SEC_race
rename q12f SEC_street
rename q12g SEC_orgcrime
rename q12h SEC_police
rename q13a DIS_sex
rename q13b DIS_age
rename q13c DIS_health
rename q13d DIS_ethni
rename q13e DIS_migration
rename q13f DIS_ses
rename q13g DIS_location
rename q13h DIS_religion
rename q13i DIS_family
rename q13j DIS_gender
rename q13k DIS_politics
rename q14_1 DIS_exp_1
rename q14_2 DIS_exp_2
rename q14_3 DIS_exp_3
rename q14_4 DIS_exp_4
rename q14_5 DIS_exp_5
rename q14_6 DIS_exp_6
rename q14_7 DIS_exp_7
rename q14_8 DIS_exp_8
rename q14_9 DIS_exp_9
rename q14_10 DIS_exp_10
rename q14_11 DIS_exp_11
rename q14_12 DIS_exp_12
rename q14_98 DIS_exp_98
rename q14_99 DIS_exp_99
rename q15_A1 AJP_A1_bin
rename q15_A2 AJP_A2_bin
rename q15_A3 AJP_A3_bin
rename q15_B1 AJP_B1_bin
rename q15_B2 AJP_B2_bin
rename q15_B3 AJP_B3_bin
rename q15_B4 AJP_B4_bin
rename q15_C1 AJP_C1_bin
rename q15_C2 AJP_C2_bin
rename q15_C3 AJP_C3_bin
rename q15_C4 AJP_C4_bin
rename q15_D1 AJP_D1_bin
rename q15_D2 AJP_D2_bin
rename q15_D3 AJP_D3_bin
rename q15_D4 AJP_D4_bin
rename q15_D5 AJP_D5_bin
rename q15_D6 AJP_D6_bin
rename q15_E1 AJP_E1_bin
rename q15_E2 AJP_E2_bin
rename q15_E3 AJP_E3_bin
rename q15_F1 AJP_F1_bin
rename q15_F2 AJP_F2_bin
rename q15_G1 AJP_G1_bin
rename q15_G2 AJP_G2_bin
rename q15_G3 AJP_G3_bin
rename q15_H1 AJP_H1_bin
rename q15_H2 AJP_H2_bin
rename q15_H3 AJP_H3_bin
rename q15_I1 AJP_I1_bin
rename q15_J1 AJP_J1_bin
rename q15_J2 AJP_J2_bin
rename q15_J3 AJP_J3_bin
rename q15_J4 AJP_J4_bin
rename q15_K1 AJP_K1_bin
rename q15_K2 AJP_K2_bin
rename q15_K3 AJP_K3_bin
rename q15_L1 AJP_L1_bin
rename q15_L2 AJP_L2_bin
rename q16_A1 AJP_A1_sev
rename q16_A2 AJP_A2_sev
rename q16_A3 AJP_A3_sev
rename q16_B1 AJP_B1_sev
rename q16_B2 AJP_B2_sev
rename q16_B3 AJP_B3_sev
rename q16_B4 AJP_B4_sev
rename q16_C1 AJP_C1_sev
rename q16_C2 AJP_C2_sev
rename q16_C3 AJP_C3_sev
rename q16_C4 AJP_C4_sev
rename q16_D1 AJP_D1_sev
rename q16_D2 AJP_D2_sev
rename q16_D3 AJP_D3_sev
rename q16_D4 AJP_D4_sev
rename q16_D5 AJP_D5_sev
rename q16_D6 AJP_D6_sev
rename q16_E1 AJP_E1_sev
rename q16_E2 AJP_E2_sev
rename q16_E3 AJP_E3_sev
rename q16_F1 AJP_F1_sev
rename q16_F2 AJP_F2_sev
rename q16_G1 AJP_G1_sev
rename q16_G2 AJP_G2_sev
rename q16_G3 AJP_G3_sev
rename q16_H1 AJP_H1_sev
rename q16_H2 AJP_H2_sev
rename q16_H3 AJP_H3_sev
rename q16_I1 AJP_I1_sev
rename q16_J1 AJP_J1_sev
rename q16_J2 AJP_J2_sev
rename q16_J3 AJP_J3_sev
rename q16_J4 AJP_J4_sev
rename q16_K1 AJP_K1_sev
rename q16_K2 AJP_K2_sev
rename q16_K3 AJP_K3_sev
rename q16_L1 AJP_L1_sev
rename q16_L2 AJP_L2_sev
rename q17   AJP_problem
rename q18a  AJD_selfemployment
rename q18b  AJD_violence
rename q19   AJD_information
rename q20   AJD_inst_advice
rename q21_1 AJD_adviser_1
rename q21_2 AJD_adviser_2
rename q21_3 AJD_adviser_3
rename q21_4 AJD_adviser_4
rename q21_5 AJD_adviser_5
rename q21_6 AJD_adviser_6
rename q21_7 AJD_adviser_7
rename q21_8 AJD_adviser_8
rename q21_9 AJD_adviser_9
rename q21_98 AJD_adviser_98
rename q21_99 AJD_adviser_99
rename q22 AJD_expert_adviser
rename q23 AJD_noadvice_reason
rename q24 AJR_resolution
rename q25 AJR_noresol_reason
rename q26 AJR_state_noresol
rename q27 AJR_settle_noresol
rename q28a AJR_court_bin
rename q29a AJR_court_contact
rename q28b AJR_police_bin
rename q29b AJR_police_contact
rename q28c AJR_office_bin
rename q29c AJR_office_contact
rename q28d AJR_relig_bin
rename q29d AJR_relig_contact
rename q28e AJR_arbitration_bin
rename q29e AJR_arbitration_contact
rename q28f AJR_appeal_bin
rename q29f AJR_appeal_contact
rename q28g AJR_other_bin
rename q29g AJR_other_contact
rename q30 AJR_state_resol
rename q31 AJR_settle_resol
rename q32a AJR_fair
rename q32b AJR_slow
rename q32c AJR_expensive
rename q33a AJR_outcome
rename q33b AJR_solvingtime
rename q33c AJR_solvingcosts
rename q33d AJR_costdiff
rename q34 AJR_satis_outcome
rename q35 AJR_satis_ongoing
rename q36_1 AJE_description_1
rename q36_2 AJE_description_2
rename q36_3 AJE_description_3
rename q36_4 AJE_description_4
rename q36_5 AJE_description_5
rename q36_6 AJE_description_6
rename q36_7 AJE_description_7
rename q36_8 AJE_description_8
rename q36_98 AJE_description_98
rename q36_99 AJE_description_99
rename q37a AJE_legalrights
rename q37b AJE_infosource
rename q37c AJE_advice
rename q37d AJE_fairoutcome
rename q38a AJE_health
rename q38b AJE_emotional
rename q38c AJE_income
rename q38d AJE_drugs
rename q38e AJE_offwork_time
rename q38f AJE_income_loss
rename q38g AJE_healthcare
rename q38g_1 AJE_healthcare_visits
rename q38h AJE_hospital
rename q38h_1 AJE_hospital_time
rename q39a_G1 CPA_law_langaval
rename q39b_G1 CPA_media_freeop
rename q39c_G1 CPA_cleanelec_local
rename q39d_G1 CPA_freevote
rename q39e_G1 CPA_freepolassoc
rename q39f_G1 CPA_partdem_congress
rename q39g_G1 CPA_partdem_localgvt
rename q39h_G1 CPA_freemedia
rename q39i_G1 CPA_cons_cso
rename q39j_G1 CPA_cons_citizen
rename q40_G1 CPA_protest
rename q41_G1 CPA_consultation
rename q42_G1 CPA_cso
rename q39a_G2 CPB_compl_pservices
rename q39b_G2 CPB_compl_officials
rename q39c_G2 CPB_freeassoc
rename q39d_G2 CPB_unions
rename q39e_G2 CPB_freexp
rename q39f_G2 CPB_community
rename q39g_G2 CPB_freemedia
rename q39h_G2 CPB_freexp_cso
rename q39i_G2 CPB_freexp_pp
rename q39j_G2 CPB_freeassem
rename q40_G2 CPB_protest
rename q41_G2 CPB_consultation
rename q42_G2 CPB_cso
rename q43a_G1 LEP_lawacts
rename q43b_G1 LEP_investigations
rename q43c_G1 LEP_rightsresp
rename q43d_G1 LEP_accountability
rename q43e_G1 LEP_exforce
rename q43f_G1 LEP_bribesreq
rename q43g_G1 LEP_bribesacc
rename q43h_G1 LEP_accusation
rename q43i_G1 LEP_pdaperformance
rename q44a_G1 CJP_effective
rename q44b_G1 CJP_efficient
rename q44c_G1 CJP_access
rename q44d_G1 CJP_consistent
rename q44e_G1 CJP_fairpunishment
rename q44f_G1 CJP_resprights
rename q44g_G1 CJP_egalitarian
rename q44h_G1 CJP_fairtrial
rename q44i_G1 CJP_victimsupport
rename q44j_G1 CJP_proofburden
rename q44k_G1 CJP_saferights
rename q45a_G1 CTZ_gendereq_A
rename q45b_G1 CTZ_consrights_A
rename q45c_G1 CTZ_laborcond_A
rename q45d_G1 CTZ_envprotect_A
rename q45e_G1 CTZ_euvalues_A
rename q46_G1 CTZ_headgovteval_A
rename q47_G1 CTZ_localgovteval_A
rename q48_G1 PAB_censorinfo
rename q49_G1 PAB_censorvoices
rename q50_G1 PAB_blamesoc
rename q51_G1 PAB_blameext
rename q52_G1 PAB_freecourts
rename q53_G1 PAB_overcourts
rename q54_G1 PAB_judgeprom
rename q55_G1 PAB_attackopp
rename q56_G1 PAB_prosecuteopp
rename q57_G1 CTZ_accountability_A
rename q43a_G2 LEP_safecom
rename q43b_G2 LEP_safefam
rename q43c_G2 LEP_policehelp
rename q43d_G2 LEP_kindpol
rename q43e_G2 LEP_indpolinv
rename q43f_G2 LEP_indprosecutors
rename q43g_G2 LEP_polservpeopl
rename q43h_G2 LEP_polservcom
rename q44a_G2 JSE_rightsaware
rename q44b_G2 JSE_access2info
rename q44c_G2 JSE_access2assis
rename q44d_G2 JSE_affordcosts
rename q44e_G2 JSE_quickresol
rename q44f_G2 JSE_fairoutcomes
rename q44g_G2 JSE_equality
rename q44h_G2 JSE_freecorr
rename q44i_G2 JSE_polinfluence
rename q44j_G2 JSE_indjudges
rename q44k_G2 JSE_fairtrial
rename q44l_G2 JSE_enforce
rename q44m_G2 JSE_mediation
rename q45a_G2 CTZ_gendereq_B
rename q45b_G2 CTZ_consrights_B
rename q45c_G2 CTZ_laborcond_B
rename q45d_G2 CTZ_envprotect_B
rename q45e_G2 CTZ_euvalues_B
rename q46_G2 CTZ_headgovteval_B
rename q47_G2 CTZ_localgovteval_B
rename q48_G2 PAB_misinfo
rename q49_G2 PAB_distract
rename q50_G2 PAB_credibility
rename q51_G2 PAB_centralize
rename q52_G2 PAB_attackmedia
rename q53_G2 PAB_prosecutejourn
rename q54_G2 PAB_emergpower
rename q55_G2 PAB_attackelect
rename q56_G2 PAB_manipulelect
rename q57_G2 CTZ_accountability_B
rename q58a ROL_equality_sig
rename q58b ROL_indcontrols_sig
rename q58c ROL_abusepower_sig
rename q58d ROL_corruption_sig
rename q58e ROL_constprotection_sig
rename q58f ROL_courtrulings_sig
rename q58g ROL_freespeech_sig
rename q58h ROL_indgovtbodies_sig
rename q58i ROL_csoinput_sig
rename q58j ROL_civilobedience_sig
rename q59a ROL_equality_imp
rename q59b ROL_indcontrols_imp
rename q59c ROL_abusepower_imp
rename q59d ROL_corruption_imp
rename q59e ROL_constprotection_imp
rename q59f ROL_courtrulings_imp
rename q59g ROL_freespeech_imp
rename q59h ROL_indgovtbodies_imp
rename q59i ROL_csoinput_imp
rename q59j ROL_civilobedience_imp
rename q60_G1_1  KNW_rol_1
rename q60_G1_2  KNW_rol_2
rename q60_G1_3  KNW_rol_3
rename q60_G1_98 KNW_rol_98
rename q60_G1_99 KNW_rol_99
rename q60_G2_1  KNW_justice_1
rename q60_G2_2  KNW_justice_2
rename q60_G2_3  KNW_justice_3
rename q60_G2_98 KNW_justice_98
rename q60_G2_99 KNW_justice_99
rename q60_G3_1  KNW_governance_1
rename q60_G3_2  KNW_governance_2
rename q60_G3_3  KNW_governance_3
rename q60_G3_98 KNW_governance_98
rename q60_G3_99 KNW_governance_99
rename paff1 polid
rename paff2 voteintention
rename Income2 income2
rename Interview_length interview_length
rename City city
rename Region region
rename Urban urban

/*=================================================================================================================
					2. Variable labeling
=================================================================================================================*/

label var country_year_id "Transformed variable"
label var country_name_ltn "country"
label var country_name_off "Transformed variable"
label var country_code_nuts "Transformed variable"
label var country_code_iso "Transformed variable"
label var nuts_ltn "Transformed variable"
label var nuts_id "Transformed variable"
label var year "year"
label var method "Transformed variable"
label var income_group "Transformed variable"
label var id "id"
label var gend "gend"
label var age "age"
label var income_quintile "income"
label var income_cur "income_cur"
label var income_time "income_time"
label var TRT_people "q1a"
label var TRT_govt_local "q1b"
label var TRT_govt_national "q1c"
label var TRT_inst_eu "q1d"
label var TRT_police "q1e"
label var TRT_prosecutors "q1f"
label var TRT_pda "q1g"
label var TRT_judges "q1h"
label var TRT_media "q1i"
label var TRT_pparties "q1j"
label var TRT_parliament "q1k"
label var ATC_recruitment_public "q2a"
label var ATC_brbrequest_public "q2b"
label var ATC_brboffer_public "q2c"
label var ATC_embezz_priv "q2d"
label var ATC_embezz_community "q2e "
label var ATC_brbrequest_police "q2f "
label var COR_parliament "q3a"
label var COR_govt_national "q3b"
label var COR_govt_local "q3c"
label var COR_judges "q3d"
label var COR_prosecutors "q3e"
label var COR_pda "q3f"
label var COR_police "q3g"
label var COR_landreg "q3h"
label var COR_carreg "q3i"
label var COR_pparties "q3j"
label var COR_inst_eu "q3k"
label var ORC_business_culture "q4a"
label var ORC_pconnections "q4b"
label var ORC_corimpact "q4c"
label var ORC_govtefforts "q4d"
label var ORC_impartial_measures "q4e"
label var ORC_citizen_fight "q4f"
label var COR_3year_change "q5"
label var BRB_permit_A "q6a"
label var BRB_benefits_A "q6b"
label var BRB_id_A "q6c"
label var BRB_school_A "q6d"
label var BRB_health_A "q6e"
label var BRB_permit_B "q7a"
label var BRB_benefits_B "q7b"
label var BRB_id_B "q7c"
label var BRB_school_B "q7d"
label var BRB_health_B "q7e"
label var IPR_rights "q8a"
label var IPR_easy2read "q8b"
label var IPR_easy2find "q8c"
label var IPR_easy2find_online "q8d"
label var IRE_govtbudget "q9a"
label var IRE_govtcontracts "q9b"
label var IRE_disclosure "q9c"
label var IRE_campaign "q9d"
label var SEC_walking "q10"
label var SEC_home "q11"
label var SEC_children "q12a"
label var SEC_women "q12b"
label var SEC_lgbt "q12c"
label var SEC_immigrant "q12d"
label var SEC_race "q12e"
label var SEC_street "q12f"
label var SEC_orgcrime "q12g"
label var SEC_police "q12h"
label var DIS_sex "q13a"
label var DIS_age "q13b"
label var DIS_health "q13c"
label var DIS_ethni "q13d"
label var DIS_migration "q13e"
label var DIS_ses "q13f"
label var DIS_location "q13g"
label var DIS_religion "q13h"
label var DIS_family "q13i"
label var DIS_gender "q13j"
label var DIS_politics "q13k"
label var DIS_exp_1 "q14_1"
label var DIS_exp_2 "q14_2"
label var DIS_exp_3 "q14_3"
label var DIS_exp_4 "q14_4"
label var DIS_exp_5 "q14_5"
label var DIS_exp_6 "q14_6"
label var DIS_exp_7 "q14_7"
label var DIS_exp_8 "q14_8"
label var DIS_exp_9 "q14_9"
label var DIS_exp_10 "q14_10"
label var DIS_exp_11 "q14_11"
label var DIS_exp_12 "q14_12"
label var DIS_exp_98 "q14_98"
label var DIS_exp_99 "q14_99"
label var AJP_A1_bin "q15_A1"
label var AJP_A2_bin "q15_A2"
label var AJP_A3_bin "q15_A3"
label var AJP_B1_bin "q15_B1"
label var AJP_B2_bin "q15_B2"
label var AJP_B3_bin "q15_B3"
label var AJP_B4_bin "q15_B4"
label var AJP_C1_bin "q15_C1"
label var AJP_C2_bin "q15_C2"
label var AJP_C3_bin "q15_C3"
label var AJP_C4_bin "q15_C4"
label var AJP_D1_bin "q15_D1"
label var AJP_D2_bin "q15_D2"
label var AJP_D3_bin "q15_D3"
label var AJP_D4_bin "q15_D4"
label var AJP_D5_bin "q15_D5"
label var AJP_D6_bin "q15_D6"
label var AJP_E1_bin "q15_E1"
label var AJP_E2_bin "q15_E2"
label var AJP_E3_bin "q15_E3"
label var AJP_F1_bin "q15_F1"
label var AJP_F2_bin "q15_F2"
label var AJP_G1_bin "q15_G1"
label var AJP_G2_bin "q15_G2"
label var AJP_G3_bin "q15_G3"
label var AJP_H1_bin "q15_H1"
label var AJP_H2_bin "q15_H2"
label var AJP_H3_bin "q15_H3"
label var AJP_I1_bin "q15_I1"
label var AJP_J1_bin "q15_J1"
label var AJP_J2_bin "q15_J2"
label var AJP_J3_bin "q15_J3"
label var AJP_J4_bin "q15_J4"
label var AJP_K1_bin "q15_K1"
label var AJP_K2_bin "q15_K2"
label var AJP_K3_bin "q15_K3"
label var AJP_L1_bin "q15_L1"
label var AJP_L2_bin "q15_L2"
label var AJP_A1_sev "q16_A1"
label var AJP_A2_sev "q16_A2"
label var AJP_A3_sev "q16_A3"
label var AJP_B1_sev "q16_B1"
label var AJP_B2_sev "q16_B2"
label var AJP_B3_sev "q16_B3"
label var AJP_B4_sev "q16_B4"
label var AJP_C1_sev "q16_C1"
label var AJP_C2_sev "q16_C2"
label var AJP_C3_sev "q16_C3"
label var AJP_C4_sev "q16_C4"
label var AJP_D1_sev "q16_D1"
label var AJP_D2_sev "q16_D2"
label var AJP_D3_sev "q16_D3"
label var AJP_D4_sev "q16_D4"
label var AJP_D5_sev "q16_D5"
label var AJP_D6_sev "q16_D6"
label var AJP_E1_sev "q16_E1"
label var AJP_E2_sev "q16_E2"
label var AJP_E3_sev "q16_E3"
label var AJP_F1_sev "q16_F1"
label var AJP_F2_sev "q16_F2"
label var AJP_G1_sev "q16_G1"
label var AJP_G2_sev "q16_G2"
label var AJP_G3_sev "q16_G3"
label var AJP_H1_sev "q16_H1"
label var AJP_H2_sev "q16_H2"
label var AJP_H3_sev "q16_H3"
label var AJP_I1_sev "q16_I1"
label var AJP_J1_sev "q16_J1"
label var AJP_J2_sev "q16_J2"
label var AJP_J3_sev "q16_J3"
label var AJP_J4_sev "q16_J4"
label var AJP_K1_sev "q16_K1"
label var AJP_K2_sev "q16_K2"
label var AJP_K3_sev "q16_K3"
label var AJP_L1_sev "q16_L1"
label var AJP_L2_sev "q16_L2"
label var AJP_problem "q17"
label var AJD_selfemployment "q18a"
label var AJD_violence "q18b"
label var AJD_information "q19"
label var AJD_inst_advice "q20"
label var AJD_adviser_1 "q21_1"
label var AJD_adviser_2 "q21_2"
label var AJD_adviser_3 "q21_3"
label var AJD_adviser_4 "q21_4"
label var AJD_adviser_5 "q21_5"
label var AJD_adviser_6 "q21_6"
label var AJD_adviser_7 "q21_7"
label var AJD_adviser_8 "q21_8"
label var AJD_adviser_9 "q21_9"
label var AJD_adviser_98 "q21_98"
label var AJD_adviser_99 "q21_99"
label var AJD_expert_adviser "q22"
label var AJD_noadvice_reason "q23"
label var AJR_resolution "q24"
label var AJR_noresol_reason "q25"
label var AJR_state_noresol "q26"
label var AJR_settle_noresol "q27"
label var AJR_court_bin "q28a"
label var AJR_court_contact "q29a"
label var AJR_police_bin "q28b"
label var AJR_police_contact "q29b"
label var AJR_office_bin "q28c"
label var AJR_office_contact "q29c"
label var AJR_relig_bin "q28d"
label var AJR_relig_contact "q29d"
label var AJR_arbitration_bin "q28e"
label var AJR_arbitration_contact "q29e"
label var AJR_appeal_bin "q28f"
label var AJR_appeal_contact "q29f"
label var AJR_other_bin "q28g"
label var AJR_other_contact "q29g"
label var AJR_state_resol "q30"
label var AJR_settle_resol "q31"
label var AJR_fair "q32a"
label var AJR_slow "q32b"
label var AJR_expensive "q32c"
label var AJR_outcome "q33a"
label var AJR_solvingtime "q33b"
label var AJR_solvingcosts "q33c"
label var AJR_costdiff "q33d"
label var AJR_satis_outcome "q34"
label var AJR_satis_ongoing "q35"
label var AJE_description_1 "q36_1"
label var AJE_description_2 "q36_2"
label var AJE_description_3 "q36_3"
label var AJE_description_4 "q36_4"
label var AJE_description_5 "q36_5"
label var AJE_description_6 "q36_6"
label var AJE_description_7 "q36_7"
label var AJE_description_8 "q36_8"
label var AJE_description_98 "q36_98"
label var AJE_description_99 "q36_99"
label var AJE_legalrights "q37a"
label var AJE_infosource "q37b"
label var AJE_advice "q37c"
label var AJE_fairoutcome "q37d"
label var AJE_health "q38a"
label var AJE_emotional "q38b"
label var AJE_income "q38c"
label var AJE_drugs "q38d"
label var AJE_offwork_time "q38e"
label var AJE_income_loss "q38f"
label var AJE_healthcare "q38g"
label var AJE_healthcare_visits "q38g_1"
label var AJE_hospital "q38h"
label var AJE_hospital_time "q38h_1"
label var CPA_law_langaval "q39a_G1"
label var CPA_media_freeop "q39b_G1"
label var CPA_cleanelec_local "q39c_G1"
label var CPA_freevote "q39d_G1"
label var CPA_freepolassoc "q39e_G1"
label var CPA_partdem_congress "q39f_G1"
label var CPA_partdem_localgvt "q39g_G1"
label var CPA_freemedia "q39h_G1"
label var CPA_cons_cso "q39i_G1"
label var CPA_cons_citizen "q39j_G1"
label var CPA_protest "q40_G1"
label var CPA_consultation "q41_G1"
label var CPA_cso "q42_G1"
label var CPB_compl_pservices "q39a_G2"
label var CPB_compl_officials "q39b_G2"
label var CPB_freeassoc "q39c_G2"
label var CPB_unions "q39d_G2"
label var CPB_freexp "q39e_G2"
label var CPB_community "q39f_G2"
label var CPB_freemedia "q39g_G2"
label var CPB_freexp_cso "q39h_G2"
label var CPB_freexp_pp "q39i_G2"
label var CPB_freeassem "q39j_G2"
label var CPB_protest "q40_G2"
label var CPB_consultation "q41_G2"
label var CPB_cso "q42_G2"
label var LEP_lawacts "q43a_G1"
label var LEP_investigations "q43b_G1"
label var LEP_rightsresp "q43c_G1"
label var LEP_accountability "q43d_G1"
label var LEP_exforce "q43e_G1"
label var LEP_bribesreq "q43f_G1"
label var LEP_bribesacc "q43g_G1"
label var LEP_accusation "q43h_G1"
label var LEP_pdaperformance "q43i_G1"
label var CJP_effective "q44a_G1"
label var CJP_efficient "q44b_G1"
label var CJP_access "q44c_G1"
label var CJP_consistent "q44d_G1"
label var CJP_fairpunishment "q44e_G1"
label var CJP_resprights "q44f_G1"
label var CJP_egalitarian "q44g_G1"
label var CJP_fairtrial "q44h_G1"
label var CJP_victimsupport "q44i_G1"
label var CJP_proofburden "q44j_G1"
label var CJP_saferights "q44k_G1"
label var CTZ_gendereq_A "q45a_G1"
label var CTZ_consrights_A "q45b_G1"
label var CTZ_laborcond_A "q45c_G1"
label var CTZ_envprotect_A "q45d_G1"
label var CTZ_euvalues_A "q45e_G1"
label var CTZ_headgovteval_A "q46_G1"
label var CTZ_localgovteval_A "q47_G1"
label var PAB_censorinfo "q48_G1"
label var PAB_censorvoices "q49_G1"
label var PAB_blamesoc "q50_G1"
label var PAB_blameext "q51_G1"
label var PAB_freecourts "q52_G1"
label var PAB_overcourts "q53_G1"
label var PAB_judgeprom "q54_G1"
label var PAB_attackopp "q55_G1"
label var PAB_prosecuteopp "q56_G1"
label var CTZ_accountability_A "q57_G1"
label var LEP_safecom "q43a_G2"
label var LEP_safefam "q43b_G2"
label var LEP_policehelp "q43c_G2"
label var LEP_kindpol "q43d_G2"
label var LEP_indpolinv "q43e_G2"
label var LEP_indprosecutors "q43f_G2"
label var LEP_polservpeopl "q43g_G2"
label var LEP_polservcom "q43h_G2"
label var JSE_rightsaware "q44a_G2"
label var JSE_access2info "q44b_G2"
label var JSE_access2assis "q44c_G2"
label var JSE_affordcosts "q44d_G2"
label var JSE_quickresol "q44e_G2"
label var JSE_fairoutcomes "q44f_G2"
label var JSE_equality "q44g_G2"
label var JSE_freecorr "q44h_G2"
label var JSE_polinfluence "q44i_G2"
label var JSE_indjudges "q44j_G2"
label var JSE_fairtrial "q44k_G2"
label var JSE_enforce "q44l_G2"
label var JSE_mediation "q44m_G2"
label var CTZ_gendereq_B "q45a_G2"
label var CTZ_consrights_B "q45b_G2"
label var CTZ_laborcond_B "q45c_G2"
label var CTZ_envprotect_B "q45d_G2"
label var CTZ_euvalues_B "q45e_G2"
label var CTZ_headgovteval_B "q46_G2"
label var CTZ_localgovteval_B "q47_G2"
label var PAB_misinfo "q48_G2"
label var PAB_distract "q49_G2"
label var PAB_credibility "q50_G2"
label var PAB_centralize "q51_G2"
label var PAB_attackmedia "q52_G2"
label var PAB_prosecutejourn "q53_G2"
label var PAB_emergpower "q54_G2"
label var PAB_attackelect "q55_G2"
label var PAB_manipulelect "q56_G2"
label var CTZ_accountability_B "q57_G2"
label var ROL_equality_sig "q58a"
label var ROL_indcontrols_sig "q58b"
label var ROL_abusepower_sig "q58c"
label var ROL_corruption_sig "q58d"
label var ROL_constprotection_sig "q58e"
label var ROL_courtrulings_sig "q58f"
label var ROL_freespeech_sig "q58g"
label var ROL_indgovtbodies_sig "q58h"
label var ROL_csoinput_sig "q58i"
label var ROL_civilobedience_sig "q58j"
label var ROL_equality_imp "q59a"
label var ROL_indcontrols_imp "q59b"
label var ROL_abusepower_imp "q59c"
label var ROL_corruption_imp "q59d"
label var ROL_constprotection_imp "q59e"
label var ROL_courtrulings_imp "q59f"
label var ROL_freespeech_imp "q59g"
label var ROL_indgovtbodies_imp "q59h"
label var ROL_csoinput_imp "q59i"
label var ROL_civilobedience_imp "q59j"
label var KNW_rol_1 "q60_G1_1"
label var KNW_rol_2 "q60_G1_2"
label var KNW_rol_3 "q60_G1_3"
label var KNW_rol_98 "q60_G1_98"
label var KNW_rol_99 "q60_G1_99"
label var KNW_justice_1 "q60_G2_1"
label var KNW_justice_2 "q60_G2_2"
label var KNW_justice_3 "q60_G2_3"
label var KNW_justice_98 "q60_G2_98"
label var KNW_justice_99 "q60_G2_99"
label var KNW_governance_1 "q60_G3_1"
label var KNW_governance_2 "q60_G3_2"
label var KNW_governance_3 "q60_G3_3"
label var KNW_governance_98 "q60_G3_98"
label var KNW_governance_99 "q60_G3_99"
label var relig "relig"
label var ethni "ethni"
label var ethni_groups "Transformed variable"
label var nation "nation"
label var fin "fin"
label var edu "edu"
label var emp "emp"
label var work "work"
label var wagreement "wagreement"
label var marital "marital"
label var mcertificate "mcertificate"
label var disability "disability"
label var disability2 "disability2"
label var politics "politics"
label var polid "paff1"
label var voteintention "paff2"
label var incpp "Transformed variable"
label var A1 "A1"
label var A2 "A2"
label var A3 "A3"
label var A4 "A4"
label var A5_1 "A5_1"
label var A5_2 "A5_2"
label var A5b "A5b"
label var A5c "A5c"
label var A6 "A6"
label var A7 "A7"
label var income2 "Income2"
label var PSU "PSU"
label var SSU "SSU"
label var interview_length "Interview_length"
label var city "City"
label var region "Region"
label var urban "Urban"
label var B1 "B1"
label var B2 "B2"
label var B3 "B3"
label var qpi1 "qpi1"
label var qpi2a "qpi2a"
label var qpi2b "qpi2b"
label var qpi2c "qpi2c"
label var qpi2d "qpi2d"
label var qpi2e "qpi2e"
label var qpi2f "qpi2f"
label var qpi3a "qpi3a"
label var qpi3b "qpi3b"
label var qpi3c "qpi3c"
label var qpi3d "qpi3d"
label var COLOR "COLOR"
label var dweight "dweight"
label var Strata "Strata"
