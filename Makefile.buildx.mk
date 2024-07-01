# Copyright 2018-2020 The OpenEBS Authors. All rights reserved.
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

ifeq (${TAG}, )
  export TAG=ci
endif

# default list of platforms for which multiarch image is built
ifeq (${PLATFORMS}, )
	export PLATFORMS="linux/amd64,linux/arm64,linux/arm/v7,linux/ppc64le"
endif

# if IMG_RESULT is unspecified, by default the image will be pushed to registry
ifeq (${IMG_RESULT}, load)
	export PUSH_ARG="--load"
    # if load is specified, image will be built only for the build machine architecture.
    export PLATFORMS="local"
else ifeq (${IMG_RESULT}, cache)
	# if cache is specified, image will only be available in the build cache, it won't be pushed or loaded
	# therefore no PUSH_ARG will be specified
else
	export PUSH_ARG="--push"
endif

.PHONY: buildx.image
buildx.image:
	@if ! docker buildx ls | grep -q container-builder; then\
		docker buildx create --platform ${PLATFORMS} --name container-builder --use;\
	fi
	@echo "Building $$DIMAGES for platforms ${PLATFORMS}"
	@for image in $$DIMAGES; do \
	    DOCKERX_IMAGE=$$IMAGE_ORG/$$image:$$TAG; \
		echo "--> Building $$DOCKERX_IMAGE"; \
		docker buildx build --platform ${PLATFORMS} \
			-t "$$DOCKERX_IMAGE" ${DBUILD_ARGS} -f ./dockerfiles/$$image/Dockerfile \
			. ${PUSH_ARG}; \
		echo "--> Built docker image: $$DOCKERX_IMAGE"; \
		echo; \
	done
	@echo "Built $$DIMAGES for platforms ${PLATFORMS}"
	@docker buildx stop --builder container-builder
	@echo

.PHONY: buildx.clean
buildx.clean:
	docker buildx rm --builder container-builder || true

.PHONY: buildx.clobber
buildx.clobber: buildx.clean
	@for image in $$DIMAGES; do \
	    docker rmi $$IMAGE_ORG/$$image:$$TAG || true; \
	done
	docker rmi moby/buildkit:buildx-stable-1
