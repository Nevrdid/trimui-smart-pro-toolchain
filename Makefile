TOOLCHAIN_NAME=trimui-smart-pro-toolchain
WORKSPACE_DIR := $(shell pwd)/workspace

.build:
	mkdir -p ./workspace
	docker build -t $(TOOLCHAIN_NAME) .
	touch .build

# additional slash at beginning is a hack to work in Windows + Git Bash
shell: .build
	docker run -it --rm -v /"$(WORKSPACE_DIR)":/root/workspace:z $(TOOLCHAIN_NAME) bash

clean: 
	docker rmi $(TOOLCHAIN_NAME)
	rm -f .build

.PHONY: shell clean
