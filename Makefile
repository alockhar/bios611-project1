.PHONY: clean


Report\ File/Project_1_report.pdf:\
 Report\ File/Project_1_report.Rmd\
 Overall_plots/plot_files/Table1.RDS\
 Overall_plots/plot_files/Exposure_time2.png\
 Overall_plots/plot_files/Battle_deaths_Both3.png\
 Overall_plots/plot_files/War_type_deaths_Americas_4.png\
 Overall_plots/plot_files/Start_year_5.png\
 Overall_plots/plot_files/Abs_6.png\
 Overall_plots/plot_files/Rel_7.png\
 Aim1_deaths/model_outputs/nonImpSimp1.rds\
 Aim1_deaths/model_outputs/nonImpSimp2.rds\
 Aim1_deaths/model_outputs/nonImpTr1.rds\
 Aim1_deaths/model_outputs/nonImpTr2.rds\
 Aim1_deaths/model_outputs/ImpTr1.rds\
 Aim1_deaths/model_outputs/ImpTr2.rds\
 Aim1_deaths/model_outputs/IntlnonImpTr1.rds\
 Aim1_deaths/model_outputs/IntlnonImpTr2.rds\
 Aim1_deaths/model_outputs/IntlnonImpTr1.rds\
 Aim1_deaths/model_outputs/IntlnonImpTr2.rds\
 Overall_plots/plot_files/Gap_stat.png\
 Aim2_out_clustering/Cluster_Files/Aim2_TSNE.png\
 Aim2_out_clustering/Cluster_Files/Aim2_out_clustering.RDS\
 Networks/Network_Files/Ov.png\
 Networks/Network_Files/Membership.png\
 Networks/Network_Files/Membership_consolidated.png
	R -e "rmarkdown::render('Report\ File/Project_1_report.Rmd')"

clean:
	rm -f derived_data/*.rds
	rm -f derived_data/*.csv
	rm -f Overall_plots/plot_files/*.RDS
	rm -f Overall_plots/plot_files/*.png
	rm -f Aim1_deaths/model_outputs/*.RDS
	rm -f Aim2_out_clustering/Cluster_Files/*.png
	rm -f Aim2_out_clustering/Cluster_Files/*.RDS
	rm -f Networks/Network_Files/*.png

derived_data/Overall.csv\
 derived_data/gower_dist.rds\
 Overall_plots/plot_files/Gap_stat.png:\
 source_data/INTRA-STATE\ WARS\ v5.1\ CSV.csv\
 derived_programs/Overall.R
	Rscript Overall.R


derived_data/Overall_Long.csv:\
 derived_data/Overall.csv\
 derived_programs/Overall_Long.R
	Rscript Overall_Long.R	
	
derived_data/International.csv:\
 source_data/INTRA-STATE_State_participants\ v5.1\ CSV.csv\
 derived_programs/International.R
	Rscript International.R

derived_data/International_Long.csv:\
 derived_data/International.csv\
 derived_programs/International_Long.R
	Rscript International_Long.R
	
derived_data/network.rds:\
 derived_data/International.csv\
 derived_programs/Network.R
	Rscript Network.R
	

Overall_plots/plot_files/Table1.rds\
 Overall_plots/plot_files/Exposure_time2.png\
 Overall_plots/plot_files/Battle_deaths_Both3.png\
 Overall_plots/plot_files/War_type_deaths_Americas_4.png\
 Overall_plots/plot_files/Start_year_5.png\
 Overall_plots/plot_files/Abs_6.png\
 Overall_plots/plot_files/Rel_7.png:\
 derived_data/Overall.csv\
 Overall_plots/Overall_plots.R
	Rscript Overall_plots.R
	
Networks/Network_Files/Ov.png:\
 derived_data/International.csv\
 Networks/Network_aim3.R
	Rscript Network_aim3.R
	
Networks/Network_Files/Membership.png:\
 derived_data/International.csv\
 Networks/Network_aim3.R
	Rscript Network_aim3.R	
	
Networks/Network_Files/Membership_consolidated.png:\
 derived_data/International.csv\
 Networks/Network_aim3.R
	Rscript Network_aim3.R

Aim2_out_clustering/Cluster_Files/Aim2_TSNE.png:\
 derived_data/Overall.csv\
 Aim2_out_clustering/Outcome_clustering.R
	Rscript Outcome_clustering.R	
	
Aim2_out_clustering/Cluster_Files/Aim2_out_clustering.RDS:\
 derived_data/Overall.csv\
 Aim2_out_clustering/Outcome_clustering.R
	Rscript Outcome_clustering.R
	
Aim1_deaths/model_outputs/nonImpSimp1.rds\
 Aim1_deaths/model_outputs/nonImpSimp2.rds\
 Aim1_deaths/model_outputs/nonImpTr1.rds\
 Aim1_deaths/model_outputs/nonImpTr2.rds\
 Aim1_deaths/model_outputs/ImpTr1.rds\
 Aim1_deaths/model_outputs/ImpTr2.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Aim1_deaths/Domestic_No_time.R

Aim1_deaths/model_outputs/IntlnonImpTr1.rds\
 Aim1_deaths/model_outputs/IntlnonImpTr2.rds\
 Aim1_deaths/model_outputs/IntlImpTr1.rds\
 Aim1_deaths/model_outputs/IntlImpTr2.rds:\
 derived_data/International.csv\
 Aim1_deaths/International_No_time.R
	Rscript International_No_time.R
