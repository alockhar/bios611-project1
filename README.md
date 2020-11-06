Read Me file for Project 1
---------------------------

This REPO will eventually contain an analysis of the war of correlates project dataset.

Usage
--------

I will need Docker and the ability to run Docker as current user.

# bios611-project1


This Docker container is based on rocker/verse. To connect run:

    >docker run -v `pwd`:/home/rstudio -p 8787:8787\
    -e PASSWORD=mypwd -t project1-env    
    
    Then connect to the machine on port 8787.
    
    

The war of correlates projects curates war data from 1814 globally through 2014 from all around the world.  Variables such as deaths, outcome status, perceived initiator, periods of exposure, forces involved, whether the war was internationalized and spread and many other variables have been collected.  Additional datasets such as economic factors, etc. have also been collected and tabulated with multiple datasets but the previously mentioned variables were of main interest for this project.  
Due to the time period of curation (1814-2014), and the onset of the Monroe Doctrine in 1823, the central interest in this project was to look at the role of Americas (or the US and South America) versus the rest of the world in initiator-defined outcomes. This was historic in that in set a role of the United States in dictating colonial policy within the hemisphere up as north of Canada through the southern tip of Latin America in order to mandate control and keep international powers at bay cementing a power structure that has lasted until modern 21st century.  The word initiator is used a lot in this project and is defined as the perceived initial war aggressor. Recipient is the perceived country who is the recipient of the initiator's attack. 

Initially the project involved looking at initial descriptive relationships of the Americas versus non-Americas conflict via tables and graphs in the domestic wars only dataset.  Variables such as deaths, type of conflict, internationalization of conflict, the Americas indicator of interest, exposure time of given conflict, and initiator created variables such as the absolute difference in initiator versus recipient deaths, and relative difference in the initiator to recipient deaths were visually examined. 


Aim 1 of the project involved looking at Americas versus non-Americas in initiator determined outcomes such as: absolute difference in initiator versus recipient deaths and relative difference in initiator versus recipient deaths, .  Initial basic glm models would be assessed while including war type, start year, and number of days of exposure.  This would be repeated for the absolute and relative difference outcomes and then repeated using a training and testing set to assess prediction.   The sensitivity of prediction would be assessed via imputation of deaths where missing, recomputing absolute and relative initiator variables of interest, and re-doing the prediction models..  The entire process would be repeated on an internationalized dataset, or one which adds forces available to those in conflict as well as adds additional wars perceived to be linked to the initial model set on an international scale.


Aim 2 was multi-fold: to cluster wartype, the Americas indicator variable, time since war started since 1814 basically, whether the war was internationalized, duration of exposure (days), initiator deaths, recipient deaths, and relative difference in deaths via a distance metric for mixed data types.  Besides cluster assessment and performance evaluation, the clusters were then descriptively assessed with clustering variables as well as the conflict outcome for pattern assessment.   

The final aim 3 was to look at network community detection based on weighting relative difference in deaths.  A network data structure was made utilizing these weights.  The goal was to descriptively assign membership and look at potentially separating attributes for a given community membership.





To run RSS do this:

docker run -v `pwd`:/home/rstudio -e PASSWORD=mypwd -p 8787:8787 -p 8788:8788 -t project1-env

Run the following command in the rstudio terminal to run the rshiny app.

PORT=8788 make Shiny_explorer_scratch.R

THe port, or 8788 above, can be changed as well if the user wants to use on another port.  Open a new tab in your browser to http:/localhost:8788 and the app will be available to interact with.


To also run the shiny app:

docker run -p <port>:<port> -v `pwd`:/home/rstudio -it project1-env sudo -H -u rstudio /bin/bash -c "cd ~/; PORT=<port> make Shiny_explorer_scratch.R"

And as above, the <port> can be replaced with the desired port to run the application.


