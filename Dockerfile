FROM rocker/verse
MAINTAINER Alexandre Lockhart <alexandre_georges@hotmail.com>

RUN R -e "install.packages('dplyr')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('mice')"
RUN R -e "install.packages('cluster')"
RUN R -e "install.packages('Rtsne')"
RUN R -e "install.packages('lubridate')"


RUN R -e "install.packages('compareGroups')"
RUN R -e "install.packages('Hmisc')"
RUN R -e "install.packages('gridExtra')"

RUN R -e "install.packages('caret')"
RUN R -e "install.packages('e1071')"

RUN R -e "install.packages('igraph')"
RUN R -e "install.packages('RColorBrewer')"

RUN R -e "install.packages('gbm')"
RUN R -e "install.packages('MLmetrics')"

RUN R -e "install.packages('shiny')"
RUN R -e "install.packages('plotly')"

RUN apt update -y && apt install -y python3-pip
RUN pip3 install jupyter jupyterlab
RUN pip3 install numpy pandas sklearn plotnine matplotlib pandasql bokeh seaborn joypy