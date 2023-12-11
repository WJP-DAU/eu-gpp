/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Logic, routing and randomization checks
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
				Santiago Pardo		(spardo@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	June, 2023

Description:

This dofile runs a set of checks to verify the logic and routing of the submitted dataset

=================================================================================================================*/

/*=================================================================================================================
					Logic Checks
=================================================================================================================*/

*--- Age restriction:
di as result "Testing the age restriction"
qui inspect age if age < 18
if r(N) > 0 {
	di as error "Number of observations with age < 18: " r(N)
} 

*--- Is age a continous variable and not coded in ranges?
qui count if age > 45
if r(N) == 0{
	di as error "Age has no values above 45. Potentially coded as categorical."
}

*--- Problems mentioned and selected:

foreach x in A1 A2 A3 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4 D5 D6 E1 E2 E3 F1 F2 G1 G2 G3 H1 H2 H3 I1 J1 J2 J3 J4 K1 K2 K3 L1 L2 {
	recode AJP_`x'_bin (1 =1 ) (2 98 99 = .), g(aux_`x')
}

egen ndisputes=rowtotal(aux_A1-aux_L2)

di as result "Testing that respondents with no problem selected in fact didn't mention any legal problem"
qui count if ndisputes==0 & AJP_problem!="" 
if r(N) > 0 {
	di as error "Number of observations with a problem selected but no mentioned problems: " r(N)
}

di as result "Testing that respondents mentioned problems and do have a problem selected"
qui count if ndisputes>0 & AJP_problem=="" 
if r(N) > 0 {
	di as error "Number of observations with mentioned problems but no problem selected: " r(N)
}

gen none=0
	foreach x in A1 A2 A3 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4 D5 D6 E1 E2 E3 F1 F2 G1 G2 G3 H1 H2 H3 I1 J1 J2 J3 J4 K1 K2 K3 L1 L2 {
		replace none=none+1 if AJP_problem=="`x'" & AJP_`x'_bin!=1
}

di as result "Testing that the problem selected was mentioned"
qui inspect none 
if r(N_pos) > 0 {
	di as error "Number of observations with a problem selected that was not mentioned: " r(N_pos)
}

drop aux* ndisputes none

*--- Problem severity
local qset A1 A2 A3 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4 D5 D6 E1 E2 E3 F1 ///
	F2 G1 G2 G3 H1 H2 H3 I1 J1 J2 J3 J4 K1 K2 K3 L1 L2

foreach x in `qset' {
	
	di as result "Testing the routing rules in AJP_`x'"
	
	*--- Are there any severity for problems that were NOT mentioned?
	qui inspect AJP_`x'_sev if AJP_`x'_bin != 1
	
	if r(N) > 0 {
		di as error "AJP_`x'_bin:" r(N) " obs with incorrect routing (skip)"
	}
	
	*--- Are there problems that were mentioned but do not have reported severities?
	qui inspect AJP_`x'_sev
	local a = r(N)
	qui count if AJP_`x'_bin == 1
	local b = r(N)
	
	if `a' != `b'  {
		di as error "AJP_`x'_bin: check the NO-SKIP rule"
	}
}

*--- Problem selection rule:
di as result "Testing the problem selection rules"
local qset A1 A2 A3 B1 B2 B3 B4 C1 C2 C3 C4 D1 D2 D3 D4 D5 D6 E1 E2 E3 F1 ///
	F2 G1 G2 G3 H1 H2 H3 I1 J1 J2 J3 J4 K1 K2 K3 L1 L2	
	
*------(a) Did the person mentioned any problem with high severity?
g highseverity = 0
foreach x in `qset'  {
	replace highseverity = 1 if AJP_`x'_sev >= 4 & AJP_`x'_sev != .
}

*------ (b) Is Problem X elegible for this person?
foreach x in `qset'  {
	g elegible_`x' = (AJP_`x'_sev >= 4 & AJP_`x'_sev != .)
	replace elegible_`x' = 1 if AJP_`x'_sev != . & highseverity == 0
}

