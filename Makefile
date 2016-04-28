SHELL = /bin/bash
IMAGE = yandex/mlda
TAG = 0.1
NB_DIR ?= $(shell pwd)

build:
	docker build -t ${IMAGE}:${TAG} .


run:
	docker run -ti --rm -v ${NB_DIR}:/home/jovyan/work -p 8888:8888 ${IMAGE}:${TAG}