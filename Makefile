PROJECT_NAME = quarkus-sample-app

DOCKER_TARGETS = docker_tag docker_push

docker: build_jar docker_login container_build_jvm $(DOCKER_TARGETS)

dev:
	mvn compile quarkus:dev

build_jar:
	mvn package

build_native_container: 
	mvn package -Pnative -Dnative-image.docker-build=true

DOCKER_REGISTRY = quay.io
ORG_NAME = famargon
DOCKER          = docker
TAG             ?= latest
PROJECT_TAG_NAME = $(DOCKER_REGISTRY)/$(ORG_NAME)/$(PROJECT_NAME):$(TAG)

# docker: docker_build docker_tag docker_push

docker_login:
	$(DOCKER) login $(DOCKER_REGISTRY) -u $(shell oc whoami) -p $(shell oc whoami -t)

container_build_jvm:
	$(DOCKER) build -f src/main/docker/Dockerfile.jvm -t $(ORG_NAME)-$(PROJECT_NAME) .
	$(DOCKER) images | grep $(ORG_NAME)-$(PROJECT_NAME)

docker_build:
	if [ -f Dockerfile ]; then $(DOCKER) build -t $(ORG_NAME)-$(PROJECT_NAME) . ; fi
	if [ -f Dockerfile ]; then docker images | grep $(ORG_NAME)-$(PROJECT_NAME) ; fi

docker_tag:
	if [ -f Dockerfile ]; then $(DOCKER) tag $(ORG_NAME)-$(PROJECT_NAME) $(PROJECT_TAG_NAME) ; fi

docker_push:
	if [ -f Dockerfile ]; then $(DOCKER) push $(PROJECT_TAG_NAME); fi

.PHONY: $(DOCKER_TARGETS) dev build_jar build_native_container