*------ (c) Are we having non-elegible problems selected?
foreach x in `qset' {
	qui count if AJP_problem == "`x'" & elegible_`x' == 0
	if r(N) > 0 {
		di as error "AJP_problem: Problem `x' has " r(N) " obs with unvalid selection"
	}
}

drop highseverity elegible_*

*--- Off-work time:
di as result "Testing the off-work time (q38e)"
qui inspect AJE_offwork_time if AJE_offwork_time > 365
if r(N) > 0 {
	di as error "Number of observations reporting being more than a year without work: " r(N)
} 

*--- Healthcare visits:
di as result "Testing the healthcare visits (q38g_1)"
qui inspect AJE_healthcare_visits if AJE_healthcare_visits > 100
if r(N) > 0 {
	di as error "Number of observations reporting more than 100 visits: " r(N)
} 

*--- Hospitalized time:
di as result "Testing the hospitalized time (q38h_1)"
qui inspect AJE_hospital_time if AJE_hospital_time > 365
if r(N) > 0 {
	di as error "Number of observations reporting being more than a year in the hospital: " r(N)
} 

*--- Household size:
di as result "Testing the household size (A1)"
qui inspect A1 if A1 > 15
if r(N) > 0 {
	di as error "Number of observations reporting a household size > 15: " r(N)
} 

*--- Checking for continous variables with 98s & 99":
foreach x of varlist AJR_solvingtime AJE_offwork_time AJE_income_loss AJE_healthcare_visits ///
	AJE_hospital_time income2 {
		
	qui inspect `x' if inlist(`x', 98, 99)
	if r(N) > 0 {
		di as error "Variable `x' has values that resemble DK/NA. Please double check that they ARE NOT"
	}
}

/*=================================================================================================================
					Routing Checks
=================================================================================================================*/

//------------------------------
//  CORRUPTION
//------------------------------

*--- Bribery Victimization
local qset "permit benefits id school health"
foreach x in  `qset' {
	
	di as result "Testing the routing rules in BRB_`x'"
	
	*--- We test the skip rule
	qui inspect BRB_`x'_B if BRB_`x'_A != 1
	
	if r(N) > 0 {
		di as error "BRB_`x'_B:" r(N) " obs with incorrect routing (skip)"
	}
	
	*--- We test the no-skip rule 
	qui inspect BRB_`x'_B
	local a = r(N)
	qui count if BRB_`x'_A == 1
	local b = r(N)
	
	if `a' != `b'  {
		di as error "BRB_`x'_B: check the NO-SKIP rule"
	}
}

//------------------------------
//  DISCRIMINATION
//------------------------------

di as result "Testing the routing rules in DIS_exp"

*--- Discrimination 
local qset "sex age health ethni migration ses location religion family gender politics"
local c = 1
foreach x in `qset' {
	recode DIS_`x' (1 = 1)(2 98 99 = .), g(aux_`c')
	local ++c
}

egen aux_t = rowtotal(aux_*)

*--- We test the skip rule
forvalues i=1/12 {
	qui inspect DIS_exp_`i' if aux_t == 0

if r(N) > 0 {
	di as error "DIS_exp_`i':" r(N) " obs with incorrect routing (skip)"
}
}

*--- We test the no-skip rule

forvalues i=1/12 {
	qui count if DIS_exp_`i'==. & aux_t>0
	if r(N) > 0 {
		di as error "DIS_exp_`i': check the NO-SKIP rule"
}
}

drop aux_*

//------------------------------
//  ACCESS TO JUSTICE
//------------------------------

*--- AJD_selfemployment (q18a) 
local qset "A1 A2 A3 B1 B2 B3 B4 C1 F1 I1 J4 K1 K2 K3 L1 L2" 

g aux1  = (inlist(AJP_problem, "A1", "A2", "A3", "B1", "B2", "B3", "B4", "C1"))
g aux2  = (inlist(AJP_problem, "F1", "I1", "J4", "K1", "K2", "K3", "L1", "L2"))
g aux_t = (aux1 == 1 | aux2 == 1)

