
# All-in-One Docker with Ubunutu Desktop, R(latest), Python(3.8), Spyder(latest), apache-flink(latest)
#
#
#
#


#https://computingforgeeks.com/run-ubuntu-linux-in-docker-with-desktop-environment-and-vnc/
#https://datawookie.dev/blog/2021/05/desktop-in-docker/
#https://datawookie.dev/blog/2021/05/building-an-airflow-environment-in-docker/
#####################################
# start from Ubuntu
#####################################

FROM dorowu/ubuntu-desktop-lxde-vnc:latest


WORKDIR "/root"

#####################################
#INSTALL LINUX LIBRARIES
#####################################

# install the linux libraries needed 
RUN sudo add-apt-repository ppa:webupd8team/y-ppa-manager
RUN apt-get update -qq && apt-get install -y \
  git \
  libssl-dev \
  libcurl4-gnutls-dev \
  libpq-dev \
  make \
  zlib1g-dev \
  r-base \
  r-base-dev \
  gdebi-core \
  pandoc \
  pandoc-citeproc \
  libcairo2-dev \
  libxt-dev \
  xtail \
  wget \
  libxml2 \
  libxml2-dev \
  r-cran-caret \
  python3.8 \
  spyder


#install all the packages that I need
#RUN R -e "install.packages(c('data.table','lubridate', 'ggplot2', 'jtools'), repos='http://cran.us.r-project.org')"
RUN ["install2.r", "data.table", "ggplot2", "jtools","pacman", "lubridate","plotly", "reticulate","telegram.bot","caret","parallel"]

#####################################
#INSTALL PYTHON LIBRARIES
#####################################

RUN pip install --upgrade pip
RUN pip install git+https://github.com/online-ml/river --upgrade
RUN pip install --upgrade seaborn
RUN python -m pip install apache-flink
RUN pip install python-telegram-bot

#####################################
# COPY a FOLDER if needed
#####################################

#Copy the main folder with data and scripts
COPY myFolder myFolder

#Copy the r script
# COPY scriptX.R scripX.R


# when the container starts, start the main.R script
#ENTRYPOINT ["Rscript", "detector.R"]
# CMD ["/bin/bash"]

