# Copyright 2018-2019 The OpenEBS Authors. All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ==============================================================================
# Build Options

# set the shell to bash in case some environments use sh
SHELL:=/bin/bash

# Default behaviour is to use buildx only for github actions, until the Travis workflow is deprecated.
BUILDX:=false

ifeq (${IMAGE_ORG}, )
  IMAGE_ORG=openebs
  export IMAGE_ORG
endif

ifeq (${DIMAGES}, )
  DIMAGES:=linux-utils
  export DIMAGES
endif

#Initialize Docker build arguments. Each of these
# DBUILD_<name> args will be passed to docker build command
# via --build-arg DBUILD_<name>=$DBUILD_<name>
DBUILD_DATE = $(shell date +'%Y%m%d%H%M%S')

# Specify the docker arg for repository url
ifeq (${DBUILD_REPO_URL}, )
  DBUILD_REPO_URL="https://github.com/openebs/linux-utils"
  export DBUILD_REPO_URL
endif

# Specify the docker arg for website url
ifeq (${DBUILD_SITE_URL}, )
  DBUILD_SITE_URL="https://openebs.io"
  export DBUILD_SITE_URL
endif

export DBUILD_ARGS=--build-arg DBUILD_DATE=${DBUILD_DATE} --build-arg DBUILD_REPO_URL=${DBUILD_REPO_URL} --build-arg DBUILD_SITE_URL=${DBUILD_SITE_URL}


# Compile binaries and build docker images
.PHONY: build
build: image push

.PHONY: header
header:
	@echo "------------------------------------"
	@echo "--> Building linux utils images     "
	@echo "------------------------------------"
	@echo

.PHONY: image
image: header
	@for image in $$DIMAGES; do \
		sudo docker build -t "$$IMAGE_ORG/$$image:ci" -f ./dockerfiles/$$image/Dockerfile . ${DBUILD_ARGS}; \
	done
	@echo "Done"

.PHONY: test
test:
	@echo "---------------------------------------"
	@echo "--> Test required tools are available  "
	@echo "---------------------------------------"
	@sudo docker run --rm "$$IMAGE_ORG/linux-utils:ci" which mkdir
	@sudo docker run --rm "$$IMAGE_ORG/linux-utils:ci" which rm
	@sudo docker run --rm "$$IMAGE_ORG/linux-utils:ci" which wipefs

.PHONY: clobber
clobber:
	@for image in $$DIMAGES; do \
	    docker rmi $$IMAGE_ORG/$$image:$$TAG || true; \
	done
	docker image prune -f

include Makefile.buildx.mk