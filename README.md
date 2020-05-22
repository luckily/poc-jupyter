# Jupyter

includes: Typescript, Javascript, Go, Java

[Base image](https://hub.docker.com/r/jupyter/scipy-notebook/dockerfile)

[Jupyter kernels](https://github.com/jupyter/jupyter/wiki/Jupyter-kernels)

``` bash
$ docker build -t jupyter .
$ docker run -p 8888:8888 -v $PWD/notebooks:/notebooks -e JUPYTER_RUNTIME_DIR=/tmp/runtime jupyter
```

refs:
[Docker image with jupyter Java kernel](https://github.com/SpencerPark/IJava/issues/69)
[Docker+jupyter+java](https://github.com/awslabs/djl/blob/master/jupyter/Dockerfile)
[IJava Offical](https://github.com/SpencerPark/IJava#installing)
