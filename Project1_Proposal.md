Read Me file for Project 1
---------------------------

This REPO will eventually contain an analysis of the war of correlates project dataset.

Background
--------


# bios611-project1


My project 1 data collects war outcome data (primarily civil/local conflict) from 1818-2014 all across the world . The backdrop of this project will be to compare cival/local war outcomes in conflicts categorized in North or South America versus conflicts categorized in the rest of the world. 

Since both continents really began to develop via colonialism and consolidate in the 1800s and 1900s, I thought it would be interesting to look at the Americas versus non-Americas, or how the temporal proximity of a developing set of states in the last two centuries deals with certain war outcomes in comparison to the rest of the world.  For aim 1  I want to look at the outcomes of total deaths by the defined loser in the war, then by Initiator status, and then war type (state versus regional force).  I will also look at the Americas versus non-Americas effect.  I want to do that while nesting the effects of war type (civil, localized conflict) within the Americas effect variable.  

I will extend this and look at the same models above but in international conflicts and adding an additional confounder by adjusting for the total military forces available to the perceived initiator in the conflict (not available in local war dataset).  If possible I want to integrate the total exposure time of the war into the model as a modifier of this Americas versus non-Americas effect.   

Aim 2 is to integrate the temporal component of the conflicts but more accounting for when they occurred rather than aggregating. There are intervals of dates collected by war but only cumulative deaths are calculated (start year 1, start year 2, etc.) so I can't do any time to event type of analyses.  Descriptive statistics will also be tabulated for patterns of length of time for each temporal wave of a given war.   With four possible waves recorded these patterns will be modeling aim 1 but constraining on just wave 1 exposure time.  This will be repeated for each cumulative wave of exposure time to see if a given wave of time plays a role in this Americas versus non-Americas effect.  

Aim 3  I want to do clustering of all the temporal exposure periods for each war and see if I can get subgroups. With those subgroups, I want to repeat aim 1  with elastic net and see if any interesting subgroups come out with replacing exposure time with the exposure time clusters. This will examine everything in terms of temporal eras.    

Finally aim 4 is to do a network or decision tree analysis for war outcome.  There are variables in the dataset for transferring to and transferring from meaning certain wars actually evolved into other wars. So I will create another dataset that creates a common id for any wars that additionally developed into or from others.  I will then do a network analysis and try to look for attributes common to these connected wars (or not based on the variables above).

