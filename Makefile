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

# Determine the DIMAGE associated with given arch/os 
ifeq (${DIMAGE}, )
  #Default image name
  DIMAGE:=openebs/linux-utils
  XC_ARCH:=$(shell uname -m)
  ifeq (${XC_ARCH},aarch64)
    DIMAGE="openebs/linux-utils-arm64"
  endif
  export DIMAGE
endif

# Compile binaries and build docker images
.PHONY: build
build: image push

.PHONY: header
header:
	@echo "------------------------------------"
	@echo "--> Building linux utils image      "
	@echo "------------------------------------"
	@echo

.PHONY: image
image: header
	@sudo docker build -t "${DIMAGE}:ci" -f Dockerfile .
	@echo


.PHONY: test
test:
	@echo "---------------------------------------"
	@echo "--> Test required tools are available  "
	@echo "---------------------------------------"
	@sudo docker run "${DIMAGE}:ci" which mkdir
	@sudo docker run "${DIMAGE}:ci" which rm
	@sudo docker run "${DIMAGE}:ci" which wipefs

.PHONY: push
push: 
	./buildscripts/push;
