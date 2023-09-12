# https://www.gnu.org/software/make/manual/html_node/Special-Variables.html
# https://ftp.gnu.org/old-gnu/Manuals/make-3.80/html_node/make_17.html
PROJECT_MKFILE_PATH       := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))
PROJECT_MKFILE_DIR        := $(shell cd $(shell dirname $(PROJECT_MKFILE_PATH)); pwd)

STANDARD_GCC_CPP23		:=$(CXX_GCC) -std=c++2b
STANDARD_GCC_CPP20		:=$(CXX_GCC) -std=c++20

STANDARD_CLANG_CPP23	:=$(CXX) -std=c++23
STANDARD_CLANG_CPP20	:=$(CXX) -std=c++20

PROJECT_ROOT			:= $(PROJECT_MKFILE_DIR)
PROJECT_ROOT_SRC		:= $(PROJECT_ROOT)/src
PROJECT_MAIN			:= $(PROJECT_ROOT_SRC)/entrypoint.cpp
PROJECT_BUILD_OUT		:= $(PROJECT_ROOT)/build

.PHONY: all
#run: VERBOSITY=-v
run: VERBOSITY=
all: $(PROJECT_BUILD_OUT)
	$(STANDARD_GCC_CPP23) -O2 -Wall $(VERBOSITY) $(PROJECT_MAIN) -o $(PROJECT_BUILD_OUT)/entrypoint

.PHONY: run
run: all
	$(PROJECT_BUILD_OUT)/entrypoint


$(PROJECT_BUILD_OUT):
	install -dm0755 $(PROJECT_BUILD_OUT)