*------ (a) We test the SKIP rule
qui inspect AJD_selfemployment if aux_t == 0
if r(N) > 0 {
	di as error "AJD_selfemployment: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect AJD_selfemployment
local a = r(N)
qui count if aux_t == 1
local b = r(N)

if `a' != `b' {
	di as error "AJD_selfemployment: check the NO-SKIP rule"
}

drop aux*


*--- AJD_inst_advice (q20) 

*------ (a) We test the SKIP rule (AJD_inst_advice == 2)
foreach x of varlist AJD_adviser_1 AJD_expert_adviser {
	qui inspect `x' if AJD_inst_advice == 2
	if r(N) > 0 {
		di as error "AJD_inst_advice: " r(N) " obs with incorrect routing (skip x == 2)"
	}
}
qui inspect AJD_noadvice_reason if AJD_inst_advice == 2
local a = r(N)
qui count if AJD_inst_advice == 2
local b = r(N)
if `a' != `b' {
	di as error "AJD_inst_advice: " r(N) " obs with incorrect routing (landing x == 2)"
}

*------ (b) We test the SKIP rule (AJD_inst_advice > 2)
foreach x of varlist AJD_adviser_1 AJD_expert_adviser AJD_noadvice_reason {
	qui inspect `x' if AJD_inst_advice == 98 | AJD_inst_advice == 99
	if r(N) > 0 {
		di as error "AJD_inst_advice: " r(N) " obs with incorrect routing (skip x > 2)"
	}
}
qui inspect AJR_resolution if AJD_inst_advice == 98 | AJD_inst_advice == 99
local a = r(N)
qui count if AJD_inst_advice == 98 | AJD_inst_advice == 99
local b = r(N)
if `a' != `b' {
	di as error "AJD_inst_advice: " r(N) " obs with incorrect routing (landing x > 2)"
}

*------ (c) We test the NO-SKIP rule (AJD_inst_advice == 1)
qui inspect AJD_adviser_1
local a = r(N)
qui count if AJD_inst_advice == 1
local b = r(N)

if `a' != `b' {
	di as error "AJD_inst_advice: check the NO-SKIP rule"
}

*------ (d) We test the NO-SKIP rule (AJD_inst_advice == 2)
qui inspect AJD_noadvice_reason
local a = r(N)
qui count if AJD_inst_advice == 2
local b = r(N)

if `a' != `b' {
	di as error "AJD_inst_advice: check the NO-SKIP rule"
}

*------ (e) Is everyone answering who answered AJD_inst_advice answering AJR_resolution?
qui inspect AJR_resolution
local a = r(N)
qui inspect AJD_inst_advice
local b = r(N)

if `a' != `b' {
	di as error "AJD_inst_advice: check the NO-SKIP rule"
}


*--- AJD_adviser_1 (q21_1)
*------ (a) We test the SKIP rule -- No need for testing the NO-SKIP
qui inspect AJD_expert_adviser if AJD_adviser_1 != 1
if r(N) > 0 {
	di as error "AJD_adviser_1: " r(N) " obs with incorrect routing (skip)"
}


*--- AJD_expert_adviser (q22)
*------ (a) We test the SKIP rule -- No need for testing the NO-SKIP
qui inspect AJD_noadvice_reason if AJD_expert_adviser != .
if r(N) > 0 {
	di as error "AJD_expert_adviser: " r(N) " obs with incorrect routing (skip)"
}


*--- AJR_resolution (q24)

*------ (a) We test the SKIP rule
qui inspect AJR_noresol_reason if AJR_resolution == 98 | AJR_resolution == 99
if r(N) > 0 {
	di as error "AJR_resolution: " r(N) " obs with incorrect routing (skip x > 2)"
}
foreach x of varlist AJR_noresol_reason AJR_state_noresol AJR_settle_noresol {
	qui inspect `x' if AJR_resolution == 1
	if r(N) > 0 {
		di as error "AJR_resolution: " r(N) " obs with incorrect routing (skip x == 1)"
	}
}

*------ (b) We test the NO-SKIP rule
qui inspect AJR_noresol_reason
local a = r(N)
qui count if AJR_resolution == 2
local b = r(N)

if `a' != `b' {
	di as error "AJR_resolution: check the NO-SKIP rule"
}		// People answering AJR_noresol_reason should be equal to AJR_resolution == 2

qui inspect AJR_state_noresol
local a = r(N)
qui count if inlist(AJR_resolution, 2, 98, 99)
local b = r(N)

if `a' != `b' {
	di as error "AJR_resolution: check the NO-SKIP rule"
}		// People answering AJR_state_noresol should be equal to AJR_resolution == 2 | 98 | 99


