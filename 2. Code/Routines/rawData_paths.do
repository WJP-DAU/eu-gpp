cls

/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		Raw Data paths
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
				Natalia Rodriguez 	(nrodriguez@worldjusticeproject.org)
				Santiago Pardo		(spardo@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	October, 2023

Description:
Local paths to the EU-GPP raw data

=================================================================================================================*/

*--- Polling company
if inlist("${country_name}", "Croatia", "Latvia", "Lithuania", "Poland", "Romania") {
	global company "ACT (CR, LA, LT, RO, PL)"
	global multi "YES"
}
if inlist("${country_name}", "Bulgaria") {
	global company "Alpha Research (BL)"
	global multi "NO"
}
if inlist("${country_name}", "Austria", "Belgium", "Denmark", "Germany", "Italy", "Netherlands", "0_Bilendi") {
	global company "Bilendi & Respondi (AT, BE, DE, GE, NE, IT)"
	global multi "YES"
}
if inlist("${country_name}", "Greece") {
	global company "D3 Systems (GR)"
	global multi "NO"
}
if inlist("${country_name}", "Luxembourg") {
	global company "ILRES (LU)"
	global multi "NO"
}
if inlist("${country_name}", "Portugal") {
	global company "Intercampus (PT)"
	global multi "NO"
}
if inlist("${country_name}", "Czechia", "Estonia", "Finland", "France", "Slovenia", "Spain", "Sweden", "0_IPSOS") {
	global company "Ipsos (CZ, ET, FI, FR, SL, SW, SP)"
	global multi "YES"
}
if inlist("${country_name}", "Malta") {
	global company "Misco Malta (ML)"
	global multi "NO"
}
if inlist("${country_name}", "Cyprus") {
	global company "Pulse Market Research (CY)"
	global multi "NO"
}
if inlist("${country_name}", "Ireland") {
	global company "Red C Research (IR)"
	global multi "NO"
}
if inlist("${country_name}", "Hungary", "Slovakia") {
	global company "Talk Online (SK, HU)"
	global multi "YES"
}

*--- Data Stage
if inlist("${dataStage}", "1. PTR") {
	global path_aux = "Pretest Data"
}
if inlist("${dataStage}", "2. FFW") {
	global path_aux = "Final Data"
}


*--- RAW DATA PATH
if inlist("${country_name}", "0_Bilendi", "0_IPSOS") {
	if inlist("${dataStage}", "1. PTR") {
		global path_aux = "05. Pretest Data"
	}
	if inlist("${dataStage}", "2. FFW") {
		global path_aux = "06. Final Data"
	}
	global RD_path "${path2SP}/EU Subnational GPP/Polling Companies/${company}/${path_aux}/Original"
}
else if inlist("${multi}", "YES") {
	global RD_path "${path2SP}/EU Subnational GPP/Polling Companies/${company}/${country_name}/${path_aux}/Original"
}
else {
	global RD_path "${path2SP}/EU Subnational GPP/Polling Companies/${company}/${path_aux}/Original"
}

