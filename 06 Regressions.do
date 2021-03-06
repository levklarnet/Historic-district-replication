********************************************************************
* Replication materials for Preserving History or Property Values: *
* Historic Preservation and Housing Prices in Washington, DC 	   *
* Author: Lev Klarnet 						   *
* Date: May 8, 2019						   *
********************************************************************

* In this script, I run the series of regressions on the full data, the residential only data, and the repeat sales
* data.

************************************************************************************************************************
* Script table of contents:
*
* 1: All sales full sample regressions
* 2: All sales activist only regressions
* 3: Repeat sales full sample regressions
* 4: Repeat sales activist only regressions
************************************************************************************************************************
clear
set more off
set type double
set matsize 500

****************************************
* 1: All sales full sample regressions *
****************************************

	* Import the full data
	use "${TEMP}/All_sales_reg_ready.dta", clear

	*** FULL SAMPLE REGRESSIONS ***

		* Local control variables 
		local control_fs hd_buff_250f_ever hd_buff_250f_post lgba rooms bedrm bathrm hf_bathrm log_landarea fireplaces age age2 condo town_inside town_end sf multi semi_detached hardwood_floor metro_close *Dsale* 
		
		* Reg FULL SAMPLE NEIGHBORHOOD TRENDS
		reg lprice hd_ever post_desig post_desig_condo post_desig_sf post_desig_multi post_desig_semi_detached post_desig_town_end post_desig_town_inside `control_fs' i.census_tract##c.t, robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/full_sample_nt.ster", replace
		
	*** RESIDENTIAL ONLY REGRESSIONS ***

		* local control variables for residential only
		local control_res hd_buff_250f_ever hd_buff_250f_post lgba rooms bedrm bathrm hf_bathrm log_landarea fireplaces age age2 town_inside town_end sf multi semi_detached hardwood_floor metro_close *Dsale* stories kitchens Dcndtn*
		
		* Reg RESIDENTIAL NEIGHBORHOOD TRENDS
		reg lprice hd_ever post_desig post_desig_sf post_desig_multi post_desig_semi_detached post_desig_town_end post_desig_town_inside `control_res' i.census_tract##c.t if source == "RESIDENTIAL", robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/residential_nt.ster", replace

******************************************
* 2: All sales activist only regressions *
******************************************

	* Import the data
	use "${TEMP}/All_act_reg_ready.dta", clear

	*** FULL SAMPLE REGRESSIONS ***

		* Local control variables 
		local control_fs hd_buff_250f_ever hd_buff_250f_post lgba rooms bedrm bathrm hf_bathrm log_landarea fireplaces age age2 condo town_inside town_end sf multi semi_detached hardwood_floor metro_close *Dsale* 

		* Reg FULL SAMPLE NEIGHBORHOOD TRENDS
		reg lprice hd_ever post_desig post_desig_condo post_desig_sf post_desig_multi post_desig_semi_detached post_desig_town_end post_desig_town_inside `control_fs' i.census_tract##c.t, robust

		* Store estimates and statistics from regression
		estimates save "${TEMP}/act_full_sample_nt.ster", replace

	*** RESIDENTIAL ONLY REGRESSIONS ***

		* local control variables for residential
		local control_res hd_buff_250f_ever hd_buff_250f_post lgba rooms bedrm bathrm hf_bathrm log_landarea fireplaces age age2 town_inside town_end sf multi semi_detached hardwood_floor metro_close *Dsale* stories kitchens Dcndtn*
		
		* Reg RESIDENTIAL NEIGHBORHOOD TRENDS
		reg lprice hd_ever post_desig post_desig_sf post_desig_multi post_desig_semi_detached post_desig_town_end post_desig_town_inside `control_res' i.census_tract##c.t if source == "RESIDENTIAL", robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/act_residential_nt.ster", replace

