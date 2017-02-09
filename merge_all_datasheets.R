setwd('C:/Users/adam/Desktop/MRS_data/MRS 1 Data/Data/csv')
library(plyr)

datasheets <- scan(what='character')
biologicals_final_v6_axm
covariate_data_inferred_v5_october_9_2013
grievance_FINAL_VERSION2
hemodynamics_final_v2
ANAM_CPT_FINAL_2_data_use
ANAM_SRT_FINAL_2_data_use
AUDIT_FINAL_CH_mod_data_use_combined
BAI_v2_data_use
BDI2_FINAL_v3_data_use
Caffeine_FINAL_CH_7.30_data_use
CAPS_FINAL_data_use
CD_RISC_v2_data_use
Cohesion_v2_data_use
CTQ_FINAL_v2_data_use
DAST_v2_data_use_combined
DEMO_v2_data_use_combined
Deploy_FINAL_V2_data_use
Deploy_Int_FINAL_data_use
Deploy_v2_data_use
DRRI_CES_v2_data_use
DRRI_DCON_v2_data_use
DRRI_DENV_v2_data_use
DRRI_LFC_v2_data_use
DRRI_PBE_v2_data_use
DRRI_US_v2_Data
LEC_FINAL_data_use
LEC_FINAL_v3_lec_data_use
LEC_FINAL_version2_data_use
LEC_v2_data_use
MINI_FINAL_2_data_use
MINI_FINAL_CH_7.27_data_use
MRSI_TBI_FINAL_3_data_use
NEURO_SR_FINAL_data_use
PANAS_v2_Data
PBQSR_FINAL_data_use
PCL_v2_data_use
PDEQ_v2_data
SF12_v2_SF12_Data
TOBAC_FINAL_2_combined_data_use
WHODAS_v2_data_use




#read each file into a data frame with the same name
for (i in datasheets)
{
	assign(
		i, subset(read.csv(paste(i,'.csv',sep=''), header=T, na.strings=c('#N/A','NA','#NULL!')), !is.na(id_visit))
		) 
}

#parse the text list of data frame names as a list of data frames
data_list <- eval( 
			parse( 
				text=paste(
					"list(", paste(datasheets, collapse=','), ")" 
					)
				)
			)
			

#determine if any dataset does not have id_visit in the name
for (i in datasheets)
{
	print(i)
	print( !!grep("id_visit", names(eval(parse(text=i)))  ))
}

#combine all data frames by id_visit (won't work for subjects missing this variable!!!!!)
datA <- join_all(data_list,by="id_visit", type="left", match="first")

export <- subset(datA, visit <= 3 & use_visit == 1)

write.csv(export, "C:/Users/adam/Desktop/MRS_data/adam_mrs_data/merge_all_mrs_data/mrs1_allsheets_V0toV3_UV=1__v3_sep13_2015.csv", row.names=F)

