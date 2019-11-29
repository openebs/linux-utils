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
	@sudo docker build -t "openebs/linux-utils:ci" -f Dockerfile .
	@echo


.PHONY: push
push: 
	DIMAGE=openebs/linux-utils ./buildscripts/push;
