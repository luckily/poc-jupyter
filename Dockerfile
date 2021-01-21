# @link https://hub.docker.com/r/jupyter/datascience-notebook/tags
ARG BASE_CONTAINER=jupyter/scipy-notebook:aec555e49be6
FROM $BASE_CONTAINER

RUN pip install --quiet \
    'numpy==1.19.5' \
    'requests2==2.16.0' \
    'folium==0.12.1' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends git gcc cmake curl &&\
    rm -rf /var/lib/apt/lists/*

############# Install typescript, nodejs module #############
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install nodejs
RUN node -v && npm -v
RUN npm install -g tslab
RUN tslab install --version
RUN tslab install --python=python3
RUN jupyter kernelspec list

############# Install java module #############
RUN apt-get update --fix-missing
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa -y
RUN apt-get install -y openjdk-11-jdk-headless
RUN git clone https://github.com/SpencerPark/IJava.git
RUN cd IJava/ && ./gradlew installKernel && cd .. && rm -rf IJava/
RUN rm -rf ~/.gradle
RUN jupyter kernelspec list

WORKDIR /notebooks
VOLUME ["/notebooks"]

############# Install nodejs npm module #############
RUN npm install tslab node-gyp axios sequelize

USER root
RUN fix-permissions /home/$NB_USER

USER $NB_UID

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''",  "--NotebookApp.password=''"]
