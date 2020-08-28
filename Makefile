.PHONY: clean

clean:
	rm derived_data/*
  
derived_data/IntraParticipants.csv derived_data/Overall.csv:\
 source_data/INTRA-STATE_State_participants v5.1 CSV.csv\
 source_data/INTRA-STATE WARS v5.1 CSV.csv\
 tidy_data.R
	Rscript tidy_data.R