*******************************************
* 3: Repeat sales full sample regressions *
*******************************************

	* Import data
	use "${TEMP}/Repeat_sales_reg_ready.dta", clear

	*** REPEAT SALES FIXED EFFECTS *** 

		local repeat_sale_vars post_desig_i hd_chg hd_chg_condo hd_buff_250feet_i hd_buff_250f_chg saledate_chg spring_chg fall_chg summer_chg saleyear_92_chg saleyear_93_chg saleyear_94_chg saleyear_95_chg saleyear_96_chg saleyear_97_chg saleyear_98_chg saleyear_99_chg saleyear_00_chg saleyear_01_chg saleyear_02_chg saleyear_03_chg saleyear_04_chg saleyear_05_chg saleyear_06_chg saleyear_07_chg saleyear_08_chg saleyear_09_chg saleyear_10_chg saleyear_11_chg saleyear_12_chg saleyear_13_chg saleyear_14_chg saleyear_15_chg saleyear_16_chg saleyear_17_chg saleyear_18_chg saleyear_19_chg
		
		reg price_chg `repeat_sale_vars', robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/repeat_sales_ols.ster", replace
	
	*** REPEAT SALES NEIGHBORHOOD TRENDS ***

		local repeat_sale_vars post_desig_i hd_chg hd_chg_condo hd_chg_sf hd_chg_multi hd_chg_semi_detached hd_chg_town_end hd_chg_town_inside hd_buff_250feet_i hd_buff_250f_chg saledate_chg spring_chg fall_chg summer_chg saleyear_92_chg saleyear_93_chg saleyear_94_chg saleyear_95_chg saleyear_96_chg saleyear_97_chg saleyear_98_chg saleyear_99_chg saleyear_00_chg saleyear_01_chg saleyear_02_chg saleyear_03_chg saleyear_04_chg saleyear_05_chg saleyear_06_chg saleyear_07_chg saleyear_08_chg saleyear_09_chg saleyear_10_chg saleyear_11_chg saleyear_12_chg saleyear_13_chg saleyear_14_chg saleyear_15_chg saleyear_16_chg saleyear_17_chg saleyear_18_chg saleyear_19_chg
		
		reg price_chg `repeat_sale_vars' i.census_tract##c.t, robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/repeat_sales_nt.ster", replace

*********************************************
* 4: Repeat sales activist only regressions *
*********************************************

	* Import data
	use "${TEMP}/Repeat_act_reg_ready.dta", clear

	*** REPEAT SALES FIXED EFFECTS *** 

		local repeat_sale_vars post_desig_i hd_chg hd_chg_condo hd_buff_250feet_i hd_buff_250f_chg saledate_chg spring_chg fall_chg summer_chg saleyear_92_chg saleyear_93_chg saleyear_94_chg saleyear_95_chg saleyear_96_chg saleyear_97_chg saleyear_98_chg saleyear_99_chg saleyear_00_chg saleyear_01_chg saleyear_02_chg saleyear_03_chg saleyear_04_chg saleyear_05_chg saleyear_06_chg saleyear_07_chg saleyear_08_chg saleyear_09_chg saleyear_10_chg saleyear_11_chg saleyear_12_chg saleyear_13_chg saleyear_14_chg saleyear_15_chg saleyear_16_chg saleyear_17_chg saleyear_18_chg saleyear_19_chg
		
		reg price_chg `repeat_sale_vars', robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/act_repeat_sales_ols.ster", replace

	*** REPEAT SALES NEIGHBORHOOD TRENDS ***
	 
		local repeat_sale_vars post_desig_i hd_chg hd_chg_condo hd_chg_sf hd_chg_multi hd_chg_semi_detached hd_chg_town_end hd_chg_town_inside hd_buff_250feet_i hd_buff_250f_chg saledate_chg spring_chg fall_chg summer_chg saleyear_92_chg saleyear_93_chg saleyear_94_chg saleyear_95_chg saleyear_96_chg saleyear_97_chg saleyear_98_chg saleyear_99_chg saleyear_00_chg saleyear_01_chg saleyear_02_chg saleyear_03_chg saleyear_04_chg saleyear_05_chg saleyear_06_chg saleyear_07_chg saleyear_08_chg saleyear_09_chg saleyear_10_chg saleyear_11_chg saleyear_12_chg saleyear_13_chg saleyear_14_chg saleyear_15_chg saleyear_16_chg saleyear_17_chg saleyear_18_chg saleyear_19_chg
		
		reg price_chg `repeat_sale_vars' i.census_tract##c.t, robust cluster(census_tract)

		* Store estimates and statistics from regression
		estimates save "${TEMP}/act_repeat_sales_nt.ster", replace

*** EOF ***
