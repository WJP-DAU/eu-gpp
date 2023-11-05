/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Range Checks
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
				Santiago Pardo		(spardo@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:

This dofile runs a set of checks to verify that all values from the submitted data fall within their expected 
range.

=================================================================================================================*/

/*=================================================================================================================
					Grouping variables by scale range
=================================================================================================================*/

*--- Scale 2
global scale2 ///
	q6a q6b q6c q6d q6e q7a q7b q7c q7d q7e q12a q12b q12c q12d q12e q12f q12g q12h q13a q13b q13c q13d q13e ///
	q13f q13g q13h q13i q13j q13k q14_1 q14_2 q14_3 q14_4 q14_5 q14_6 q14_7 q14_8 q14_9 q14_10 q14_11 q14_12 ///
	q14_98 q14_99 q18a q18b q19 q20 q22 q24 q28a q28b q28c q28d q28e q28f q28g q32a q32b q32c q33c q38a q38b ///
	q38c q38d q38g q38h q40_G2 q41_G2 q42_G2 nation wagreement mcertificate disability A2 A4 A5_1 A5_2 A5b A6 
foreach x of varlist $scale2 {
	qui inspect `x' if !inlist(`x',1,2,98,99)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 2 without DKNA
global scale2dkna ///
	q15_A1 q15_A2 q15_A3 q15_B1 q15_B2 q15_B3 q15_B4 q15_C1 q15_C2 q15_C3 q15_C4 q15_D1 q15_D2 q15_D3 q15_D4 ///
	q15_D5 q15_D6 q15_E1 q15_E2 q15_E3 q15_F1 q15_F2 q15_G1 q15_G2 q15_G3 q15_H1 q15_H2 q15_H3 q15_I1 q15_J1 ///
	q15_J2 q15_J3 q15_J4 q15_K1 q15_K2 q15_K3 q15_L1 q15_L2 q21_1 q21_2 q21_3 q21_4 q21_5 q21_6 q21_7 q21_8 ///
	q21_9 q21_98 q21_99 q36_1 q36_2 q36_3 q36_4 q36_5 q36_6 q36_7 q36_8 q36_98 q36_99 Urban B2 qpi1 
foreach x of varlist $scale2dkna {
	qui inspect `x' if !inlist(`x',1,2)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 3
global scale3 ///
	q29a q29b q29c q29d q29e q29f q29g q33a q57_G1 q57_G2 q59a q59b q59c q59d q59e q59f q59g q59h q59i ///
	q59j disability2 A5c 
foreach x of varlist $scale3 {
	qui inspect `x' if !inlist(`x',1,2,3,98,99)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 3 without DKNA
global scale3dkna qpi2a qpi2b qpi2c qpi2d qpi2e qpi2f 
foreach x of varlist $scale3dkna {
	qui inspect `x' if !inlist(`x',1,2,3)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 4
global scale4 ///
	gend q1a q1b q1c q1d q1e q1f q1g q1h q1i q1j q1k q2a q2b q2c q2d q2e q2f q3a q3b q3c q3d q3e q3f q3g ///
	q3h q3i q3j q3k q4a q4b q4c q4d q4e q4f q8a q8b q8c q8d q9a q9b q9c q9d q10 q11 q26 q30 q33d q34 q35 ///
	q37a q37b q37c q37d q39a_G1 q39b_G1 q39c_G1 q39d_G1 q39e_G1 q39f_G1 q39g_G1 q39h_G1 q39i_G1 q39j_G1 ///
	q40_G1 q41_G1 q42_G1 q39a_G2 q39b_G2 q39c_G2 q39d_G2 q39e_G2 q39f_G2 q39g_G2 q39h_G2 q39i_G2 q39j_G2 ///
	q43a_G1 q43b_G1 q43c_G1 q43d_G1 q43e_G1 q43f_G1 q43g_G1 q43h_G1 q43i_G1 q44a_G1 q44b_G1 q44c_G1 ///
	q44d_G1 q44e_G1 q44f_G1 q44g_G1 q44h_G1 q44i_G1 q44j_G1 q44k_G1 q45a_G1 q45b_G1 q45c_G1 q45d_G1 ///
	q45e_G1 q48_G1 q49_G1 q50_G1 q51_G1 q52_G1 q53_G1 q54_G1 q55_G1 q56_G1 q43a_G2 q43b_G2 q43c_G2 ///
	q43d_G2 q43e_G2 q43f_G2 q43g_G2 q43h_G2 q44a_G2 q44b_G2 q44c_G2 q44d_G2 q44e_G2 q44f_G2 q44g_G2 ///
	q44h_G2 q44i_G2 q44j_G2 q44k_G2 q44l_G2 q44m_G2 q45a_G2 q45b_G2 q45c_G2 q45d_G2 q45e_G2 q48_G2 ///
	q49_G2 q50_G2 q51_G2 q52_G2 q53_G2 q54_G2 q55_G2 q56_G2 q58a q58b q58c q58d q58e q58f q58g q58h ///
	q58i q58j politics qpi3a qpi3b qpi3c qpi3d  
foreach x of varlist $scale4 {
	qui inspect `x' if !inlist(`x',1,2,3,4,98,99)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 5
global scale5 income q5 q46_G1 q47_G1 q46_G2 q47_G2 fin marital A3 
foreach x of varlist $scale5 {
	qui inspect `x' if !inlist(`x',1,2,3,4,5,98,99)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 5 without DKNA
global scale5dkna B1 B3
foreach x of varlist $scale5dkna {
	qui inspect `x' if !inlist(`x',1,2,3,4,5)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 7
global scale7 q27 edu 
foreach x of varlist $scale7 {
	qui inspect `x' if !inlist(`x',1,2,3,4,5,6,7,98,99)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 8
global scale8 emp work 
foreach x of varlist $scale8 {
	qui inspect `x' if !inlist(`x',1,2,3,4,5,6,7,8,98,99)
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Scale 10
global scale10 q23 q31
foreach x of varlist $scale10 {
	qui inspect `x' if `x' < 1 | (`x' > 10 & `x' < 98) | `x' > 99
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

*--- Range 10
global range10 ///
	q16_A1 q16_A2 q16_A3 q16_B1 q16_B2 q16_B3 q16_B4 q16_C1 q16_C2 q16_C3 q16_C4 q16_D1 q16_D2 q16_D3 q16_D4 ///
	q16_D5 q16_D6 q16_E1 q16_E2 q16_E3 q16_F1 q16_F2 q16_G1 q16_G2 q16_G3 q16_H1 q16_H2 q16_H3 q16_I1 q16_J1 ///
	q16_J2 q16_J3 q16_J4 q16_K1 q16_K2 q16_K3 q16_L1 q16_L2 
foreach x of varlist $range10 {
	qui inspect `x' if `x' < 0 | (`x' > 10 & `x' < 98) | `x' > 99
	if r(N) > 0 {
		di as error "`x': " r(N) " obs falling outside expected range"
	}
}

/*=================================================================================================================
					Unique ranges
=================================================================================================================*/

*--- A7
qui inspect A7 if !inlist(A7,0,1,2,3,4,98,99)
if r(N) > 0 {
	di as error "A7: " r(N) " obs falling outside expected range"
}

*--- paff1
qui inspect paff1 if paff1 < 0 | (paff1 > 10 & paff1 < 98) | paff1 > 99
if r(N) > 0 {
	di as error "paff1: " r(N) " obs falling outside expected range"
}

*--- COLOR
qui inspect COLOR if COLOR < 1 | COLOR > 11
if r(N) > 0 {
	di as error "COLOR: " r(N) " obs falling outside expected range"
}

*--- q25
qui inspect q25 if q25 < 1 | (q25 > 11 & q25 < 98) | q25 > 99
if r(N) > 0 {
	di as error "q25: " r(N) " obs falling outside expected range"
}