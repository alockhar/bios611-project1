Test README
----------------

This REPO will eventually contain an analysis of the war of correlates project dataset.

Usage
--------

I will need Docke and the ability to run Docker as current user.

# bios611-project1


This Docker container is based on rocker/verse. To connect run:

    >docker run -v `pwd`:/home/rstudio -p 8787:8787\
    -e PASSWORD=SNUGFISH38! -t project1-env    
    
    Then connect to the machine on port 8787.