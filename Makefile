##@ General

.PHONY: help
help:  ## Show rules help
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n"} /^[a-zA-Z_0-9-]+:.*?##/ { printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

.PHONY: all
all: format lint test

.PHONY: format
format:  ## Format the scripts with shfmt
	shfmt -w *.sh

.PHONY: lint
lint:  ## Run the shellcheck linter
	shellcheck *.sh

.PHONY: test
test:  ## Run the unit tests
	bats test

.PHONY: doc
doc:  ## Generate documentation from shell comments
	shdoc < log.lib.sh > docs/log.lib.md
	shdoc < check.lib.sh > docs/check.lib.md
	shdoc < text.lib.sh > docs/text.lib.md
	shdoc < retrieve.sh > docs/retrieve.md

