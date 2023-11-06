/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Variable labels
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
				Santiago Pardo		(spardo@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:

This dofile labels the variable so all labels are standardized across countries, polling companies and years.

=================================================================================================================*/

/*=================================================================================================================
					Labelling dataset
=================================================================================================================*/

label var country_year_id "Respondent Identification Number"
label var country_name_ltn "Country name (English - Latin Alphabet)"
label var country_name_off "Official country name"
label var country_code_nuts "Country Code (NUTS0)"
label var country_code_iso "Country Code (ISO-3166)"
label var nuts_ltn "Subnational NUTS region name (Latin alphabet)"
label var nuts_id "Subnational NUTS region code"
label var year "Year"
label var method "Method of data collection"
label var income_group "Country income group"
label var id "Respondent Identification Number"
label var gend "Gender"
label var age "What is your age as of today? "
label var income_quintile "Reported income. Selected quintile."
label var income_text "Reported income. Selected quintile (text description)"
label var income_cur "Currency of reported income"
label var income_time "Time period of reported income"
label var TRT_people "Trust. People living in this country."
label var TRT_govt_local "Trust. Officers working in the local government."
label var TRT_govt_national "Trust. Officers working in the national government."
label var TRT_inst_eu "Trust. Officials working in the EU's Institutions and Agencies."
label var TRT_police "Trust. The police."
label var TRT_prosecutors "Trust. The prosecutors in charge of criminal investigations."
label var TRT_pda "Trust. Public defense attorneys."
label var TRT_judges "Trust. Judges and magistrates."
label var TRT_media "Trust. The news media."
label var TRT_pparties "Trust. Political parties."
label var TRT_parliament "Trust. Members of Parliament/Congress."
label var ATC_recruitment_public "Nepotism in public officer recruitment"
label var ATC_brbrequest_public "Bribery by public officer for administrative expedite"
label var ATC_brboffer_public "Citizen offering bribe to public officer for administrative expedite"
label var ATC_embezz_priv "Embezzlement by elected official"
label var ATC_embezz_community "Misappropriation of public funds for community use"
label var ATC_brbrequest_police "Bribery by law enforcement officer"
label var COR_parliament "Perception of corruption among members of Parliament/Congress"
label var COR_govt_national "Perception of corruption among national government officers"
label var COR_govt_local "Perception of corruption among local government officers"
label var COR_judges "Perception of corruption among judges and magistrates"
label var COR_prosecutors "Perception of corruption among prosecutors"
label var COR_pda "Perception of corruption among public defense attorneys"
label var COR_police "Perception of corruption among police officers"
label var COR_landreg "Perception of corruption among land registry officers"
label var COR_carreg "Perception of corruption among car registration/driver license agency officers"
label var COR_pparties "Perception of corruption among political parties"
label var COR_inst_eu "Perception of corruption among EU's institutions and agencies"
label var ORC_business_culture "Perception of corruption in business culture"
label var ORC_pconnections "Success in business linked to political connections"
label var ORC_corimpact "Personal impact of corruption on daily life"
label var ORC_govtefforts "Effectiveness of government's anti-corruption efforts"
label var ORC_impartial_measures "Impartiality of anti-corruption measures"
label var ORC_citizen_fight "Empowerment of citizens in the fight against corruption"
label var COR_3year_change "Perception of change in corruption levels"
label var BRB_permit_A "Request for government permit or document processing"
label var BRB_benefits_A "Request for public benefits or government assistance"
label var BRB_id_A "Request for birth certificate or government-issued ID"
label var BRB_school_A "Request for admission to public school"
label var BRB_health_A "Use of public health services"
label var BRB_permit_B "Payment of bribe for service or process expedite"
label var BRB_benefits_B "Payment of bribe for service or process expedite"
label var BRB_id_B "Payment of bribe for service or process expedite"
label var BRB_school_B "Payment of bribe for service or process expedite"
label var BRB_health_B "Payment of bribe for service or process expedite"
label var IPR_rights "Provision of information on rights to people"
label var IPR_easy2read "Simplified information provision to the people"
label var IPR_easy2find "Online information accessibility"
label var IPR_easy2find_online "Offline information accessibility"
label var IRE_govtbudget "Access to government budget details"
label var IRE_govtcontracts "Access to government contracts"
label var IRE_disclosure "Disclosure of officials"
label var IRE_campaign "Campaign funding information"
label var SEC_walking "Nighttime neighborhood safety"
label var SEC_home "Safety at home after dark"
label var SEC_children "Child domestic violence"
label var SEC_women "Violence against women"
label var SEC_lgbt "Violence against LGBTQIA+ people"
label var SEC_immigrant "Violence against immigrants"
label var SEC_race "Racially motivated violence"
label var SEC_street "Street violence"
label var SEC_orgcrime "Organized crime"
label var SEC_police "Police violence against people"
label var DIS_sex "Sex discrimination"
label var DIS_age "Age discrimination"
label var DIS_health "Disability or health status discrimination"
label var DIS_ethni "Ethnicity and language discrimination"
label var DIS_migration "Migration status discrimination"
label var DIS_ses "Socio-economic status discrimination"
label var DIS_location "Geographic location or place of residence discrimination"
label var DIS_religion "Religious discrimination"
label var DIS_family "Marital and family status discrimination"
label var DIS_gender "Sexual orientation or gender identity discrimination"
label var DIS_politics "Political opinion discrimination"
label var DIS_exp_1 "Work-related incidents"
label var DIS_exp_2 "Job application incidents"
label var DIS_exp_3 "Commercial establishment incidents"
label var DIS_exp_4 "Public transport or place incidents"
label var DIS_exp_5 "Household incidents"
label var DIS_exp_6 "Healthcare service incidents"
label var DIS_exp_7 "School or class incidents"
label var DIS_exp_8 "Housing search incidents"
label var DIS_exp_9 "Incidents with police and courts"
label var DIS_exp_10 "Incidents in political participation"
label var DIS_exp_11 "Social media-related incidents"
label var DIS_exp_12 "Miscellaneous incidents"
label var DIS_exp_98 "Uncertain incidents"
label var DIS_exp_99 "No response incidents"
label var AJP_A1_bin "Poor professional service issues"
label var AJP_A2_bin "Problems with refund requests"
label var AJP_A3_bin "Utility service disruptions"
label var AJP_B1_bin "Property title and building issues"
label var AJP_B2_bin "Land disputes - Squatting and Land Grabbing"
label var AJP_B3_bin "Neighbor disputes - Boundaries and Property Rights"
label var AJP_B4_bin "Property co-ownership disputes"
label var AJP_C1_bin "Rental problems with landlords"
label var AJP_C2_bin "Tenant and property damage disputes"
label var AJP_C3_bin "Neighbor disputes  - Noise, litter, parking, pets"
label var AJP_C4_bin "Facing homelessness"
label var AJP_D1_bin "Divorce or separation issues"
label var AJP_D2_bin "Child support obtainment challenges"
label var AJP_D3_bin "Child support payment challenges"
label var AJP_D4_bin "Child custody dispute"
label var AJP_D5_bin "Domestic violence or threats"
label var AJP_D6_bin "Inheritance disputes"
label var AJP_E1_bin "School enrollment issues"
label var AJP_E2_bin "Bullying or harassment at school"
label var AJP_E3_bin "Community issues - Gangs, vandalism, drug/alcohol use"
label var AJP_F1_bin "Workplace health and safety issues"
label var AJP_F2_bin "Medical/dental malpractice"
label var AJP_G1_bin "Unfair job dismissal"
label var AJP_G2_bin "Wage/benefit payment issues"
label var AJP_G3_bin "Harassment at work"
label var AJP_H1_bin "Govt. assistance challenges"
label var AJP_H2_bin "Public clinic or hospital issues"
label var AJP_H3_bin "Water, sanitation, electricity access"
label var AJP_I1_bin "Police/military unjust actions"
label var AJP_J1_bin "Birth certificate problems"
label var AJP_J2_bin "ID card acquisition difficulties"
label var AJP_J3_bin "Citizenship, residency issues"
label var AJP_J4_bin "Tax and gov't disputes"
label var AJP_K1_bin "Utility bill and loan issues"
label var AJP_K2_bin "Debt collector threats"
label var AJP_K3_bin "Criminal organization harassment"
label var AJP_L1_bin "Money collection problems"
label var AJP_L2_bin "Denied insurance claims"
label var AJP_A1_sev "Seriousness: Poor professional services"
label var AJP_A2_sev "Seriousness: Refund for damaged goods"
label var AJP_A3_sev "Seriousness: Utility disruptions, wrong billing"
label var AJP_B1_sev "Seriousness: Land, property, building issues"
label var AJP_B2_sev "Seriousness: Squatting, land grabbing"
label var AJP_B3_sev "Seriousness: Neighbor boundary disputes"
label var AJP_B4_sev "Seriousness: Property co-ownership disputes"
label var AJP_C1_sev "Seriousness: Landlord-tenant issues"
label var AJP_C2_sev "Seriousness: Tenant problems"
label var AJP_C3_sev "Seriousness: Neighbor disputes"
label var AJP_C4_sev "Seriousness: Becoming homeless"
label var AJP_D1_sev "Seriousness: Divorce or separation"
label var AJP_D2_sev "Seriousness: Child support issues"
label var AJP_D3_sev "Seriousness: Child support payment"
label var AJP_D4_sev "Seriousness: Custody dispute"
label var AJP_D5_sev "Seriousness: Partner violence"
label var AJP_D6_sev "Seriousness: Inheritance conflict"
label var AJP_E1_sev "Seriousness: School enrollment woes"
label var AJP_E2_sev "Seriousness: Bullying at school"
label var AJP_E3_sev "Seriousness: Community challenges"
label var AJP_F1_sev "Seriousness: Workplace injuries"
label var AJP_F2_sev "Seriousness: Medical negligence"
label var AJP_G1_sev "Seriousness: Unfair job loss"
label var AJP_G2_sev "Seriousness: Wage/benefit issues"
label var AJP_G3_sev "Seriousness: Workplace harassment"
label var AJP_H1_sev "Seriousness: Govt. benefits trouble"
label var AJP_H2_sev "Seriousness: Public clinic access"
label var AJP_H3_sev "Seriousness: Utility access"
label var AJP_I1_sev "Seriousness: Police/military action"
label var AJP_J1_sev "Seriousness: Birth certificate issues"
label var AJP_J2_sev "Seriousness: ID card problems"
label var AJP_J3_sev "Seriousness: Immigration struggles"
label var AJP_J4_sev "Seriousness: Tax disputes"
label var AJP_K1_sev "Seriousness: Financial struggles"
label var AJP_K2_sev "Seriousness: Debt collector threats"
label var AJP_K3_sev "Seriousness: Criminal organization issues"
label var AJP_L1_sev "Seriousness: Debt collection problems"
label var AJP_L2_sev "Seriousness: Insurance claims denial problems"
label var AJP_problem "Problem selected"
label var AJD_selfemployment "Self-employment dispute"
label var AJD_violence "Physical violence used"
label var AJD_information "Information from resources"
label var AJD_inst_advice "Help from advisers (exclude other party)"
label var AJD_adviser_1 "Relatives, friends as advisers"
label var AJD_adviser_2 "Lawyer or professional adviser"
label var AJD_adviser_3 "Government legal aid"
label var AJD_adviser_4 "Court, govt., or police"
label var AJD_adviser_5 "Health or welfare adviser"
label var AJD_adviser_6 "Trade union or employer"
label var AJD_adviser_7 "Religious or community adviser"
label var AJD_adviser_8 "Civil society or charity"
label var AJD_adviser_9 "Other organization adviser"
label var AJD_adviser_98 "Don't know adviser"
label var AJD_adviser_99 "No answer adviser"
label var AJD_expert_adviser "Legal background of contacts"
label var AJD_noadvice_reason "Reason for no assistance"
label var AJR_resolution "Court or third-party involvement"
label var AJR_noresol_reason "Reasons for not seeking assistance"
label var AJR_state_noresol "Problem status (ongoing or resolved)"
label var AJR_settle_noresol "Method of problem resolution"
label var AJR_court_bin "Court claim or tribunal action"
label var AJR_court_contact "Initiator of court claim"
label var AJR_police_bin "Police or prosecution contact"
label var AJR_police_contact "Initiator of police contact"
label var AJR_office_bin "Govt. office or authority contact"
label var AJR_office_contact "Initiator of govt. contact"
label var AJR_relig_bin "Religious authority or community involvement"
label var AJR_relig_contact "Initiator of religious contact"
label var AJR_arbitration_bin "Third-party mediation or arbitration"
label var AJR_arbitration_contact "Initiator of mediation/arbitration"
label var AJR_appeal_bin "Formal complaints or appeals"
label var AJR_appeal_contact "Initiator of complaints/appeals"
label var AJR_other_bin "Contact with other institution or actor"
label var AJR_other_contact "Initiator of contact with other actor"
label var AJR_state_resol "Problem status (ongoing or resolved)"
label var AJR_settle_resol "Method of problem resolution (continued)"
label var AJR_fair "Fairness of problem resolution"
label var AJR_slow "Speed of problem resolution"
label var AJR_expensive "Cost of problem resolution"
label var AJR_outcome "Favorability of problem outcome"
label var AJR_solvingtime "Duration of problem resolution"
label var AJR_solvingcosts "Personal costs incurred"
label var AJR_costdiff "Difficulty in meeting costs"
label var AJR_satis_outcome "Satisfaction with problem outcome"
label var AJR_satis_ongoing "Satisfaction with problem progress"
label var AJE_description_1 "Problem description (Bad luck / part of life)"
label var AJE_description_2 "Problem description (Bureaucratic)"
label var AJE_description_3 "Problem description (Family or private matter)"
label var AJE_description_4 "Problem description (Legal)"
label var AJE_description_5 "Problem description (Political)"
label var AJE_description_6 "Problem description (Social or community matter)"
label var AJE_description_7 "Problem description (Economic)"
label var AJE_description_8 "Problem description (None of the above)"
label var AJE_description_98 "Problem description (Don't know)"
label var AJE_description_99 "Problem description (No answer)"
label var AJE_legalrights "Understanding legal rights"
label var AJE_infosource "Access to information and advice"
label var AJE_advice "Availability of expert help"
label var AJE_fairoutcome "Confidence in achieving a fair outcome"
label var AJE_health "Health impact of the problem"
label var AJE_emotional "Impact on relationships"
label var AJE_income "Economic consequences"
label var AJE_drugs "Impact on alcohol or drug use"
label var AJE_offwork_time "Missed workdays"
label var AJE_income_loss "Lost income"
label var AJE_healthcare "Visiting a healthcare professional"
label var AJE_healthcare_visits "Number of healthcare visits"
label var AJE_hospital "Hospitalization due to the problem"
label var AJE_hospital_time "Duration of hospitalization"
label var CPA_law_langaval "Access to basic laws in all languages"
label var CPA_media_freeop "Media freedom to criticize government"
label var CPA_cleanelec_local "Clean and fair local government elections"
label var CPA_freevote "Freedom to vote without pressure"
label var CPA_freepolassoc "Freedom to join political organizations"
label var CPA_partdem_congress "Presenting neighborhood concerns to Parliament/Congress"
label var CPA_partdem_localgvt "Presenting neighborhood concerns to local government"
label var CPA_freemedia "Media freedom for unbiased reporting"
label var CPA_cons_cso "Government collaboration with civil society"
label var CPA_cons_citizen "Local government consideration of citizen views"
label var CPA_protest "Participation in legal demonstration or protest"
label var CPA_consultation "Participation in public consultation"
label var CPA_cso "Engagement with civil society organizations"
label var CPB_compl_pservices "Effective complaint mechanisms for public services"
label var CPB_compl_officials "Effective mechanisms to handle complaints against local government officials"
label var CPB_freeassoc "Freedom to form labor unions and negotiate"
label var CPB_unions "Workers' union & bargaining freedom"
label var CPB_freexp "Freedom to criticize the government"
label var CPB_community "Freedom to attend community meetings"
label var CPB_freemedia "Media exposing corruption"
label var CPB_freexp_cso "Civil society's opinion freedom"
label var CPB_freexp_pp "Political parties' opinion freedom"
label var CPB_freeassem "Peaceful protest freedom"
label var CPB_protest "Legal demonstration participation"
label var CPB_consultation "Public consultation involvement"
label var CPB_cso "Engaging with civil society"
label var CP_protest "Legal protest attendance"
label var CP_consultation "Public consultation participation"
label var CP_cso "Civil society engagement"
label var LEP_lawacts "Law-abiding police conduct"
label var LEP_investigations "Serious police investigations"
label var LEP_rightsresp "Respect for suspects' rights"
label var LEP_accountability "Punishing police law violations"
label var LEP_exforce "No excessive force by police"
label var LEP_bribesreq "Holding police accountable for bribes"
label var LEP_bribesacc "Police accountability for accepting bribes"
label var LEP_accusation "Investigating police complaints"
label var LEP_pdaperformance "Public defenders' efforts"
label var CJP_effective "Confidence in justice system"
label var CJP_efficient "Efficient case handling"
label var CJP_access "Equal justice system access"
label var CJP_consistent "Consistent justice system"
label var CJP_fairpunishment "Fitting punishments"
label var CJP_resprights "Victim rights respect"
label var CJP_egalitarian "Equal justice for all victims"
label var CJP_fairtrial "Fair trials for all accused"
label var CJP_victimsupport "Victim support confidence"
label var CJP_proofburden "Presumption of innocence respect"
label var CJP_saferights "Safety & rights guarantee"
label var CTZ_gendereq_A "Gender equality effectiveness"
label var CTZ_consrights_A "Consumer rights protection"
label var CTZ_laborcond_A "Good working conditions"
label var CTZ_envprotect_A "Effective environment protection"
label var CTZ_euvalues_A "EU core values protection"
label var CTZ_headgovteval_A "President/PM job rating"
label var CTZ_localgovteval_A "Local authorities job rating"
label var PAB_censorinfo "Foreign info censorship"
label var PAB_censorvoices "Domestic opposition censorship"
label var PAB_blamesoc "Blaming societal groups"
label var PAB_blameext "Blaming external forces"
label var PAB_freecourts "Limiting court competences"
label var PAB_overcourts "Non-compliance with court rulings"
label var PAB_judgeprom "Influencing judge promotions"
label var PAB_attackopp "Attacking opposition parties"
label var PAB_prosecuteopp "Prosecuting opposition members"
label var CTZ_accountability_A "Outcome of official corruption"
label var LEP_safecom "Police community safety"
label var LEP_safefam "Police family safety"
label var LEP_policehelp "Accessible police help"
label var LEP_kindpol "Kind and respectful police"
label var LEP_indpolinv "Independent police investigators"
label var LEP_indprosecutors "Independent prosecutors"
label var LEP_polservpeopl "Police serving community"
label var LEP_polservcom "Legal awareness in the public"
label var JSE_rightsaware "Legal guidance availability"
label var JSE_access2info "Legal advice accessibility"
label var JSE_access2assis "Affordable legal assistance and representation"
label var JSE_affordcosts "Affordable state dispute resolution mechanisms"
label var JSE_quickresol "Quick civil and commercial courts"
label var JSE_fairoutcomes "Fair state dispute resolution outcomes"
label var JSE_equality "Equal treatment within the civil justice system"
label var JSE_freecorr "Corruption-free local courts"
label var JSE_polinfluence "Politically unbiased local courts"
label var JSE_indjudges "Independent judges"
label var JSE_fairtrial "Fair trials by local courts"
label var JSE_enforce "Effective enforcement of court decisions"
label var JSE_mediation "Access to alternative justice mechanisms"
label var CTZ_gendereq_B "Gender equality in all areas"
label var CTZ_consrights_B "Effective consumer rights protection"
label var CTZ_laborcond_B "Favorable working conditions"
label var CTZ_envprotect_B "Effective environmental protection actions"
label var CTZ_euvalues_B "Preservation of EU core values"
label var CTZ_headgovteval_B "Job performance of President/Prime Minister"
label var CTZ_localgovteval_B "Job performance of local authorities"
label var CTZ_gendereq "Use of misinformation to shape public opinion"
label var CTZ_consrights "Generation of distractions from important issues"
label var CTZ_laborcond "Denial of criticisms and facts"
label var CTZ_envprotect "Efforts to centralize government functions"
label var CTZ_euvalues "Attacks on media and civil society organizations"
label var CTZ_headgovteval "Attacks on the media and civil society organizations"
label var CTZ_localgovteval "Misuse of misinformation to influence public opinion"
label var PAB_misinfo "Creation of diversions from crucial issues"
label var PAB_distract "Undermining the credibility of critics and facts"
label var PAB_credibility "Attempts to centralize government functions and reduce local autonomy"
label var PAB_centralize "Criticism and discrediting of critical media and civil society organizations"
label var PAB_attackmedia "Attacks on critical media and civil society organizations"
label var PAB_prosecutejourn "Prosecution of critics"
label var PAB_emergpower "Use of emergency powers"
label var PAB_attackelect "Attack on electoral system"
label var PAB_manipulelect "Election manipulation"
label var CTZ_accountability_B "Outcomes of exposing corruption"
label var CTZ_accountability "Outcomes of exposing corruption"
label var ROL_equality_sig "Equality under the law"
label var ROL_indcontrols_sig "Independent law controls"
label var ROL_abusepower_sig "Unbiased public officials"
label var ROL_corruption_sig "Anti-corruption measures"
label var ROL_constprotection_sig "Access to independent courts"
label var ROL_courtrulings_sig "Adherence to court rulings"
label var ROL_freespeech_sig "Freedom for media and civil society"
label var ROL_indgovtbodies_sig "Respect for government bodies"
label var ROL_csoinput_sig "Respect for media and opposition"
label var ROL_civilobedience_sig "Citizen obedience"
label var ROL_equality_imp "Equality under the law"
label var ROL_indcontrols_imp "Independent law controls"
label var ROL_abusepower_imp "Unbiased public officials"
label var ROL_corruption_imp "Anti-corruption measures"
label var ROL_constprotection_imp "Access to independent courts"
label var ROL_courtrulings_imp "Adherence to court rulings"
label var ROL_freespeech_imp "Freedom for media and civil society"
label var ROL_indgovtbodies_imp "Respect for government bodies"
label var ROL_csoinput_imp "Respect for media and opposition"
label var ROL_civilobedience_imp "Citizen obedience"
label var KNW_rol_1 "Rule of law - Prompt 1"
label var KNW_rol_2 "Rule of law - Prompt 2"
label var KNW_rol_3 "Rule of law - Prompt 3"
label var KNW_rol_98 "Rule of law - Prompt 98"
label var KNW_rol_99 "Rule of law - Prompt 99"
label var KNW_justice_1 "Justice - Prompt 1"
label var KNW_justice_2 "Justice - Prompt 2"
label var KNW_justice_3 "Justice - Prompt 3"
label var KNW_justice_98 "Justice - Prompt 98"
label var KNW_justice_99 "Justice - Prompt 99"
label var KNW_governance_1 "Government - Prompt 1"
label var KNW_governance_2 "Government - Prompt 2"
label var KNW_governance_3 "Government - Prompt 3"
label var KNW_governance_98 "Government - Prompt 98"
label var KNW_governance_99 "Government - Prompt 99"
label var relig "Religious preference"
label var ethni "Racial-ethnic background (1)"
label var ethni_groups "Racial-ethnic background (2)"
label var nation "Current nationality"
label var fin "Household financial situation"
label var edu "Highest degree received"
label var emp "Activities in the past week"
label var work "Work status last week"
label var wagreement "Employment basis"
label var marital "Marital status"
label var mcertificate "Marriage certificate"
label var disability "Physical or mental health conditions"
label var disability2 "Types of health conditions"
label var politics "Interest in politics"
label var polid "Political views on a scale"
label var voteintention "Preferred political party"
label var incpp "Incumbent political party"
label var A1 "Household size"
label var A2 "Government program benefits"
label var A3 "Internet usage frequency"
label var A4 "Mobile phone ownership"
label var A5_1 "Birth certificate"
label var A5_2 "Government-issued ID card"
label var A5b "Dwelling ownership documents"
label var A5c "Types of dwelling documents"
label var A6 "Internet connection at home"
label var A7 "Number of people working in the last month"
label var income2 "Total monthly household income"
label var PSU "Primary sampling unit"
label var SSU "Secondary sampling unit"
label var interview_length "Length of interview (minutes)"
label var city "City of residence"
label var region "Region of the country"
label var urban "Type of area of residence"
label var B1 "Type of housing"
label var B2 "Presence of another person during the interview"
label var B3 "Relationship of the other person present"
label var qpi1 "Feeling threatened during the interview"
label var qpi2a "Respondent's attitude toward the interviewer (1)"
label var qpi2b "Respondent's attitude toward the interviewer (2)"
label var qpi2c "Respondent's attitude toward the interviewer (3)"
label var qpi2d "Respondent's attitude toward the interviewer (4)"
label var qpi2e "Respondent's attitude toward the interviewer (5)"
label var qpi2f "Respondent's attitude toward the interviewer (6)"
label var qpi3a "Garbage in the street or sidewalk"
label var qpi3b "Potholes in the street"
label var qpi3c "Graffiti or gang marks on walls"
label var qpi3d "Lack of utility poles"
label var COLOR "Respondent's skin color"
label var dweight "Design weight"
label var Strata "Stratification variable"


/*=================================================================================================================
					Adding full question phrasing to dataset
=================================================================================================================*/

note country_year_id: Dataset unique identifier
note country_name_ltn: Country name (English - Latin Alphabet)
note country_name_off: Official country name
note country_code_nuts: Country Code (NUTS0)
note country_code_iso: Country Code (ISO-3166)
note nuts_ltn: Subnational NUTS region name (Latin alphabet)
note nuts_id: Subnational NUTS region code
note year: Year
note method: Method of data collection
note income_group: Country income group
note id: Respondent Identification Number
note gend: Gender
note age: What is your age as of today? 
note income_quintile: Would you please tell me the bracket that best represents your household's total income from all sources? This should include wages and salaries, net income from businesses, pensions, dividends, remittances, rents, and any other money income received by all members of the household.
note income_text: Would you please tell me the bracket that best represents your household's total income from all sources? This should include wages and salaries, net income from businesses, pensions, dividends, remittances, rents, and any other money income received by all members of the household.
note income_cur: Currency of reported income
note income_time: Time period of reported income
note TRT_people: People living in this country. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_govt_local: Officers working in the local government. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_govt_national: Officers working in the national government. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_inst_eu: Officials working in the EU's Institutions and Agencies. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_police: The police. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_prosecutors: The prosecutors in charge of criminal investigations. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions?
note TRT_pda: Public defense attorneys. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_judges: Judges and magistrates. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions?
note TRT_media: The news media. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions?
note TRT_pparties: Political parties. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note TRT_parliament: Members of Parliament/Congress. Please tell me, how much TRUST do you have in each of the following categories of people, groups of people, and institutions? 
note ATC_recruitment_public: A public officer being recruited on the basis of family ties and friendship networks.
note ATC_brbrequest_public: A public officer asking for a bribe to speed up administrative procedures. 
note ATC_brboffer_public: A private citizen offering a bribe to a public official to speed up administrative procedures.
note ATC_embezz_priv: An elected official taking public funds for private use.
note ATC_embezz_community: An elected official using stolen public funds to assist their community. 
note ATC_brbrequest_police: A law enforcement officer (police, customs, immigration, civil guard, military police) asking for a bribe.
note COR_parliament: Members of Parliament/Congress. How many of the following people in [COUNTRY] do you think are involved in corrupt practices? 
note COR_govt_national: Officers working in the national government. How many of the following people in [COUNTRY] do you think are involved in corrupt practices? 
note COR_govt_local: Officers working in the local government. How many of the following people in [COUNTRY] do you think are involved in corrupt practices? 
note COR_judges: Judges and Magistrates. How many of the following people in [COUNTRY] do you think are involved in corrupt practices? 
note COR_prosecutors: The prosecutors in charge of criminal investigations. How many of the following people in [COUNTRY] do you think are involved in corrupt practices?
note COR_pda: Public defense attorneys. How many of the following people in [COUNTRY] do you think are involved in corrupt practices? 
note COR_police: Police officers. How many of the following people in [COUNTRY] do you think are involved in corrupt practices?
note COR_landreg: Land registry officers. How many of the following people in [COUNTRY] do you think are involved in corrupt practices?
note COR_carreg: Car registration/driver license agency officers. How many of the following people in [COUNTRY] do you think are involved in corrupt practices?
note COR_pparties: Political parties. How many of the following people in [COUNTRY] do you think are involved in corrupt practices?
note COR_inst_eu: Officials working in the EU's Institutions and Agencies. How many of the following people in [COUNTRY] do you think are involved in corrupt practices?
note ORC_business_culture: Corruption is part of the business culture in [COUNTRY]. Do you agree or disagree that corruption affects work life?
note ORC_pconnections: In [COUNTRY] the only way to succeed in business is to have political connections. Do you agree or disagree that success in business relies on political connections?
note ORC_corimpact: You are personally affected by corruption in your daily life. Do you agree or disagree that corruption has a personal impact on your daily life?
note ORC_govtefforts: [NATIONALITY] government efforts to combat corruption are effective. Do you agree or disagree that the government's anti-corruption efforts are successful?
note ORC_impartial_measures: In [COUNTRY], measures against corruption are applied impartially and without ulterior motives.  Do you agree or disagree that anti-corruption measures are applied fairly and without hidden agendas?
note ORC_citizen_fight: Citizens can make a difference in the fight against corruption. Do you agree or disagree that citizens have the ability to influence the fight against corruption?
note COR_3year_change: In the past three years, would you say that the level of corruption in [COUNTRY] has…?
note BRB_permit_A: In the last three years, did you request a government permit, or process any kind of document (like a license, building permit, etc.) in a local government office?
note BRB_benefits_A: In the last three years, did you request public benefits or government assistance, such as cash transfers, pensions, or disability benefits?
note BRB_id_A: In the last three years, did you request a birth certificate for you or your children or a government issued ID card? 
note BRB_school_A: In the last three years, did you request a place at a public school?
note BRB_health_A: In the last three years, did you use any PUBLIC health services?
note BRB_permit_B: Did you have to pay a bribe to receive the service or expedite the process?
note BRB_benefits_B: Did you have to pay a bribe to receive the service or expedite the process?
note BRB_id_B: Did you have to pay a bribe to receive the service or expedite the process?
note BRB_school_B: Did you have to pay a bribe to receive the service or expedite the process?
note BRB_health_B: Did you have to pay a bribe to receive the service or expedite the process?
note IPR_rights: Provide people with information about their rights. Do you agree or disagree that access to information about your rights is essential?
note IPR_easy2read: Provide information for people in a simple, easy-to-read way. Do you agree or disagree that information should be presented in a simple and easy-to-understand manner?
note IPR_easy2find: Make information easy to find online. Do you agree or disagree that online accessibility of information is important?
note IPR_easy2find_online: Make information easy to find without using the internet, such as using leaflets or posters. Do you agree or disagree that non-digital means of information distribution, such as leaflets and posters, are effective for accessibility?
note IRE_govtbudget: Detailed budget figures of government agencies. If you were to request to have access to these documents, how likely do you think it is that the government agency will grant it, assuming the information is properly requested? Would you say that it is very likely, likely, unlikely, or very unlikely?
note IRE_govtcontracts: Copies of government contracts. If you were to request to have access to these documents, how likely do you think it is that the government agency will grant it, assuming the information is properly requested? Would you say that it is very likely, likely, unlikely, or very unlikely?
note IRE_disclosure: Disclosure records of senior government officials (such as tax records or property holdings). If you were to request to have access to these documents, how likely do you think it is that the government agency will grant it, assuming the information is properly requested? Would you say that it is very likely, likely, unlikely, or very unlikely?
note IRE_campaign: Sources of campaign financing of elected officials and legislators. If you were to request to have access to these documents, how likely do you think it is that the government agency will grant it, assuming the information is properly requested? Would you say that it is very likely, likely, unlikely, or very unlikely?
note SEC_walking: How safe do you feel walking in your neighborhood at night?
note SEC_home: How safe do you feel at home after dark? 
note SEC_children: Domestic violence against children. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_women: Violence against women. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_lgbt: Violence against LGBTQIA+ people. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_immigrant: Violence against immigrants. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_race: Racially motivated violence. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_street: Street violence (violent property crime, violent injury, gun violence). Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_orgcrime: Organized crime. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note SEC_police: Police violence against people. Do you know or have you heard if the following situations happen or occur in your community or neighborhood?
note DIS_sex: Sex (Such as being a woman, a man, or nonbinary?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_age: Age (Such as you are perceived to be too young or too old?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_health: Disability or health status (Such as having difficulty in seeing, hearing, walking or moving, concentrating or communicating, having a disease or other health conditions and no reasonable accommodation provided for it?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_ethni: Ethnicity, skin color, language (Such as skin color or physical appearance, ethnic origin or way of dressing, culture, traditions, native language or accent, indigenous status, or being of African descent?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_migration: Migration status (Such as nationality or national origin, country of birth, refugees, asylum seekers, migrant status, undocumented migrants or stateless persons: not considered a citizen of any country?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_ses: Socio-economic status (Such as wealth or education level, being perceived to be from a lower or different social or economic group or class, land or home ownership or not?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_location: Geographic location or place of residence (Such as living in urban or rural areas, formal or informal settlements?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_religion: Religion (Such as having or not a religion or religious beliefs?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_family: Marital and family status (Such as being single, married, divorced, widowed, pregnant, with or without children, orphan or born from unmarried parents, or having children outside a wedlock?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_gender: Sexual orientation or gender identity (Such as being attracted to person of the same sex, self-identifying differently from sex assigned at birth or as being either sexually, bodily and/or gender diverse?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_politics: Political opinion (Such as expressing political views, defending the rights of others, being a member or not of a political party or trade union?). Do you feel that you personally experienced any form of discrimination or harassment during the past 12 months
note DIS_exp_1: At work. In what types of situations have you experienced these incidents? 
note DIS_exp_2: When applying for a job. In what types of situations have you experienced these incidents? 
note DIS_exp_3: In a shop, bank, restaurant, bar, night club or hotel. In what types of situations have you experienced these incidents? 
note DIS_exp_4: On public transportation, on the street or in other places. In what types of situations have you experienced these incidents? 
note DIS_exp_5: In my household. In what types of situations have you experienced these incidents? 
note DIS_exp_6: When seeking or using healthcare services. In what types of situations have you experienced these incidents? 
note DIS_exp_7: When attending school or classes. In what types of situations have you experienced these incidents? 
note DIS_exp_8: When looking for housing. In what types of situations have you experienced these incidents? 
note DIS_exp_9: When dealing with the police or courts. In what types of situations have you experienced these incidents? 
note DIS_exp_10: When voting, running for public office, or participating in public consultation. In what types of situations have you experienced these incidents? 
note DIS_exp_11: On social media. In what types of situations have you experienced these incidents? 
note DIS_exp_12: Other. In what types of situations have you experienced these incidents? 
note DIS_exp_98: Don't know. In what types of situations have you experienced these incidents? 
note DIS_exp_99: Don't answer. In what types of situations have you experienced these incidents? 
note AJP_A1_bin: In the last two years, have you had: problems related to poor or incomplete professional services (for example, services from a lawyer, builder, mechanic, etc.)
note AJP_A2_bin: In the last two years, have you had: problems related to obtaining a refund for faulty or damaged goods 
note AJP_A3_bin: In the last two years, have you had: major disruptions in the supply of utilities (e.g. water, electricity, phone) or incorrect billing
note AJP_B1_bin: In the last two years, have you had: problems obtaining land titles, property titles, or permission for building projects for your own home
note AJP_B2_bin: In the last two years, have you had: problems related to squatting and land grabbing
note AJP_B3_bin: In the last two years, have you had: problems with your neighbors over boundaries or the right to pass through property, fences, or trees
note AJP_B4_bin: In the last two years, have you had: problems with co-owners or community members over selling property 
note AJP_C1_bin: In the last two years, have you had: problems with a landlord about rental agreements, payments, repairs, deposits, or eviction
note AJP_C2_bin: In the last two years, have you had: problems with a tenant about rental agreements, or property damage
note AJP_C3_bin: In the last two years, have you had: problems with your neighbors over noise, litter, parking spots, or pets
note AJP_C4_bin: In the last two years, have you had:: becoming homeless
note AJP_D1_bin: In the last two years, have you had: divorce or separation 
note AJP_D2_bin: In the last two years, have you had: difficulties obtaining child support payments
note AJP_D3_bin: In the last two years, have you had: difficulties paying child support
note AJP_D4_bin: In the last two years, have you had: dispute over child custody or visitation arrangements
note AJP_D5_bin: In the last two years, have you had: threats or physical violence from a current partner, ex-partner or other household member
note AJP_D6_bin: In the last two years, have you had: disagreement over the content of a will or the division of property after the death of a family member
note AJP_E1_bin: In the last two years, have you had: difficulties obtaining a place at a school or other educational institution that you or your children are eligible to attend
note AJP_E2_bin: In the last two years, have you had: You or your children being bullied or harassed at school or another educational institution
note AJP_E3_bin: In the last two years, have you had: problems with gangs, vandalism, or consumption of drugs or alcohol on the streets 
note AJP_F1_bin: In the last two years, have you had: injuries or health problems sustained as a result of an accident or due to poor working conditions
note AJP_F2_bin: In the last two years, have you had: injuries or health problems sustained as a result of negligent or wrong medical or dental treatment
note AJP_G1_bin: In the last two years, have you had: being dismissed from a job unfairly 
note AJP_G2_bin: In the last two years, have you had: difficulties obtaining wages or employment benefits that were agreed on in advance
note AJP_G3_bin: In the last two years, have you had: harassment at work
note AJP_H1_bin: In the last two years, have you had: difficulties obtaining public benefits or government assistance, such as cash transfers, pensions, or disability benefits.
note AJP_H2_bin: In the last two years, have you had: difficulties accessing care in public clinics or hospitals
note AJP_H3_bin: In the last two years, have you had: lack of access to water, sanitation, and/or electricity
note AJP_I1_bin: In the last two years, have you had: Being beaten up or arrested without justification by a member of the police or the military.
note AJP_J1_bin: In the last two years, have you had: difficulties obtaining birth certificates for you or your children
note AJP_J2_bin: In the last two years, have you had: difficulties obtaining a government-issued ID card
note AJP_J3_bin: In the last two years, have you had: problems with you or your children's citizenship, residency, or immigration status
note AJP_J4_bin: In the last two years, have you had: tax disputes or disputes with other government bodies.
note AJP_K1_bin: In the last two years, have you had: being behind on and unable to pay credit cards, utility bills (e.g. water, electricity, gas), or a loan
note AJP_K2_bin: In the last two years, have you had: being threatened by debt collectors over unpaid loans or bills 
note AJP_K3_bin: In the last two years, have you had: being threatened, harassed, or extorted by a mob, a gang or another criminal organization. 
note AJP_L1_bin: In the last two years, have you had: difficulties collecting money owed to you
note AJP_L2_bin: In the last two years, have you had: insurance claims being denied
note AJP_A1_sev: Seriousness: problems related to poor or incomplete professional services (for example, services from a lawyer, builder, mechanic, etc.)
note AJP_A2_sev: Seriousness: problems related to obtaining a refund for faulty or damaged goods 
note AJP_A3_sev: Seriousness: major disruptions in the supply of utilities (e.g. water, electricity, phone) or incorrect billing
note AJP_B1_sev: Seriousness: problems obtaining land titles, property titles, or permission for building projects for your own home
note AJP_B2_sev: Seriousness: problems related to squatting and land grabbing
note AJP_B3_sev: Seriousness: problems with your neighbors over boundaries or the right to pass through property, fences, or trees
note AJP_B4_sev: Seriousness: problems with co-owners or community members over selling property 
note AJP_C1_sev: Seriousness: problems with a landlord about rental agreements, payments, repairs, deposits, or eviction
note AJP_C2_sev: Seriousness: problems with a tenant about rental agreements, or property damage
note AJP_C3_sev: Seriousness: problems with your neighbors over noise, litter, parking spots, or pets
note AJP_C4_sev: Seriousness: becoming homeless
note AJP_D1_sev: Seriousness: divorce or separation 
note AJP_D2_sev: Seriousness: difficulties obtaining child support payments
note AJP_D3_sev: Seriousness: difficulties paying child support
note AJP_D4_sev: Seriousness: dispute over child custody or visitation arrangements
note AJP_D5_sev: Seriousness: threats or physical violence from a current partner, ex-partner or other household member
note AJP_D6_sev: Seriousness: disagreement over the content of a will or the division of property after the death of a family member
note AJP_E1_sev: Seriousness: difficulties obtaining a place at a school or other educational institution that you or your children are eligible to attend
note AJP_E2_sev: Seriousness: You or your children being bullied or harassed at school or another educational institution
note AJP_E3_sev: Seriousness: problems with gangs, vandalism, or consumption of drugs or alcohol on the streets 
note AJP_F1_sev: Seriousness: injuries or health problems sustained as a result of an accident or due to poor working conditions
note AJP_F2_sev: Seriousness: injuries or health problems sustained as a result of negligent or wrong medical or dental treatment
note AJP_G1_sev: Seriousness: being dismissed from a job unfairly 
note AJP_G2_sev: Seriousness: difficulties obtaining wages or employment benefits that were agreed on in advance
note AJP_G3_sev: Seriousness: harassment at work
note AJP_H1_sev: Seriousness: difficulties obtaining public benefits or government assistance, such as cash transfers, pensions, or disability benefits.
note AJP_H2_sev: Seriousness: difficulties accessing care in public clinics or hospitals
note AJP_H3_sev: Seriousness: lack of access to water, sanitation, and/or electricity
note AJP_I1_sev: Seriousness: Being beaten up or arrested without justification by a member of the police or the military.
note AJP_J1_sev: Seriousness: difficulties obtaining birth certificates for you or your children
note AJP_J2_sev: Seriousness: difficulties obtaining a government-issued ID card
note AJP_J3_sev: Seriousness: problems with you or your children's citizenship, residency, or immigration status
note AJP_J4_sev: Seriousness: tax disputes or disputes with other government bodies
note AJP_K1_sev: Seriousness: being behind on and unable to pay credit cards, utility bills (e.g. water, electricity, gas), or a loan
note AJP_K2_sev: Seriousness: being threatened by debt collectors over unpaid loans or bills 
note AJP_K3_sev: Seriousness: being threatened, harassed, or extorted by a mob, a gang or another criminal organization. 
note AJP_L1_sev: Seriousness: difficulties collecting money owed to you
note AJP_L2_sev: Seriousness: insurance claims being denied
note AJP_problem: Problem Selected
note AJD_selfemployment: Was this problem related to your self-employment activity (own business, professional practice, or farm)?
note AJD_violence: Did any of the parties resort to physical violence during the dispute or in the process of settling the dispute?
note AJD_information: Did you obtain any information from the Internet, a software app, a video, printed material or the media to help you better understand or resolve the problem?
note AJD_inst_advice: Apart from anything you have told me about already, did you, or someone acting on your behalf, obtain information, advice or representation from any person or organization to help you better understand or resolve the problem?  Please exclude any help provided by the other party.
note AJD_adviser_1: A relative, friend, or acquaintance. Which advisers did you contact? 
note AJD_adviser_2: A lawyer, professional advisor or advice service. Which advisers did you contact?
note AJD_adviser_3: A government legal aid office. Which advisers did you contact? 
note AJD_adviser_4: A court, government body, or the police. Which advisers did you contact?
note AJD_adviser_5: A health or welfare professional. Which advisers did you contact?
note AJD_adviser_6: A trade union or employer. Which advisers did you contact?
note AJD_adviser_7: A religious or community leader or organization. Which advisers did you contact?
note AJD_adviser_8: A civil society organization or charity. Which advisers did you contact?
note AJD_adviser_9: Other organization. Which advisers did you contact?
note AJD_adviser_98: Don't know. Which advisers did you contact?
note AJD_adviser_99: No answer. Which advisers did you contact?
note AJD_expert_adviser: Did any of the family or friends who you contacted go to law school or work in an organization that provides legal advice?
note AJD_noadvice_reason: What was the main reason why you did not consider getting information, advice, or representation from anyone?
note AJR_resolution: Did you, somebody acting on your behalf, the other party or anybody else, make a claim to a court or turn to any other third-party individual or organization to adjudicate, mediate or intervene to help resolve the problem? 
note AJR_noresol_reason: Why did you not go to anybody? 
note AJR_state_noresol: Is the problem ongoing or done with? By done with I mean that the problem is either completely resolved or that it persists, but you and everybody else have given up all actions to resolve it further.
note AJR_settle_noresol: Which of the following statements best reflects how the problem was settled? The problem was settled through 
note AJR_court_bin: Make a claim to a court or tribunal. Did you, somebody acting on your behalf, the other party or anybody else: 
note AJR_court_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_police_bin: Contact the police (or other prosecution authority). Did you, somebody acting on your behalf, the other party or anybody else:
note AJR_police_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_office_bin: Contact a government office  or other formal designated authority or agency. Did you, somebody acting on your behalf, the other party or anybody else: 
note AJR_office_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_relig_bin: Turn to a religious authority or community leader or organization. Did you, somebody acting on your behalf, the other party or anybody else:
note AJR_relig_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_arbitration_bin: Turn to a third-party to mediate the problem or turn to a formal conciliation or arbitration. Did you, somebody acting on your behalf, the other party or anybody else:
note AJR_arbitration_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_appeal_bin: Turn to a formal complaints or appeal process. Did you, somebody acting on your behalf, the other party or anybody else:
note AJR_appeal_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_other_bin: Turn to another institution or actor. Did you, somebody acting on your behalf, the other party or anybody else:
note AJR_other_contact: Who initiated (contact) it, you (or somebody acting on your behalf), the other party, or someone else?
note AJR_state_resol: Is the problem ongoing or done with? By done with I mean that the problem is either completely resolved or that it persists, but you and everybody else have given up all actions to resolve it further.
note AJR_settle_resol: Which of the following statements best reflects how the problem was settled? The problem was settled through
note AJR_fair: Fair. Regardless of the outcome, do you think that the process to solve the problem was:
note AJR_slow: Slow. Regardless of the outcome, do you think that the process to solve the problem was:
note AJR_expensive: Expensive. Regardless of the outcome, do you think that the process to solve the problem was:
note AJR_outcome: To what extent was the outcome of the problem or dispute in your favor?
note AJR_solvingtime: How many months did it take to resolve the problem, from the moment you turned to a court, government office, or third-party?
note AJR_solvingcosts: Did you, personally, incur costs (other than your time) in order to solve the problem? 
note AJR_costdiff: How difficult was it to find the money to meet these costs? 
note AJR_satis_outcome: How satisfied or dissatisfied are you with the outcome of the problem?
note AJR_satis_ongoing: How satisfied or dissatisfied are you with how things are turning out so far with the problem?
note AJE_description_1: Bad luck / part of life. Which of the following describe the problem? 
note AJE_description_2: Bureaucratic. Which of the following describe the problem? 
note AJE_description_3: A family or private matter. Which of the following describe the problem?
note AJE_description_4: Legal. Which of the following describe the problem? 
note AJE_description_5: Political. Which of the following describe the problem? 
note AJE_description_6: A social or community matter. Which of the following describe the problem? 
note AJE_description_7: Economic. Which of the following describe the problem? 
note AJE_description_8: None of the above. Which of the following describe the problem? 
note AJE_description_98: Don't know. Which of the following describe the problem? 
note AJE_description_99: No answer. Which of the following describe the problem? 
note AJE_legalrights: I understood or came to understand my legal rights and responsibilities. To what extent do you agree or disagree with the following statements about the problem? 
note AJE_infosource: I knew where to get good information and advice about resolving the problem. To what extent do you agree or disagree with the following statements about the problem? 
note AJE_advice: I was able to get all the expert help I wanted. To what extent do you agree or disagree with the following statements about the problem? 
note AJE_fairoutcome: I was (am) confident I could (can) achieve a fair outcome. To what extent do you agree or disagree with the following statements about the problem? 
note AJE_health: At any time, did the problem cause you to experience stress-related illness, injuries, or physical ill health
note AJE_emotional: At any time, did the problem cause you to experience relationship breakdown or damage to a family relationship
note AJE_income: At any time, did the problem cause you to experience loss of income, loss of employment, financial strain or need to relocate
note AJE_drugs: At any time, did the problem cause you to experience problems with alcohol or drugs
note AJE_offwork_time: How many days, if any, did you not work as a result of this hardship?
note AJE_income_loss: How much income, if any, did you lose from not working?
note AJE_healthcare: Did this hardship cause you to visit a healthcare professional (that is, a medical doctor, therapist, psychologist, etc.)?
note AJE_healthcare_visits: If it caused you to visit a healthcare professional, how many visits did you make?
note AJE_hospital: Did this hardship cause you to be hospitalized?
note AJE_hospital_time: If it caused you to be hospitalized, how many days were you in the hospital?
note CPA_law_langaval: In practice, the basic laws of [COUNTRY] are available in all official languages. Do you agree or disagree that access to basic laws in all official languages is essential?
note CPA_media_freeop: In [COUNTRY], the media (TV, radio, newspapers)  can freely express opinions against government officials, policies and actions without fear of retaliation. Do you agree or disagree that media freedom to criticize government is important?
note CPA_cleanelec_local: In practice, in [COUNTRY], local government officials are elected through a clean process. Do you agree or disagree that clean and fair local government elections are important?
note CPA_freevote: In practice, in [COUNTRY], people can vote freely without feeling harassed or pressured. Do you agree or disagree that the freedom to vote without pressure is important?
note CPA_freepolassoc: In practice, in [COUNTRY], people can freely join any (unforbidden) political organization they want. Do you agree or disagree that the freedom to join any political organization is important?
note CPA_partdem_congress: In practice, people in this neighborhood can get together with others and present their concerns to members of Parliament/Congress. Do you agree or disagree that the ability to present neighborhood concerns to elected representatives is important?
note CPA_partdem_localgvt: In practice, people in this neighborhood can get together with others and present their concerns to local government officials. Do you agree or disagree that the ability to present neighborhood concerns to local government officials is important?
note CPA_freemedia: In [COUNTRY], the media (TV, radio, newspapers) are free to report the news without government influence or fear of retaliation. Do you agree or disagree that media freedom is important for unbiased news reporting?
note CPA_cons_cso: In practice, the government collaborates with civil society organizations in designing public policy. Do you agree or disagree that government collaboration with civil society is important for public policy design?
note CPA_cons_citizen: In practice, the local government considers the views of people. Do you agree or disagree that local government consideration of citizen views is important for decision-making? like me when making decisions.
note CPA_protest: Attended a legal demonstration or protest march?
note CPA_consultation: Participated in a public consultation in person or online?
note CPA_cso: Engaged with civil society organizations by volunteering, engaging with them online or on social networks, or donating money?
note CPB_compl_pservices: In practice, the local government (Metropolitan, Municipal, or District administration) provides effective ways to make complaints about public services. Do you agree or disagree that the availability of effective complaint mechanisms for public services is important?
note CPB_compl_officials: In practice, the local government (Metropolitan, Municipal, or District administration) provides effective ways to handle complaints against local government officials. Do you agree or disagree that the availability of effective mechanisms to handle complaints against local government officials is important?
note CPB_freeassoc: In [COUNTRY], people can freely join together with others to draw attention to an issue or sign a petition. Do you agree or disagree that workers' freedom to form labor unions and negotiate with employers is important?
note CPB_unions: In practice, workers in [COUNTRY] can freely form labor unions and bargain for their rights with their employers. o you agree or disagree that workers' freedom to form labor unions and negotiate with employers is important?
note CPB_freexp: In [COUNTRY], people can freely express opinions against the government. Do you agree or disagree that the freedom to express opinions against the government is important?
note CPB_community: In [COUNTRY], people can freely attend community meetings. Do you agree or disagree that the freedom to attend community meetings is important?
note CPB_freemedia: In [COUNTRY], the media  (TV, radio, newspapers) can freely expose cases of corruption by high-ranking government officers without fear of retaliation. Do you agree or disagree that media freedom to expose corruption is important?
note CPB_freexp_cso: In [COUNTRY], civil society organizations can freely express opinions against government policies and actions without fear of retaliation. Do you agree or disagree that civil society's freedom to express opinions is important?
note CPB_freexp_pp: In [COUNTRY], political parties can freely express opinions against government policies and actions without fear of retaliation. Do you agree or disagree that political parties' freedom to express opinions is important?
note CPB_freeassem: In practice, in [COUNTRY], people can freely participate in peaceful protests and demonstrations without fear of reprisal. Do you agree or disagree that the freedom to participate in peaceful protests without fear of reprisal is important?
note CPB_protest: Attended a legal demonstration or protest march?
note CPB_consultation: Participated in a public consultation in person or online?
note CPB_cso: Engaged with civil society organizations by volunteering, engaging with them online or on social networks, or donating money?note CP_protest: Attended a legal demonstration or protest march?
note CP_consultation: Participated in a public consultation in person or online?
note CP_cso: Engaged with civil society organizations by volunteering, engaging with them online or on social networks, or donating money?
note LEP_lawacts: The police in [COUNTRY] act according to the law. Do you agree or disagree that law-abiding police conduct is important?
note LEP_investigations: Police investigators in [COUNTRY] perform serious and law-abiding investigations to find the perpetrators of a crime. Do you agree or disagree that serious and lawful investigations by police investigators are important?
note LEP_rightsresp: In [COUNTRY], the basic rights of suspects are respected by the police. Do you agree or disagree that the respect of basic rights of suspects by the police is important?
note LEP_accountability: In [COUNTRY], if members of the police violate the law, they are punished for these violations. Do you agree or disagree that the punishment of police members for law violations is important?
note LEP_exforce: In [COUNTRY], members of the police do not use excessive or unnecessary force. Do  you agree or disagree that the non-use of excessive or unnecessary force by police is important?
note LEP_bribesreq: In [COUNTRY], if members of the police request bribes from the public, they will be held accountable. Do you agree or disagree that holding police accountable for requesting bribes is important?
note LEP_bribesacc: In [COUNTRY], if members of the police accept bribes from gangsor criminal organizations, they will be held accountable. Do you agree or disagree that holding police accountable for accepting bribes from criminal organizations is important?
note LEP_accusation: In [COUNTRY], if someone makes a complaint against a member of the police, the accusation will be investigated. Do you agree or disagree that the investigation of complaints against police members is important?
note LEP_pdaperformance: The public defenders of [COUNTRY] do everything they can to defend poor people that are accused of committing a crime. Do you agree or disagree that public defenders' efforts to defend accused poor individuals are important?
note CJP_effective: Is effective in bringing people who commit crimes to justice. Please tell us how confident you are that the criminal justice system as a whole:
note CJP_efficient: Deals with cases promptly and efficiently. Please tell us how confident you are that the criminal justice system as a whole:
note CJP_access: Makes sure everyone has access to the justice system if they need it. Please tell us how confident you are that the criminal justice system as a whole:
note CJP_consistent: Functions the same regardless of where you live? Please tell us how confident you are that the criminal justice system as a whole:
note CJP_fairpunishment: Gives punishments which fit the crime. Please tell us how confident you are that the criminal justice system as a whole: 
note CJP_resprights: Respects the rights of victims. Please tell us how confident you are that the criminal justice system as a whole: 
note CJP_egalitarian: Allows all victims of crime to seek justice regardless of who they are. Please tell us how confident you are that the criminal justice system as a whole: 
note CJP_fairtrial: Allows all those accused of crimes to get a fair trial regardless of who they are. Please tell us how confident you are that the criminal justice system as a whole: 
note CJP_victimsupport: Provides victims of crime with the service and support they need. Please tell us how confident you are that the criminal justice system as a whole: 
note CJP_proofburden: Treats those accused of crime as innocent until proven guilty. Please tell us how confident you are that the criminal justice system as a whole: 
note CJP_saferights: Guarantee the safety and human rights of people deprived of their liberty. Please tell us how confident you are that the criminal justice system as a whole:
note CTZ_gendereq_A: In [COUNTRY], equality between women and men is effectively guaranteed in all areas of public and private life, including employment, work and pay. Do you agree or disagree that gender equality is effectively guaranteed?
note CTZ_consrights_A: In [COUNTRY], consumer rights are effectively protected, including protection from fraudulent practices and defective or dangerous products, and the right to redress if these rights are violated. Do you agree or disagree that consumer rights protection is effective?
note CTZ_laborcond_A: In [COUNTRY], working conditions are good, including working time, work organization, health and safety at work, employee representation, and relation with the employer. Do you agree or disagree that working conditions are good?
note CTZ_envprotect_A: In [COUNTRY], the government carries out effective actions to protect the environment and prevent and respond to climate change and displacement. Do you agree or disagree that the government's environmental protection and climate response actions are effective?
note CTZ_euvalues_A: In [COUNTRY], the core values of the EU, such as fundamental rights, democracy, and the rule of law are well protected. Do  you agree or disagree that the core values of the EU are well protected?
note CTZ_headgovteval_A: Speaking in general of the current administration, how would you rate the job performance of President/Prime Minister [NAME CURRENT PRESIDENT/PRIME MINISTER]? 
note CTZ_localgovteval_A: Speaking in general of the current administration, how would you rate the job performance of local authorities (Metropolitan, Municipal, or District administration)? 
note PAB_censorinfo: censor information from abroad. Do you agree or disagree that censoring information from abroad is a concerning practice?
note PAB_censorvoices: censor opposition voices domestically. Do you agree or disagree that censoring domestic opposition voices is a concerning practice?
note PAB_blamesoc: blame different members or groups of society for domestic problems. Do you agree or disagree that blaming various societal groups for domestic issues is a concerning practice?
note PAB_blameext: blame external forces (i.e., other countries, regional or international governing bodies) for domestic problems. Do you agree or disagree that blaming external forces for domestic problems is a concerning practice?
note PAB_freecourts: seek to limit the courts' competences and freedom to interpret the law. Do you agree or disagree that seeking to limit the courts' authority and interpretative freedom is a concerning practice?
note PAB_overcourts: refuse to comply with court rulings that are not in their favor. Do  you agree or disagree that refusing to comply with court rulings unfavorable to them is a concerning practice?
note PAB_judgeprom: seek to influence the promotion and removal of judges. Do you agree or disagree that seeking to influence the appointment and dismissal of judges is a concerning practice?
note PAB_attackopp: attack or discredit opposition parties. Do you agree or disagree that attacking or discrediting opposition parties is a concerning practice?
note PAB_prosecuteopp: prosecute and convict members of opposition parties. Do you agree or disagree that prosecuting and convicting members of opposition parties is a concerning practice?
note CTZ_accountability_A: Assume that a high-ranking government official is taking government money for personal benefit. Assume that one of his employees witnesses this conduct, reports it to the relevant authority, and provides sufficient evidence to prove it. Assume that the press obtains the information and publishes the story. Which one of the following outcomes is most likely?
note LEP_safecom: The police in [COUNTRY] resolve the safety problems in your community. Do  you agree or disagree that the police effectively address safety concerns in your community?
note LEP_safefam: The police in [COUNTRY] help you and your family to feel safe within and outside of your house. Do you agree or disagree that the police contribute to your family's sense of safety at home and in your neighborhood?
note LEP_policehelp: The police in [COUNTRY] are available to help you when you need it. Do you agree or disagree that the police are accessible and responsive when you require assistance? 
note LEP_kindpol: The police in [COUNTRY] treat all people with kindness and respect. Do you agree or disagree that the police treat all individuals with kindness and respect?
note LEP_indpolinv: Police investigators in [COUNTRY] investigate crimes in an independent manner and are not subject to any sort of pressure. Do you agree or disagree that police investigators conduct independent and unbiased crime investigations?
note LEP_indprosecutors: Prosecutors in [COUNTRY] prosecute crimes committed in an independent manner and are not subject to any sort of pressure. Do you agree or disagree that prosecutors handle criminal cases independently and without external influence?
note LEP_polservpeopl: The police in [COUNTRY] serve the interests of people like you. Do  you agree or disagree that the police serve the interests of individuals in your community, including people like you?
note LEP_polservcom: The police in [COUNTRY] serve the interests of your community. Do you agree or disagree that the police serve the interests of your local community?
note JSE_rightsaware: People are aware of their rights when they face a legal problem. Do you agree or disagree that people are informed about their legal rights when dealing with legal issues?
note JSE_access2info: People know where to get information and advice when they face a legal problem. Do you agree or disagree that people know where to seek information and guidance when encountering legal issues?
note JSE_access2assis: People have access to affordable legal assistance and representation when they face a legal problem. Do you agree or disagree that individuals have access to reasonably priced legal assistance and representation when dealing with legal matters?
note JSE_affordcosts: People can easily meet the costs of turning to a state dispute resolution mechanism (courts, small claims courts, administrative agencies, etc.) when they face a legal problem. Do you agree or disagree that people can afford the expenses associated with using state dispute resolution mechanisms for legal issues?
note JSE_quickresol: Civil and commercial courts adjudicate disputes quickly (starting from the moment the case is filed to the moment a decision or agreement is reached). Do you agree or disagree that civil and commercial courts efficiently resolve disputes from the moment they are filed until decisions are reached?
note JSE_fairoutcomes: State dispute resolution mechanisms (courts, small claims courts, administrative agencies, etc.) produce fair outcomes for each involved party. Do  you agree or disagree that state dispute resolution mechanisms in provide equitable outcomes for all parties involved?
note JSE_equality: All parties are treated equally and fairly within the civil justice system. Do you agree or disagree that all parties are treated with equality and fairness within the civil justice system?
note JSE_freecorr: Local courts are free of corruption. Do you agree or disagree that local courts are free from corrupt practices?
note JSE_polinfluence: Local courts are free of political influence in their application of power. Do you agree or disagree that local courts are not subject to political influence in their actions?
note JSE_indjudges: Judges in [COUNTRY] decide cases in an independent manner and are not subject to any sort of pressure. Do you agree or disagree that judges make independent decisions and are not influenced by external pressures?
note JSE_fairtrial: Local courts guarantee everyone a fair trial. Do you agree or disagree that local courts ensure a fair trial for all individuals?
note JSE_enforce: Winning parties can enforce court decisions quickly and effectively. Do you agree or disagree that winning parties can efficiently and effectively enforce court decisions?
note JSE_mediation: People can easily turn to alternative justice mechanisms (mediation, arbitration, restorative justice, etc.) when they face a legal problem. Do you agree or disagree that people in can readily access alternative methods of justice, such as mediation or arbitration, when dealing with legal issues?
note CTZ_gendereq_B: In [COUNTRY], equality between women and men is effectively guaranteed in all areas of public and private life, including employment, work and pay. Do you agree or disagree that equality between women and men is effectively ensured in all aspects of public and private life?
note CTZ_consrights_B: In [COUNTRY], consumer rights are effectively protected, including protection from fraudulent practices and defective or dangerous products, and the right to redress if something goes wrong. Do you agree or disagree that consumer rights are effectively safeguarded?
note CTZ_laborcond_B: In [COUNTRY], working conditions are good, including working time, work organization, health and safety at work, employee representation, and relation with the employer. Do you agree or disagree that working conditions?
note CTZ_envprotect_B: In [COUNTRY], the government carries out effective actions to protect the environment and prevent and respond to climate change and displacement. Do you agree or disagree that the government effectively undertakes actions?
note CTZ_euvalues_B: In [COUNTRY], the core values of the EU, such as fundamental rights, democracy, and the rule of law are well protected. Do you agree or disagree that the core values of the EU, are effectively preserved?
note CTZ_headgovteval_B: Speaking in general of the current administration, how would you rate the job performance of President/Prime Minister [NAME CURRENT PRESIDENT/PRIME MINISTER]? 
note CTZ_localgovteval_B: Speaking in general of the current administration, how would you rate the job performance of local authorities (Metropolitan, Municipal, or District administration)? 
note CTZ_gendereq: In [COUNTRY], equality between women and men is effectively guaranteed in all areas of public and private life, including employment, work and pay. Do you agree or disagree that the core values of the EU, such as fundamental rights, democracy, and the rule of law, are effectively preserved?
note CTZ_consrights: In [COUNTRY], consumer rights are effectively protected, including protection from fraudulent practices and defective or dangerous products, and the right to redress if something goes wrong. Do you agree or disagree that consumer rights are effectively safeguarded?
note CTZ_laborcond: In [COUNTRY], working conditions are good, including working time, work organization, health and safety at work, employee representation, and relation with the employer. Do you agree or disagree that working conditions are favorable?
note CTZ_envprotect: In [COUNTRY], the government carries out effective actions to protect the environment and prevent and respond to climate change and displacement. Do you agree or disagree that the government effectively undertakes actions?
note CTZ_euvalues: In [COUNTRY], the core values of the EU, such as fundamental rights, democracy, and the rule of law are well protected. Do you agree or disagree that the core values of the EU, such as fundamental rights, democracy, and the rule of law, are effectively preserved?
note CTZ_headgovteval: Speaking in general of the current administration, how would you rate the job performance of President/Prime Minister [NAME CURRENT PRESIDENT/PRIME MINISTER]? 
note CTZ_localgovteval: Speaking in general of the current administration, how would you rate the job performance of local authorities (Metropolitan, Municipal, or District administration)? 
note PAB_misinfo: use misinformation to shape public opinion in their favor.  Do you agree or disagree that misinformation is employed to influence public opinion in favor of certain entities?
note PAB_distract: generate distractions from important issues and blame external enemies or internal traitors. Do you agree or disagree that distractions are created from critical matters while attributing domestic problems to external enemies or internal traitors?
note PAB_credibility: deny criticisms and facts, and undermine the credibility of those presenting them.  Do you agree or disagree that criticisms and facts are denied and the credibility of those presenting them is undermined?
note PAB_centralize: seek to centralize government functions and remove autonomy. Do you agree or disagree that efforts are made to centralize government functions and reduce autonomy of local authorities?from local authorities. 
note PAB_attackmedia: attack or discredit the media and civil society organizations that criticize them.  Do you agree or disagree that the media and civil society organizations that critique certain entities are targeted and discredited?
note PAB_prosecutejourn: prosecute and convict journalists and leaders of civil society organizations that criticize them. Do you agree or disagree that journalists and leaders of civil society organizations who criticize certain entities are prosecuted and convicted?
note PAB_emergpower: use emergency powers to bypass institutional checks and balances. Do you agree or disagree that emergency powers are utilized to circumvent institutional checks and balances?
note PAB_attackelect: attack or discredit the electoral system and the electoral supervisory organs. Do you agree or disagree that the electoral system and its supervisory organs are attacked or discredited?
note PAB_manipulelect: manipulate the election process to win power. Do you agree or disagree that the election process is manipulated to secure power?
note CTZ_accountability_B: Assume that a high-ranking government official is taking government money for personal benefit. Assume that one of his employees witnesses this conduct, reports it to the relevant authority, and provides sufficient evidence to prove it. Assume that the press obtains the information and publishes the story. Which one of the following outcomes is most likely?
note CTZ_accountability: Assume that a high-ranking government official is taking government money for personal benefit. Assume that one of his employees witnesses this conduct, reports it to the relevant authority, and provides sufficient evidence to prove it. Assume that the press obtains the information and publishes the story. Which one of the following outcomes is most likely?
note ROL_equality_sig: The same laws and rules apply equally to every person, including all public authorities, irrespective of their personal circumstances, social status, wealth, political connections or origin
note ROL_indcontrols_sig: There are independent controls to ensure that laws can be challenged and tested.
note ROL_abusepower_sig: Public officials and politicians do not use their positions to obtain benefits for themselves or their family members but take decisions in the public interest
note ROL_corruption_sig: Corruption involving public officials and politicians is properly investigated and those responsible are brought to justice
note ROL_constprotection_sig: If your rights are not respected, you can have them upheld by an independent court
note ROL_courtrulings_sig: Public authorities and politicians respect and apply court rulings
note ROL_freespeech_sig: Media and civil society organizations can operate freely and criticize the government or major economic interests without risk of intimidation
note ROL_indgovtbodies_sig: Public authorities respect the competences, mandates, and legal powers of independent government bodies or other autonomous authorities.  
note ROL_csoinput_sig: Public authorities respect the media, civil society organizations, and opposition groups and welcome their input. 
note ROL_civilobedience_sig: Citizens obey the government in power, regardless of who they voted for. 
note ROL_equality_imp: The same laws and rules apply equally to every person, including all public authorities, irrespective of their personal circumstances, social status, wealth, political connections or origin
note ROL_indcontrols_imp: There are independent controls to ensure that laws can be challenged and tested.
note ROL_abusepower_imp: Public officials and politicians do not use their positions to obtain benefits for themselves or their family members but take decisions in the public interest
note ROL_corruption_imp: Corruption involving public officials and politicians is properly investigated and those responsible are brought to justice
note ROL_constprotection_imp: If your rights are not respected, you can have them upheld by an independent court
note ROL_courtrulings_imp: Public authorities and politicians respect and apply court rulings
note ROL_freespeech_imp: Media and civil society organizations can operate freely and criticize the government or major economic interests without risk of intimidation
note ROL_indgovtbodies_imp: Public authorities respect the competences, mandates, and legal powers of independent her autonomous authorities.  
note ROL_csoinput_imp: Public authorities respect the media, civil society organizations, and opposition groups and welcome their input. 
note ROL_civilobedience_imp: Citizens obey the government in power, regardless of who they voted for. 
note KNW_rol_1: Rule of law. Could you please tell me the first three words that come to your mind when you hear
note KNW_rol_2: Rule of law. Could you please tell me the first three words that come to your mind when you hear
note KNW_rol_3: Rule of law. Could you please tell me the first three words that come to your mind when you hear
note KNW_rol_98: Rule of law. Could you please tell me the first three words that come to your mind when you hear
note KNW_rol_99: Rule of law. Could you please tell me the first three words that come to your mind when you hear
note KNW_justice_1: Justice. Could you please tell me the first three words that come to your mind when you hear
note KNW_justice_2: Justice. Could you please tell me the first three words that come to your mind when you hear
note KNW_justice_3: Justice. Could you please tell me the first three words that come to your mind when you hear
note KNW_justice_98: Justice. Could you please tell me the first three words that come to your mind when you hear
note KNW_justice_99: Justice. Could you please tell me the first three words that come to your mind when you hear
note KNW_governance_1: Governance. Could you please tell me the first three words that come to your mind when you hear
note KNW_governance_2: Governance. Could you please tell me the first three words that come to your mind when you hear
note KNW_governance_3: Governance. Could you please tell me the first three words that come to your mind when you hear
note KNW_governance_98: Governance. Could you please tell me the first three words that come to your mind when you hear
note KNW_governance_99: Governance. Could you please tell me the first three words that come to your mind when you hear
note relig: What is your religious preference? Are you… 
note ethni: What is your racial-ethnic background? Are you… 
note ethni_groups: What is your racial-ethnic background? Are you… 
note nation: What is your current nationality? Are you…
note fin: Which of the following statements best describes your household's financial situation?
note edu: What is the highest degree you have received?
note emp: In the past week, have you:
note work: In your work or business last week, were you …?
note wagreement: Were you employed on the basis of …?
note marital: What is your marital status?
note mcertificate: Do you have a marriage certificate?
note disability: Do you have any physical or mental health conditions or  illnesses lasting or expected to last for 12 months or more?
note disability2: Can you tell me whether they were physical or mental health conditions or illnesses? 
note politics: How interested are you in politics?
note polid: In political matters, people talk of "the left" and "the right." On a scale of 1 to 10, with 10 being the furthest "right" and 1 being the furthest "left," where would you place your views?
note voteintention: If there were a general election this weekend, which party would you support? 
note incpp: Is the aforementioned political party the incumbent political party?
note A1: How many people live in this home?
note A2: Are you a beneficiary of or do you receive money from government programs such as scholarships, assistance for single mothers, seniors, disability benefits, etc.?
note A3: How frequently do you use the internet?
note A4: Do you have a mobile phone?
note A5_1: Do you have a birth certificate? 
note A5_2: Do you have government issued ID card? 
note A5b: Does your household have any of the following documents for your current dwelling: a title, deed, certificate of ownership, rental contract, or lease?
note A5c: Which ones?
note A6: Does your home have an internet connection? 
note A7: Of all people that live in this house and that are over 15 years old, how many worked during the last month?
note income2: Thank you very much for your time. To confirm the information you provided at the beginning, could you please tell me the total [MONTHLY] income of your household from all sources? This includes wages, net income from a business, pensions, dividends, rents, remittances, or any other type of income received by any household member.
note PSU: Primary Sampling unit
note SSU: Secondary sampling unit
note interview_length: Length of interview in minutes
note city: City where the respondent lives
note region: Region of the country in which the interview took place (Administrative Unit)
note urban: Type of area in which the respondent lives
note B1: Identify the particular type of housing
note B2: Was another person present during the interview?
note B3: Was this person from the same home, a neighbor, or another party who was monitoring the the interview?
note qpi1: Did you feel threatened during the interview?
note qpi2a: What was the respondent's attitude toward you during the interview?
note qpi2b: What was the respondent's attitude toward you during the interview?
note qpi2c: What was the respondent's attitude toward you during the interview?
note qpi2d: What was the respondent's attitude toward you during the interview?
note qpi2e: What was the respondent's attitude toward you during the interview?
note qpi2f: What was the respondent's attitude toward you during the interview?
note qpi3a: Garbage in the street or the sidewalk
note qpi3b: Potholes in the street
note qpi3c: Graffiti or marks drawn by gangs on the walls
note qpi3d: Lack of utilities poles
note COLOR: When the interview is complete, WITHOUT asking, please use the color chart and select the number that most closely corresponds to the color of the face of the respondent. See Color Palette 
note dweight: design weight
note Strata: Stratification variable
