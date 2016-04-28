# Makefile for building & starting mlda-containers
# arguments can be supplied by -e definitions: 
#
#    NOTEBOOKS -- folder with notebooks that will be mounted into docker container

SHELL = /bin/bash
NOTEBOOKS ?= $(shell pwd)

include .version  # read MLDA_IMAGE
MLDA_IMAGE_LATEST = $(shell echo ${MLDA_IMAGE} | sed 's/:[0-9.]\+$$/:latest/')

help:
	@echo Usage: make [-e VARIABLE=VALUE] targets
	@echo "variables:"
	@grep -h "#\s\+\w\+ -- " $(MAKEFILE_LIST) |sed "s/#\s//"
	@echo
	@echo targets and corresponding dependencies:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' -e 's/^/   /' | sed -e 's/##//'

build: ## build image
	docker build -t ${MLDA_IMAGE} .

run: ## run container
	docker run -ti --rm -v ${NOTEBOOKS}:/home/jovyan/work -p 8888:8888 ${MLDA_IMAGE}

push: ## push built image to docker hub
	docker push ${MLDA_IMAGE}

latest:
	docker tag ${MLDA_IMAGE} ${MLDA_IMAGE_LATEST}
	docker push ${MLDA_IMAGE_LATEST}
