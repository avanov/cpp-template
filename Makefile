# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
PROJECT_MKFILE_PATH       := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
PROJECT_MKFILE_DIR        := $(shell cd $(shell dirname $(PROJECT_MKFILE_PATH)); pwd)

STANDARD_CPP23=c++2b

PROJECT_ROOT			:= $(PROJECT_MKFILE_DIR)
PROJECT_ROOT_SRC		:= $(PROJECT_ROOT)/src
PROJECT_MAIN			:= $(PROJECT_ROOT_SRC)/entrypoint.cpp
PROJECT_BUILD_OUT		:= $(PROJECT_ROOT)/build

.PHONY: all
all: $(PROJECT_BUILD_OUT)
	$(CXX) -std=$(STANDARD_CPP23) -O2 -Wall $(PROJECT_MAIN) -o $(PROJECT_BUILD_OUT)/entrypoint

.PHONY: run
run: all
	$(PROJECT_BUILD_OUT)/entrypoint


$(PROJECT_BUILD_OUT):
	install -dm0755 $(PROJECT_BUILD_OUT)
