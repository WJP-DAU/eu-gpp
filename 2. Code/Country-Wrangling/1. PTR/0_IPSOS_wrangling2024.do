/*=================================================================================================================
Project:		EU Subnational 2023
Routine:		GPP Data Cleaning and Harmonization 2023 (IPSOS - Pretest)
Author(s):		Carlos Toruño 		(ctoruno@worldjusticeproject.org)
Dependencies:  	World Justice Project
Creation Date:	January, 2024

Description:
Data wrangling cleaning and harmonization routine for the IPSOS pretest data received on 16/01/2024.

This dofile follows the guidelines in the GPP Cleaning and Validation Protol for the EU-S Project. Please feel 
free to use the EU Copilot app (https://eu-copilot.streamlit.app/) to support your routine writing, consult the
protocol guidelines and use the interactive codebook tool.

=================================================================================================================*/

/*=================================================================================================================
					NUTS Regions variables
=================================================================================================================*/

/* Note:
	Admin division of countries (Variable REGION):
	-	Czechia is divided into 14 Regions, equivalent to NUTS-3
	-	Estonia (technically) is divided into 14 counties which are very small divisions, but these can be 
		aggregated into 5 regions which are equivalent to the NUTS-3 division (I guess that's fine)
	-	Finland is divided into 19 Regions, equivalent to NUTS-3
	-	France is divided into 13 Regions + Overseas territories, equivalent to NUTS-1 (needs adjustment)
	-	Slovenia is divided into 212 municipalities for admin purposes. However, statistical division is also used
		so a NUTS-3 division should be sufficient.
	-	Spain is divided into 19 regions, equivalent to NUTS-2 (needs adjustment)
	-	Sweden is divided into 21 regions, equivalent to NUTS-3
*/

#delim ;
recode Region 
	/* Czechia */
	(1 = 1 "Praha")(2 = 2 "Střední Čechy")(3/4 = 3 "Jihozápad")(5/6 = 4 "Severozápad")(7/9 = 5 "Severovýchod")
	(10/11 = 6 "Jihovýchod")(12/13 = 7 "Střední Morava")(14 = 8 "Moravskoslezsko")
	
	/* Estonia */
	(15/19 = 9 "Eesti")
	
	/* Finland */
	(20/24 = 10 "Länsi-Suomi")(25 = 11 "Helsinki-Uusimaa")(26/30 = 12 "Etelä-Suomi")(32/38 = 14 "Pohjois- ja Itä-Suomi")
	(31 = 13 "Åland")				/* Probably, ALAND is number 31!!! Not sure */
	
	/* France */
	(39/46 = 15 "Ile-de-France")(47/52 = 16 "Centre — Val de Loire")(53/60 = 17 "Bourgogne — Franche-Comté")
	(61/65 = 18 "Normandie")(66/70 = 19 "Hauts-de-France")(71/80 = 20 "Grand Est")(81/85 = 21 "Pays de la Loire")
	(86/89 = 22 "Bretagne")(90/101 = 23 "Nouvelle-Aquitaine")(102/114 = 24 "Occitanie")(115/126 = 25 "Auvergne-Rhône-Alpes")
	(127/132 = 26 "Provence-Alpes-Côte d'Azur")(133/134 = 27 "Corse")
	
	/* Slovenia */
	(135/142 = 28 "Vzhodna Slovenija")(143/146 = 29 "Zahodna Slovenija")
	
	/* Spain */
	(147/152 = 30 "Noroeste")(153/160 = 31 "Noreste")(161 = 32 "Comunidad de Madrid")(162/1 = 33 "Centro (ES)")
	(178/187 = 34 "Este")(188/198 = 35 "Sur")(199/205 = 36 "Canarias")
	
	/* Sweden */
	(206/211 = 37 "Östra Sverige")(212/219 = 38 "Södra Sverige")(220/226 = 39 "Norra Sverige")
	
	, g (nuts_ltn);

recode Region 
	/* Czechia */
	(1 = 1 "CZ01")(2 = 2 "CZ02")(3/4 = 3 "CZ03")(5/6 = 4 "CZ04")(7/9 = 5 "CZ05")
	(10/11 = 6 "CZ06")(12/13 = 7 "CZ07")(14 = 8 "CZ08")
	
	/* Estonia */
	(15/19 = 9 "EE0")
	
	/* Finland */
	(20/24 = 10 "FI19")(25 = 11 "FI1B")(26/30 = 12 "FI1C")(32/38 = 14 "FI1D")
	(31 = 13 "FI20")				/* Probably, ALAND is number 31!!! Not sure */
	
	/* France */
	(39/46 = 15 "FR1")(47/52 = 16 "FRB")(53/60 = 17 "FRC")
	(61/65 = 18 "FRD")(66/70 = 19 "FRE")(71/80 = 20 "FRF")(81/85 = 21 "FRG")
	(86/89 = 22 "FRH")(90/101 = 23 "FRI")(102/114 = 24 "FRJ")(115/126 = 25 "FRK")
	(127/132 = 26 "FRL")(133/134 = 27 "FRM")
	
	/* Slovenia */
	(135/142 = 28 "SI03")(143/146 = 29 "SI04")
	
	/* Spain *//* Spain */
	(147/152 = 30 "ES1")(153/160 = 31 "ES2")(161 = 32 "ES3")(162/1 = 33 "ES4")
	(178/187 = 34 "ES5")(188/198 = 35 "ES6")(199/205 = 36 "ES7")
	
	/* Sweden */
	(206/211 = 37 "SE1")(212/219 = 38 "SE2")(220/226 = 39 "SE3")
	
	, g(nuts_id);
	
