
# All-in-One Docker with Ubunutu Desktop, R(latest), Python(3.8), Spyder(latest), apache-flink(latest)

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
  spyder


#install all the packages that I need
RUN R -e "install.packages(c( 'data.table', 'ggplot2', 'jtools','pacman', 'lubridate','plotly', 'reticulate','telegram.bot','caret'), repos='http://cran.us.r-project.org')"

#####################################
#INSTALL PYTHON LIBRARIES
#####################################

#create a dedicated Python Virtual Environment
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv
RUN echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc \
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc \
echo 'eval "$(pyenv init -)"' >> ~/.bashrc \
echo 'pyenv virtualenvwrapper' >> ~/.bashrc \
exec $SHELL

RUN apt-get update -qq && apt-get install -y \
    make build-essential libssl-dev zlib1g-dev \
    libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    python-dev python3-dev
RUN pyenv install 3.8.12
RUN pyenv global 3.8.12
RUN git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
RUN pyenv virtualenv 3.8.12 mlenv
RUN pyenv global mlenv

RUN pip install --upgrade pip
RUN pip install --upgrade seaborn
RUN python -m pip install apache-flink
RUN pip install python-telegram-bot
RUN pip install git+https://github.com/online-ml/river --upgrade

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