*--- AJR_state_noresol (q26)

*------ (a) We test the SKIP rule
foreach x of varlist AJR_settle_noresol AJR_court_bin AJR_court_contact AJR_police_bin AJR_police_contact ///
	AJR_office_bin AJR_office_contact AJR_relig_bin AJR_relig_contact AJR_arbitration_bin /// 
	AJR_arbitration_contact AJR_appeal_bin AJR_appeal_contact AJR_other_bin AJR_other_contact ///
	AJR_state_resol AJR_settle_resol AJR_fair AJR_slow AJR_expensive AJR_outcome AJR_solvingtime ///
	AJR_solvingcosts AJR_costdiff AJR_satis_outcome {
		
		di as result "Testing the routing rules in `x'"
		qui inspect `x' if inlist(AJR_state_noresol, 1, 2, 98, 99)
		if r(N) > 0 {
			di as error "AJR_state_noresol: " r(N) " obs with incorrect routing (skip)"
		}
	}

qui inspect AJR_satis_ongoing if inlist(AJR_state_noresol, 98, 99)
if r(N) > 0 {
	di as error "AJR_state_noresol: " r(N) " obs with incorrect routing (skip)"
} // Additional skipped variable for AJR_state_noresol == 98 | 99

*------ (b) We test the NO-SKIP rule
qui inspect AJR_settle_noresol
local a = r(N)
qui count if inlist(AJR_state_noresol, 3, 4)
local b = r(N)

if `a' != `b' {
	di as error "AJR_state_noresol: check the NO-SKIP rule"
}		// People answering AJR_settle_noresol should be equal to AJR_state_noresol == 3 | 4


*--- AJR_settle_noresol (q27)

*------ (a) We test the SKIP rule
foreach x in court police office relig arbitration appeal other {
	qui inspect AJR_`x'_bin if AJR_settle_noresol != .
	di as result "Testing the routing rules in AJR_`x'_bin"
	if r(N) > 0 {
		di as error "AJR_settle_noresol: " r(N) " obs with incorrect routing (skip)"
	}
}

*--- AJR_*_bin (q28)
local qset "court police office relig arbitration appeal other"
foreach x in `qset' {
	
	di as result "Testing the routing rules in AJR_`x'"
	
	*--- We test the skip rule
	qui inspect AJR_`x'_contact if AJR_`x'_bin != 1
	
	if r(N) > 0 {
		di as error "AJR_`x'_contact:" r(N) " obs with incorrect routing (skip)"
	}
	
	*--- We test the no-skip rule 
	qui inspect AJR_`x'_contact
	local a = r(N)
	qui count if AJR_`x'_bin == 1
	local b = r(N)
	
	if `a' != `b'  {
		di as error "AJR_`x'_contact: check the NO-SKIP rule"
	}
}

*--- AJR_state_resol (q30)

