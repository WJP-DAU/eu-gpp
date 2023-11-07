/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Value labels sets
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
				Santiago Pardo		(spardo@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:

This dofile labels the variable values so all labels are standardized across countries, polling companies and 
years.

=================================================================================================================*/

/*=================================================================================================================
					Common value labels sets
=================================================================================================================*/

*--- Binary YES/NO value label set
label define yn		1 "Yes"			///
					2 "No"			///
					98 "Don't know"	///
					99 "No answer", replace
foreach x in ///
	BRB_* SEC_* DIS_* AJP_*_bin AJD_* AJR_resolution AJR_*_bin ///
	AJR_fair AJR_slow AJR_expensive AJE_description_* AJE_health AJE_emotional AJE_income AJE_drugs ///
	AJE_healthcare AJE_hospital AJR_solvingcosts ///
	CP_* mcertificate disability incpp A2 A4 A5_* A5b A6 B2 qpi1 {
		
	label values `x' yn
}

*--- Trust value label set
label define trust	1 "A lot" 		///
					2 "Some" 		///
					3 "A little" 	///
					4 "No trust"	///
					98 "Don't know"	///
					99 "No answer", replace
foreach x in TRT_* {
	label values `x' trust
}

*--- Acceptance value label set
label define acc	1 "Always acceptable" 		///
					2 "Usually acceptable" 		///
					3 "Sometimes acceptable"	///
					4 "Not acceptable" 			///
					98 "Don't know"				///
					99 "No answer", replace
foreach x in ATC_* {
	label values `x' acc
}

*--- Corruption value label set
label define cor	1 "None" 			///
					2 "Some of them" 	///
					3 "Most of them"	///
					4 "All of them" 	///
					98 "Don't know"		///
					99 "No answer", replace
foreach x in COR_* {
	label values `x' cor
}

*--- Agreement value label set
label define agree	1 "Strongly agree" 		///
					2 "Agree" 				///
					3 "Disagree" 			///
					4 "Strongly disagree"	///
					98 "Don't know"			///
					99 "No answer", replace
foreach x in ORC_* IPR_* ///
	AJE_legalrights AJE_infosource AJE_advice AJE_fairoutcome ///
	CPA_* CPB_* LEP_* CTZ_* PAB_* JSE_* {
		
	label values `x' agree
}

*--- Likeliness value label set
label define likely	1 "Very likely" 	///
					2 "Likely" 			///
					3 "Unlikely" 		///
					4 "Very unlikely"	///
					98 "Don't know"		///
					99 "No answer", replace
foreach x in IRE_* {
	label values `x' likely
}

*--- Satisfaction value label set 
label define satis	1 "Very satisfied" 		///
					2 "Satisfied" 			///
					3 "Dissatisfied" 		///
					4 "Very dissatisfied" 	///
					98 "Don't know"			///
					99 "No answer", replace
foreach x in AJR_satis_ongoing AJR_satis_outcome {
	label values `x' satis
}

*--- Confidence value label set 
label define confid	1 "Very confident" 			///
					2 "Fairly confident" 		///
					3 "Not very confident" 		///
					4 "Not at all confident"	///
					98 "Don't know"				///
					99 "No answer", replace
foreach x in CJP_* {
	label values `x' confid
}

*--- Safety value label set
label define safe	1 "Very safe" 		///
					2 "Safe" 			///
					3 "Unsafe" 			///
					4 "Very unsafe"		///
					98 "Don't know"		///
					99 "No answer", replace
foreach x in SEC_walking SEC_home {
	label values `x' safe
}

*--- Problem done/ongoing value label set 
label define done 	1 "Ongoing" 							///
					2 "Too early to say"					/// 
					3 "Done with, but problem persists" 	///
					4 "Done with, problem fully resolved" 	///
					98 "Don't know"							///
					99 "No answer", replace
foreach x in AJR_state_noresol AJR_state_resol {
	label values `x' done
}

*--- Contact value label set
label define contact	1 "Myself (or someone on my behalf)"	///
						2 "The other party"						///
						3 "Someone else"						///
						98 "Don't know"							///
						99 "No answer", replace
foreach x in AJR_*_contact {
	label values `x' contact
}

*--- Rating value label set 
label define rate	1 "Very Good" 					///
					2 "Good"						/// 
					3 "Neither good nor bad (fair)"	///
					4 "Bad" 						///
					5 "Very Bad"		 			///
					98 "Don't know"					///
					99 "No answer", replace
foreach x in CTZ_headgovteval_* CTZ_localgovteval_* CTZ_headgovteval CTZ_localgovteval {
	label values `x' rate
}

*--- Accountability value label set 
label define account	1 "The accusation is completely ignored by the authorities"			 	///
						2 "An investigation is opened, but it never reaches any conclusions"	///
						3 "The high-ranking government officer is prosecuted and punished"  	///
						98 "Don't know"	 ///
						99 "No answer", replace
foreach x in CTZ_accountability_* CTZ_accountability {
	label values `x' account
}

*--- Importance value label set 
label define imp	1 "Essential"				///
					2 "Important"				///
					3 "Not so important"		///
					4 "Not important at all"	///
					98 "Don't know"				///
					99 "No answer", replace
foreach x in ROL_*_sig {
	label values `x' imp
}

*--- Need for improvement value label set 
label define improv 	1 "Yes"						///
						2 "Maybe, somewhat"			///
						3 "No, it's already fine"	///
						98 "Don't know"	 			///
						99 "No answer", replace
foreach x in ROL_*_imp {
	label values `x' improv
}

*--- Post-survey description value label set
label define psdesc	1 "Not at all" 	///
					2 "Little" 		///
					3 "Somewhat" 	///
					4 "Very much" 	///
					98 "Don't know"	///
					99 "No answer", replace
foreach x in qpi3* {
	label values `x' psdesc
}
						
*--- Correcting
foreach x in CPA_protest CPA_consultation CPA_cso CPB_protest CPB_consultation CPB_cso {
	label values `x' yn
}

/*=================================================================================================================
					Unique value labels sets
=================================================================================================================*/

*--- Gender
label define gend	1 "Male"		///
					2 "Female"		///
					3 "Nonbinary"	///
					4 "Do not recognize yourself in the above categories", replace

*--- COR_3year_change
label define COR_3year_change	1 "Significantly increased"	///
								2 "Increased"				///
								3 "Remained the same"		///
								4 "Decreased"				///
								5 "Significantly decreased"	///
								98 "Don't know"				///
								99 "No answer", replace

*--- AJD_noadvice_reason
label define AJD_noadvice_reason	1 "I thought the issue was not important or not difficult to resolve" ///
									2 "Thought the other side was right" ///
									3 "I did not think I needed advice" ///
									4 "I was concerned about the financial cost" ///
									5 "I had received help with a problem before and did not find it useful" ///
									6 "I did not know who to call or where to get advice" ///
									7 "I did not know I could get advice for this problem" ///
									8 "Was scared to get advice" ///
									9 "Advisers were too far away or it would take too much time" ///
									10 "Other" ///
									98 "Don't know" ///
									99 "No answer", replace

*--- AJR_noresol_reason
label define AJR_noresol_reason 1 "I thought the problem was not important enough or easy to resolve" ///
								2 "I was confident I could resolve it by myself" ///
								3 "Resolving the problem would have taken a long time or a lot of bureaucratic procedures" ///
								4 "I did not have evidence or a strong case" ///
								5 "Scared of the consequences / The other party is much more powerful" ///
								6 "I did not know what to do, where to go, or how to do it" ///
								7 "Access problems (cost, distance, schedule, etc.)" ///
								8 "I did not trust the authorities" ///
								9 "It would create problems for my family or damage a relationship" ///
								10 "I caused the problem / It was up to the other party" ///
								11 "Other" ///
								98 "Don't Know" ///
								99 "No answer", replace

*--- AJR_costdiff
label define AJR_costdiff	1 "Very easy" 			///
							2 "Somewhat easy"		///	
							3 "Difficult"			///
							4 "Nearly impossible" 	///
							98 "Don't Know"			///
							99 "No answer", replace
								
*--- AJR_settle_noresol
label define AJR_settle_noresol	1 "Agreement between you and the other party" ///
								2 "The other party independently doing what you wanted" ///
								3 "You independently doing what the other party wanted" ///
								4 "The problem sorting itself out" ///
								5 "You moving away from the problem (e.g. moving homes, changing jobs)" ///
								6 "You and/or all other parties giving up trying to resolve the problem" ///
								7 "None of these" ///
								98 "Don't Know" ///
								99 "No answer", replace

*--- AJR_settle_resol
label define AJR_settle_resol	1 "A decision or intervention by a court or a formal authority" ///
								2 "Mediation or arbitration" ///
								3 "Action by another third party" ///
								4 "Agreement between you and the other party" ///
								5 "The other party independently doing what you wanted" ///
								6 "You independently doing what the other party wanted" ///
								7 "The problem sorting itself out" ///
								8 "You moving away from the problem (e.g. moving homes, changing jobs)" ///
								9 "You and/or all other parties giving up trying to resolve the problem" ///
								10 "None of these" ///
								98 "Don't Know" ///
								99 "No answer", replace

*--- AJR_outcome
label define AJR_outcome	1 "Mostly in my favor" 		///
							2 "Somewhat in my favor" 	///
							3 "Mostly not in my favor"	///
							98 "Don't know"				///
							99 "No answer", replace

*--- Nationality
label define nation	1 "National [Citizen]" 	///
					2 "Foreigner"			///
					98 "Don't know"			///
					99 "No answer", replace

*--- Financial Situation
label define fin 1 "Money is not enough even for basic necessities and buying clothes is difficult"	///
				 2 "Can buy basic products but buying clothes is difficult"	///
				 3 "Can buy basic products and clothes, but not long-term goods" ///
				 4 "Can buy long-term goods, but cannot buy expensive goods"	///
				 5 "Can afford sufficiently expensive goods"	///
				 98 "Don't know" ///
				 99 "No answer", replace

*--- ethni_groups
label define ethni_groups	1 "Main national ethnicity"	///
							2 "EU minor ethnicity"		///
							3 "Non-EU minor ethnicity", replace

*--- Education
label define edu 	1 "None" ///
					2 "Elementary School Diploma" 			///
					3 "Middle School Diploma" 				///
					4 "High School Diploma or equivalent" 	///
					5 "Bachelor's Degree"  					///
					6 "Graduate degree (Masters, P.h.D)" 	///
					7 "Vocational Education" 				///
					98 "Don't know" 						///
					99 "No Answer", replace

*--- Employment
label define emp 	1 "Worked" ///
					2 "Had work, but did not work" ///
					3 "Looked for work" ///
					4 "Studied" ///
					5 "Dedicated yourself to household tasks and the personal care of others in the house" ///
					6 "Were retired" ///
					7 "Were permanently incapable of working" ///
					8 "Did not work" ///
					98 "Don't Know" ///
					99 "No Answer", replace
*--- Work			
label define work 	1 "Government worker" 				///
					2 "Private sector worker" 			///
					3 "Independent professional"		///
					4 "Self-employed worker" 			///
					5 "Day laborer" 					///
					6 "Businessman or business women" 	///
					7 "Entrepreneur or business owner" 	///
					8 "Unpaid worker" 					///
					98 "Don't Know" 					///
					99 "No Answer", replace
*--- Work Agreement
label define wagreement 	1 "A written agreement"	///
							2 "An oral agreement" 	///
							98 "Don't know"			///
							99 "No answer", replace

*--- Marital
label define marital 	1 "Single" ///
						2 "Domestic partnership/living as married" ///
						3 "Married" ///
						4 "Divorced" ///
						5 "Widowed"  ///
						98 "Don't Know" ///
						99 "No Answer", replace

*--- Disability
label define disability2	1 "Physical" 	///
							2 "Mental" 		///
							3 "Both" 		///
							98 "Don't know"	///
							99 "No answer", replace

*--- Politics
label define politics	1 "Very interested"			///
						2 "Interested"				///
						3 "A little interested"		///
						4 "Not interested at all"	///
						98 "Don't know"				///
						99 "No answer", replace

*--- A3
label define A3	1 "Daily"					///
				2 "Several times a week"	///
				3 "Several times a month"	///
				4 "Rarely"					///
				5 "Never"					///
				98 "Don't know"				///
				99 "No answer", replace

*--- A5c
label define A5c	1 "A title, deed, or certificate of ownership"	///
					2 "A rental contract or lease"					///
					3 "Other"										///
					98 "Don't know"									///
					99 "No answer", replace

*--- A7
label define A7 0 "0" 1 "1" 2 "2" 3 "3" 4 "4 or more" 98 "Don't know" 99 "No answer", replace

*--- B1
label define B1 1 "Independent home" 2 "Apartment Building" 3 "Multi-family apartment/low-income housing unit" 4 "Unfinished housing" ///
				5 "Structure not built for housing", replace
				
*--- B3
label define B3 1 "From the same home" 2 "Neighbor" 3 "Someone monitoring" 4 "Other representative from a polling company (i.e. supervisor)" ///
				5 "Other (a friend, salesperson, etc.)", replace

*--- QP1 set
label define qpi2a 1 "Friendly" 2 "In between" 3 "Hostile", replace
label define qpi2b 1 "Interested" 2 "In between" 3 "Bored" , replace
label define qpi2c 1 "Cooperative" 2 "In between" 3 "Uncooperative", replace
label define qpi2d 1 "Patient" 2 "In between" 3 "Impatient", replace
label define qpi2e 1 "At ease" 2 "In between" 3 "Suspicious", replace
label define qpi2f 1 "Honest" 2 "In between" 3 "Misleading", replace

*--- Urban/Rural
label define urban 1 "Urban" 2 "Rural", replace	


*--- Applying unique values
foreach x of varlist gend COR_3year_change AJD_noadvice_reason AJR_noresol_reason AJR_costdiff AJR_settle_noresol AJR_settle_resol AJR_outcome ///
	nation fin ethni_groups edu emp work wagreement marital disability2 politics A3 A5c A7 B1 B3 qpi2* urban {
	
	label values `x' `x'
}