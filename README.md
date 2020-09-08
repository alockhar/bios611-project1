Read Me file for Project 1
---------------------------

This REPO will eventually contain an analysis of the war of correlates project dataset.

Usage
--------

I will need Docker and the ability to run Docker as current user.

# bios611-project1


This Docker container is based on rocker/verse. To connect run:

    >docker run -v `pwd`:/home/rstudio -p 8787:8787\
    -e PASSWORD=mypw -t project1-env    
    
    Then connect to the machine on port 8787.
    
    
For overall project 1, which collects war outcome data (primarily civil/local conflict) from 1818-2014, one backdrop of the project is comparing war outcomes (deaths) in conflicts categorized in North or South America versus conflicts categorized in the rest of the world. Since both continents really began to develop via colonialism and consolidate in the 1800s and 1900s, I thought it would be interesting to look at the Americas versus non-Americas and the outcomes of total deaths by the defined loser in the war, and then by the general outcome of the war.  I want to do that while nesting the effects of war type (civil, localized conflict) within the Americas effect variable and adjusting for the total military forces available to the perceived initiator in the conflict.  If possible I want to integrate the total exposure time of the war into the model.

Aim 2 is to integrate the temporal component of the conflicts but more so when they occurred. There are intervals of dates collected by war but only cumulative deaths are calculated (start year 1, start year 2, etc.) so I can't do any time to event.  But I want to do clustering of all the temporal exposure periods for each war and see if I can get subgroups. With those subgroups, I want to repeat aim 1 (minus the exposure time) with elastic net and see if any interesting subgroups come out with the exposure time clusters. 


Aim 3 is to do a network analysis.  There are variables in the dataset for transferring to and transferring from meaning certain wars actually evolved into other wars. So I will create another dataset that creates a common id for any wars that additionally developed into or from others.  I will then do a network analysis and try to look for attributes common to these connected wars (or not based on the variables above).