*------ (a) We test the SKIP rule
foreach x of varlist AJR_settle_resol AJR_fair AJR_slow AJR_expensive AJR_outcome AJR_solvingtime ///
	AJR_solvingcosts AJR_costdiff AJR_satis_outcome {
		
		di as result "Testing the routing rules in `x'"
		qui inspect `x' if inlist(AJR_state_resol, 1, 2, 98, 99)
		if r(N) > 0 {
			di as error "AJR_state_resol: " r(N) " obs with incorrect routing (skip)"
		}
	}

qui inspect AJR_satis_ongoing if inlist(AJR_state_resol, 98, 99)
if r(N) > 0 {
	di as error "AJR_state_resol: " r(N) " obs with incorrect routing (skip)"
} // Additional skipped variable for AJR_state_resol == 98 | 99

*------ (b) We test the NO-SKIP rule
qui inspect AJR_settle_resol
local a = r(N)
qui count if inlist(AJR_state_resol, 3, 4)
local b = r(N)

if `a' != `b' {
	di as error "AJR_state_noresol: check the NO-SKIP rule"
}		// People answering AJR_resol_reason should be equal to AJR_resolution == 2


*--- AJR_solvingcosts (q33c)

*------ (a) We test the SKIP rule
qui inspect AJR_costdiff if AJR_solvingcosts != 1
if r(N) > 0 {
	di as error "AJR_solvingcosts: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect AJR_costdiff
local a = r(N)
qui count if AJR_solvingcosts == 1
local b = r(N)

if `a' != `b' {
	di as error "AJR_solvingcosts: check the NO-SKIP rule"
}


*--- AJR_satis_outcome (q34)

*------ (a) We test the SKIP rule
qui inspect AJR_satis_ongoing if AJR_satis_outcome != .
if r(N) > 0 {
	di as error "AJR_satis_outcome: " r(N) " obs with incorrect routing (skip)"
}


*--- AJE_offwork_time - AJE_hospital_time (q38e-q38h_1)
local c = 1
local qset "health emotional income drugs offwork_time"
foreach x in `qset' {
	g aux_`c' = (AJE_`x' == 1)
	local ++c
}
egen aux_t = rowtotal(aux_*)	// We use this auxiliar variable to test the 
								// AJE_offwork_time - AJE_hospital_time set

local qset "offwork_time income_loss healthcare healthcare_visits hospital hospital_time"
foreach x in `qset' {
	qui inspect AJE_`x' if aux_t == 0 & aux_t != .
	if r(N) > 0 {
		di as error "AJE_`x': " r(N) " obs with incorrect routing (skip)"
	}
}

drop aux_*


*--- AJE_healthcare (q38g)

*------ (a) We test the SKIP rule
qui inspect AJE_healthcare_visits if AJE_healthcare != 1
if r(N) > 0 {
	di as error "AJE_healthcare: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect AJE_healthcare_visits
local a = r(N)
qui count if AJE_healthcare == 1
local b = r(N)

if `a' != `b' {
	di as error "AJE_healthcare: check the NO-SKIP rule"
}


*--- AJE_hospital (q38h)

*------ (a) We test the SKIP rule
qui inspect AJE_hospital_time if AJE_hospital != 1
if r(N) > 0 {
	di as error "AJE_hospital: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect AJE_hospital_time
local a = r(N)
qui count if AJE_hospital == 1
local b = r(N)

if `a' != `b' {
	di as error "AJE_hospital: check the NO-SKIP rule"
}

//------------------------------
//  DEMOGRAPHICS
//------------------------------

*--- EMP

*------ (a) We test the SKIP rule
foreach x of varlist work wagreement {
	qui inspect `x' if inlist(emp,3,4,5,6,7,8,98,99)
	if r(N) > 0 {
		di as error "emp: " r(N) " obs with incorrect routing (skip)"
	}
}

*------ (b) We test the NO-SKIP rule
qui inspect work
local a = r(N)
qui count if inlist(emp,1,2)
local b = r(N)

if `a' != `b' {
	di as error "emp: check the NO-SKIP rule"
}


*--- WORK

*------ (a) We test the SKIP rule
qui inspect wagreement if inlist(work,1,8)
if r(N) > 0 {
	di as error "work: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect wagreement
local a = r(N)
qui count if inlist(work,2,3,4,5,6,7,98,99)
local b = r(N)

if `a' != `b' {
	di as error "work: check the NO-SKIP rule"
}

*--- MARITAL

*------ (a) We test the SKIP rule
qui inspect mcertificate if inlist(marital,1,2,98,99)
if r(N) > 0 {
	di as error "marital: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect mcertificate
local a = r(N)
qui count if inlist(marital,3,4,5)
local b = r(N)

if `a' != `b' {
	di as error "marital: check the NO-SKIP rule"
}

*--- DISABILITY

*------ (a) We test the SKIP rule
qui inspect disability2 if inlist(disability,2,98,99)
if r(N) > 0 {
	di as error "disability: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect disability2
local a = r(N)
qui count if disability == 1
local b = r(N)

if `a' != `b' {
	di as error "disability: check the NO-SKIP rule"
}

*--- A5b

*------ (a) We test the SKIP rule
qui inspect A5c if inlist(A5b,2,98,99)
if r(N) > 0 {
	di as error "A5b: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect A5c
local a = r(N)
qui count if A5b == 1
local b = r(N)

if `a' != `b' {
	di as error "A5b: check the NO-SKIP rule"
}

*--- B2

*------ (a) We test the SKIP rule
qui inspect B3 if B2 == 2
if r(N) > 0 {
	di as error "B2: " r(N) " obs with incorrect routing (skip)"
}

*------ (b) We test the NO-SKIP rule
qui inspect B3
local a = r(N)
qui count if B2 == 1
local b = r(N)

if `a' != `b' {
	di as error "B2: check the NO-SKIP rule"
}

