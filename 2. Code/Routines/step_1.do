/*=================================================================================================================
Project:		EU Subnational
Routine:		STEP 1: File conversion and UTF-8 encoding
Author(s):		Carlos A. Toruño Paniagua
Dependencies:  	World Justice Project
Creation Date:	September, 2023

Description: 
This dofile is used to transform original datasets into DTA format and to check for their character encodings. This is Step 1 in the
EU-GPP cleaning and validation protocol.

=================================================================================================================*/

clear

*--- Changing working directory
cd "${path2SP}/EU-S Data/GPP/1. Data/${dataStage}/${country_name}/0. Raw Data/"

*--- Analyzing character encoding
unicode analyze "${cname}_${year}_raw.dta"

*--- Translating to UTF-8
unicode encoding set "encoding_set_name"
unicode translate "${cname}_${year}_raw.dta", transutf8
