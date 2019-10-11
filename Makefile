VERSION = "0.1"
ORGANIZATION ?= "cznewt"
SUDO ?= "sudo"

build:
	docker build --no-cache -t $(ORGANIZATION)/build-tools:$(VERSION) -f Dockerfile .
	docker tag $(ORGANIZATION)/build-tools:$(VERSION) $(ORGANIZATION)/build-tools:latest

push:
	docker push $(ORGANIZATION)/build-tools:$(VERSION)
	docker push $(ORGANIZATION)/build-tools:latest
