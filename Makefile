.PHONY: clean

clean:
	rm derived_data/*
        rm Overall_plots/plot_files/*
       
Report\ File/Project_1_report.pdf: Project_1_report.Rmd\
 Overall_plots/plot_files/Table1.RDS\
 Overall_plots/plot_files/Exposure\ time2.png\
 Overall_plots/plot_files/Battle\ deaths\ Both3.png\
 Overall_plots/plot_files/War\ type\ deaths\ Americas\ 4.png\
 Overall_plots/plot_files/Start\ year\ 5.png\
 Overall_plots/plot_files/Abs\ 6.png\
 Overall_plots/plot_files/Rel\ 7.png\
 Aim1_deaths/nonImpSimp1.rds\
 Aim1_deaths/nonImpSimp2.rds\
 Aim1_deaths/nonImpTr1.rds\
 Aim1_deaths/nonImpTr2.rds\
 Aim1_deaths/ImpTr1.rds\
 Aim1_deaths/ImpTr2.rds\
 Aim1_deaths/IntlnonImpTr1.rds\
 Aim1_deaths/IntlnonImpTr2.rds\
 Aim1_deaths/IntlnonImpTr1.rds\
 Aim1_deaths/IntlnonImpTr2.rds\
 Overall_plots/plot_files/Gap\ stat.png\
 Aim2_out_clustering/Aim2\ TSNE.png\
 Aim2_out_clustering/Aim2_out_clustering.RDS\
 Networks/Ov.png\
 Networks/Membership.png\
 Networks/Membership_consolidated.png
	R -e "rmarkdown::render('Project_1_report.Rmd')"
 

derived_data/Overall.csv:\
 source_data/INTRA-STATE\ WARS\ v5.1\ CSV.csv\
 derived_programs/Overall.R
	Rscript Overall.R
	
derived_data/gower_dist.rds:\
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
	
	
Overall_plots/plot_files/Table1.rds:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R
	
Overall_plots/plot_files/Exposure\ time2.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Battle\ deaths\ Both3.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R		
	
Overall_plots/plot_files/War\ type\ deaths\ Americas\ 4.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Start\ year\ 5.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Abs\ 6.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Rel\ 7.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Networks/Ov.png:\
 derived_data/International.csv\
 derived_programs/Network_aim3.R
	Rscript Network_aim3.R
	
Networks/Membership.png:\
 derived_data/International.csv\
 derived_programs/Network_aim3.R
	Rscript Network_aim3.R	
	
Networks/Membership_consolidated.png:\
 derived_data/International.csv\
 derived_programs/Network_aim3.R
	Rscript Network_aim3.R
	
	

Aim2_out_clustering/Aim2\ TSNE.png:\
 derived_data/Overall.csv\
 derived_programs/Outcome_Clustering.R
	Rscript Outcome_Clustering.R	
	
	
Aim2_out_clustering/Aim2_out_clustering.RDS:\
 derived_data/Overall.csv\
 derived_programs/Outcome_Clustering.R
	Rscript Outcome_Clustering.R
	
Aim1_deaths/nonImpSimp1.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time
	Rscript Domestic_No_time.R
	
Aim1_deaths/nonImpSimp2.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Domestic_No_time.R	
	
Aim1_deaths/nonImpTr1.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Domestic_No_time.R
	
Aim1_deaths/nonImpTr2.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Domestic_No_time.R
	
Aim1_deaths/ImpTr1.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Domestic_No_time.R	
	
Aim1_deaths/ImpTr2.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Domestic_No_time.R
	
Aim1_deaths/ImpTr1.rds:\
 derived_data/Overall.csv\
 Aim1_deaths/Domestic_No_time.R
	Rscript Domestic_No_time.R	
	
Aim1_deaths/IntlnonImpTr1.rds:\
 derived_data/International.csv\
 Aim1_deaths/International_No_time.R
	Rscript International_No_time.R

Aim1_deaths/IntlnonImpTr2.rds:\
 derived_data/International.csv\
 Aim1_deaths/International_No_time.R
	Rscript International_No_time.R
	
Aim1_deaths/IntlImpTr1.rds:\
 derived_data/International.csv\
 Aim1_deaths/International_No_time.R
	Rscript International_No_time.R

Aim1_deaths/IntlImpTr2.rds:\
 derived_data/International.csv\
 Aim1_deaths/International_No_time.R
	Rscript International_No_time.R
			
		
	