/*=================================================================================================================
					Randomization Checks
=================================================================================================================*/

count
local t = r(N) 

//------------------------------
//  CIVIC PARTICIPATION
//------------------------------

*--- Generating dummies
g b_CPA = (CPA_law_langaval != .)
g b_CPB = (CPB_compl_pservices != .)

*--- Generating values to test balance
tab b_CPA b_CPB, cell nofreq matcell(mat_CP) 
local a = mat_CP[2,1] / `t'
local b = mat_CP[1,2] / `t'

if abs(`a' - `b') > 0.1 {
	di as error "Unbalanced groups. Please check randomization in the Civic Participation module"
} 

local c = mat_CP[1,1] / `t'
if abs(`c') > 0 {
	di as error "`c'% of the sample DID NOT answered either option of the Civic Participation module"
} 
local d = mat_CP[2,2] / `t'
if abs(`d') > 0 {
	di as error "`d'% of the sample answered BOTH options of the Civic Participation module"
} 

//------------------------------
//  INSTITUTIONAL PERFORMANCE
//------------------------------

*--- Generating dummies
g b_IPA = (LEP_lawacts != .)
g b_IPB = (LEP_safecom != .)

*--- Generating values to test balance
tab b_IPA b_IPB, cell nofreq matcell(mat_IP)
local a = mat_IP[2,1] / `t'
local b = mat_IP[1,2] / `t'

if abs(`a' - `b') > 0.1 {
	di as error "Unbalanced groups. Please check randomization in the Institutional Performance module"
}

local c = mat_CP[1,1] / `t'
if abs(`c') > 0 {
	di as error "`c'% of the sample DID NOT answered either option of the Institutional Performance module"
} 
local d = mat_CP[2,2] / `t'
if abs(`d') > 0 {
	di as error "`d'% of the sample answered BOTH options of the Institutional Performance module"
} 

//------------------------------
//  RULE OF LAW
//------------------------------

*--- Generating dummies
g b_RLA = (KNW_rol_1 != "")
g b_RLB = (KNW_justice_1 != "")
g b_RLC = (KNW_governance_1 != "")

count
local t = r(N) 

*--- Generating values to test balance
tab b_RLA b_RLB, cell nofreq matcell(mat_RL1)
local a = mat_RL1[2,1] / `t'
local b = mat_RL1[1,2] / `t'
local c = mat_RL1[1,1] / `t'

if abs(`a' - `b') > 0.05 | abs(`a' - `c') > 0.05{
	di as error "Unbalanced groups. Please check randomization in the Rule of Law question"
} 

//------------------------------
//  CROSS CHECK
//------------------------------

tab b_CPA b_IPB, matcell(mat_cross1)
tab b_CPA b_RLC, matcell(mat_cross2)

foreach x in 1 2 {
	local a = mat_cross`x'[1,1]
	local b = mat_cross`x'[1,2]
	local c = mat_cross`x'[2,1]
	local d = mat_cross`x'[2,2]
	
	if `a' == 0 | `b' == 0 | `c' == 0 | `d' == 0 {
		di as error "Cross Randomization missed in breakpoint number " `x'
	}
}

drop b_*

