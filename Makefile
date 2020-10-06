.PHONY: clean

clean:
	rm derived_data/*
  
derived_data/IntraParticipants.csv derived_data/OverallT.csv:\
 source_data/INTRA-STATE_State_participants v5.1 CSV.csv\
 source_data/INTRA-STATE WARS v5.1 CSV.csv\
 tidy_data.R
	Rscript tidy_data.R
	
derived_data/Overall.csv:\
 source_data/INTRA-STATE WARS v5.1 CSV.csv\
 derived_programs/Overall.R
	Rscript Overall.R
	
derived_data/gower_dist.rds:\
 source_data/INTRA-STATE WARS v5.1 CSV.csv\
 derived_programs/Overall.R
	Rscript Overall.R	
	
derived_data/Overall_Long.csv:\
 derived_data/Overall.csv\
 derived_programs/Overall_Long.R
	Rscript Overall_Long.R	
	
derived_data/International.csv:\
 source_data/INTRA-STATE_State_participants v5.1 CSV.csv\
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
	
Overall_plots/plot_files/Exposure time2.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Battle deaths Both3.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R		
	
Overall_plots/plot_files/War type deaths Americas 4.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Start year 5.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Abs 6.png:\
 derived_data/Overall.csv\
 derived_programs/Overall_plots.R
	Rscript Overall_plots.R	
	
Overall_plots/plot_files/Rel 7.png:\
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