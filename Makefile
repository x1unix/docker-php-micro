VERSION?=7.2
IMG_NAME=x1unix/php-micro

.PHONY: build
build:
	@echo "Building \"$(IMG_NAME):$(VERSION)\"..." && docker build -t $(IMG_NAME):$(VERSION) -t $(IMG_NAME):latest .

.PHONY: push
push:
	@for t in $(VERSION) latest; do echo "- Pushing \"$(IMG_NAME):$$t\"..." && docker push $(IMG_NAME):$$t; done

