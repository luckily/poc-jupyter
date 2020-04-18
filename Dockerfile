# @link https://hub.docker.com/r/jupyter/datascience-notebook/tags
ARG BASE_CONTAINER=jupyter/scipy-notebook
FROM $BASE_CONTAINER

RUN pip install --quiet \
    'numpy==1.17.0' && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

USER root

RUN apt-get update && \
    apt-get install -y --no-install-recommends git gcc cmake curl &&\
    rm -rf /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash

RUN apt-get install nodejs

RUN node -v && npm -v

RUN npm install -g tslab

RUN tslab install --version

RUN tslab install --python=python3

RUN jupyter kernelspec list

WORKDIR /notebooks

VOLUME ["/notebooks"]

USER root
RUN fix-permissions /home/$NB_USER

EXPOSE 8888

USER $NB_UID