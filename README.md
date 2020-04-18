# Jupyter

includes: Typescript, Javascript, Go, Java

``` bash
$ docker build -t jupyter .
$ docker run -p 8888:8888 -v $PWD/notebooks:/notebooks -e JUPYTER_RUNTIME_DIR=/tmp/runtime jupyter jupyter notebook --ip='0.0.0.0'
```