#delim cr

replace Region = nuts_ltn if country == 4	/*France*/
recode Region /// España
	(147/150 = 1 "Galicia")(151 = 2 "Principado de Asturias")(152 = 3 "Cantabria")	///
	(153/155 = 4 "País Vasco")(156 = 5 "Navarra")(157 = 6 "La Rioja")(158/160 = 7 "Aragón")	///
	(161 = 8 "Madrid")(162/170 = 9 "Castilla y León")(171/175 = 10 "Castilla-La Mancha")	///
	(176/177 = 11 "Extremadura")(178/181 = 12 "Cataluña")(182/184 = 13 "Comunitat Valenciana")	///
	(185/187 = 14 "Illes Balears")(188/195 = 15 "Andalucía")(196 = 16 "Murcia")(197 = 17 "Ceuta")	///
	(198 = 18 "Melilla")(199/205 = 19 "Canarias")(else = 999 "Other"), g(Region_Spain)

/*=================================================================================================================
					Adding missing variables from the data map
=================================================================================================================*/

forvalues j = 1/3 {
	g q60_G`j'_98 = ""
	g q60_G`j'_99 = ""
}
foreach x in PSU SSU Strata {
	g `x' = ""
}
g COLOR = .
g dweight = .
forvalues j=1/3 {
	g B`j' = .
}
g qpi1 = .
foreach x in a b c d e f {
	g qpi2`x' = .
}
foreach x in a b c d {
	g qpi3`x' = .
}


/*=================================================================================================================
					Dropping variables added by the polling company
=================================================================================================================*/

replace relig = 99 if consent_relig == 2
replace ethni = 999 if consent_ethni == 2
replace disability = 99 if consent_disability == 2
replace paff1 = 99 if consent_politics == 2
drop consent_* Income2_check Age2 quota_q39
	
/*=================================================================================================================
					Renaming/Recoding variables
=================================================================================================================*/

foreach x of varlist nuts_ltn nuts_id country Region ethni relig paff2 Region_Spain {
	rename `x' `x'_aux
	decode `x'_aux, g(`x')
	drop `x'_aux
}
replace Region = Region_Spain if country == "Spain"
drop Region_Spain
rename LAU City
rename q36_97 q36_8
foreach x of varlist q60_G1_1 q60_G1_2 q60_G1_3 q60_G2_1 q60_G2_2 q60_G2_3 q60_G3_1 q60_G3_2 q60_G3_3 {
	rename `x'_99 `x'_99_aux
	decode `x'_99_aux, g(`x'_99)
	drop `x'_99_aux
	
	replace `x' = `x'_99 if `x'_99 != ""
	drop `x'_99
}

rename Politics politics

rename Urban degurba
recode degurba (1 = 2)(2/3 = 1), g(Urban)
drop degurba

rename income inc_sample
bys country: egen min_income_country = min(inc_sample)
g income = inc_sample - min_income_country + 1 if inc_sample < 98
decode inc_sample, g(income_text)
drop inc_sample min_income_country

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

/* Note:
	1. Two individuals answered reported to have been more than 365 days out of work in q38e. One answered 999.
	2. Question A1 should not have a "Prefer not to answer" option.
*/

g idorig = id

/*=================================================================================================================
					Comments on the quality checks
=================================================================================================================*/

/* Notes:
	1. 59 obs (16%) have more than 30 DK/NA values in the target variables.
	2. Unbalanced demographics.
	3. q12c, q12d, q39a_G1, q39i_G1, q39a_G2, q39b_G2, q54_G1, q44h_G2, q44l_G2, q44m_G2 have more than 25% of 
	valid answers as DK/NA.
		q12c (Estonia 49%)
		q12d (Estonia 42%)
		q39a_G1 (Czechia 48%)
		q39i_G1 (Czechia 48%, Finland 42%)
		q39a_G2 (Czechia 64%, Estonia 52%)
		q39b_G2 (Czechia 68%, Estonia 56%)
		q54_G1 (Estonia 44%)
		q44h_G2 (Czechia 48%, Estonia 42%)
		q44l_G2 (Czechia 43%, Finland 40%)
		q44m_G2 (Czechia 52%)
	4. 54 individuals answered the survey in less than 15 min.
		42% of France sample
		37% of Spain sample
		20% of Sweden sample
	5. 52 individuals have a high incidence of straight-lining across question sets.
		Spain: 14 (27%)
		Sweden: 10 (20%)
		ID =[137, 139, 165, 189, 204, 265, 276, 289, 291, 295, 296, 321] -> Straight-lining + speed flag
*/

/*=================================================================================================================
					SAVING
=================================================================================================================*/

/* Note:
	Please save the country wrangle routines within the "2. Code/Country-Wrangling/" folder
	in your local copy of the repository.
*
