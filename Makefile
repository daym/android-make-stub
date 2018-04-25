
prefix = /usr
HOST_OS = linux

my-dir = .

makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
stub_dir := $(dir $(makefile_path))

CLEAR_VARS = $(stub_dir)clear_vars.mk
BUILD_HOST_STATIC_LIBRARY = $(stub_dir)build_host_static_library.mk
BUILD_HOST_SHARED_LIBRARY = $(stub_dir)build_host_shared_library.mk
BUILD_HOST_EXECUTABLE = $(stub_dir)build_host_executable.mk

# TODO: Change.
#BUILD_STATIC_LIBRARY = $(stub_dir)build_host_static_library.mk

.PHONY: all
all:

include Android.mk
