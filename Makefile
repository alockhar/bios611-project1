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
	
	
	