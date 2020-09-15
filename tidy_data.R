library(tidyverse)

Overall=read_csv("source_data/INTRA-STATE WARS v5.1 CSV.csv");
IntraParticipants=read_csv("source_data/INTRA-STATE_State_participants v5.1 CSV.csv");

#test write csv

write_csv(Overall,"derived_data/OverallT.csv")
write_csv(IntraParticipants,"derived_data/IntraParticipants.csv")