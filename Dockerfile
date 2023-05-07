FROM python:3.10.11

RUN apt-get update && \
    apt-get install -y --no-install-recommends git gcc cmake curl &&\
    rm -rf /var/lib/apt/lists/*

RUN pip3 install jupyterlab notebook

RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install nodejs
RUN node -v

RUN npm install -g tslab
RUN tslab install --version
RUN tslab install --python=python3

WORKDIR /notebooks
VOLUME ["/notebooks"]

EXPOSE 8888
ENTRYPOINT ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''",  "--NotebookApp.password=''"]
