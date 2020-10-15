.PHONY: clean

clean:
	rm derived_data/*
	rm Overall_plots/plot_files/*
	rm Aim1_deaths/model_outputs/*
	rm Aim2_out_clustering/Cluster_Files*       
	rm Networks/Network_Files/*


 

derived_data/Overall.csv:\
source_data/INTRA-STATE\ WARS\ v5.1\ CSV.csv\
derived_programs/Overall.R
	Rscript derived_programs/Overall.R
	

			
		
	
