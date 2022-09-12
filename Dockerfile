
# All-in-One Docker with Ubunutu Desktop, R(latest), Python(3.8), Spyder(latest) and Redis
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
RUN sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4EB27DB2A3B88B8B
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
  python3-pip \
  python3.8 \
  spyder


#install all the packages that I need
RUN Rscript -e "install.packages(c('data.table', 'ggplot2', 'jtools','pacman', 'lubridate','plotly', 'reticulate','telegram','crayon','data.tree','dotenv','stargazer','purrr','filehash'));"



#####################################
#REDIS 
#####################################
#get latest stable version from REDIS
RUN curl -fsSL https://packages.redis.io/gpg | sudo gpg --dearmor -o /usr/share/keyrings/redis-archive-keyring.gpg
RUN echo "deb [signed-by=/usr/share/keyrings/redis-archive-keyring.gpg] https://packages.redis.io/deb $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/redis.list
RUN apt-get update -qq && apt-get install -y \
redis

#####################################
#INSTALL PYTHON LIBRARIES
#####################################

RUN pip install --upgrade pip
RUN pip install --upgrade seaborn
RUN pip install python-telegram-bot
RUN pip install scikit-learn
RUN pip install git+https://github.com/online-ml/river --upgrade
RUN python -m pip install walrus

#####################################
#INSTALL RADIAN
#####################################
RUN pip3 install -U radian
#####################################

#run Redis in Background
#RUN redis-server --daemonize yes

#####################################
# COPY a FOLDER or a SCRIPT if needed
#####################################

#Copy the main folder with data and scripts
#COPY myFolder myFolder

#Copy the r script
# COPY scriptX.R scripX.R


# when the container starts, start the main.R script
#ENTRYPOINT ["Rscript", "detector.R"]
# CMD ["/bin/bash"]
