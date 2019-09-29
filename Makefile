ONLY?=
LATEST?=7.2
IMG_NAME=x1unix/php-micro
VERSIONS=7.0 7.1 7.2

.PHONY: all
all: build push

.PHONY: build
build:
	@for v in $(VERSIONS); do \
		if [ ! -z "$(ONLY)" ] && [ "$(ONLY)" != $$v ]; then \
			continue; \
		fi; \
		echo "Building \"$(IMG_NAME):$$v\"..."; \
		if [ $$v == "$(LATEST)" ]; then \
			docker build -t $(IMG_NAME):$$v -t $(IMG_NAME):latest ./$$v; \
		else\
			docker build -t $(IMG_NAME):$$v ./$$v; \
		fi; \
	done

.PHONY: push-versions
push-versions:
	@for v in $(VERSIONS); do \
		if [ ! -z "$(ONLY)" ] && [ "$(ONLY)" != $$v ]; then \
			continue; \
		fi; \
		echo "- Pushing \"$(IMG_NAME):$$v\"..." && \
		docker push $(IMG_NAME):$$v; \
	done

.PHONY: push
push: push-versions
	if [ ! -z "$(ONLY)" ] && [ "$(ONLY)" != "$(LATEST)" ]; then \
		echo "- Tag '$(LATEST)' (latest) is excluded from build list" && \
		exit 0; \
	fi; \
	docker push $(IMG_NAME):latest;
