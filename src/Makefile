
prefix = /usr
HOST_OS = linux

define my-dir
  $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
endef

makefile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
BUILD_SYSTEM := $(dir $(makefile_path))

CLEAR_VARS = $(BUILD_SYSTEM)clear_vars.mk
BUILD_HOST_STATIC_LIBRARY = $(BUILD_SYSTEM)build_host_static_library.mk
BUILD_HOST_SHARED_LIBRARY = $(BUILD_SYSTEM)build_host_shared_library.mk
BUILD_HOST_EXECUTABLE = $(BUILD_SYSTEM)build_host_executable.mk
BUILD_HOST_NATIVE_TEST = $(BUILD_SYSTEM)/build_host_native_test.mk
# TODO: Change.
#BUILD_STATIC_LIBRARY = $(BUILD_SYSTEM)build_host_static_library.mk

.PHONY: all check install
all:
check:
install:
	if [ -d "include" ] ; then find include -type d -exec install -m 755 -d $(prefix)/'{}' ';' && find include -type f -name "*.h" -exec install -m 755 '{}' $(prefix)/'{}' ';' ; fi

include Android.mk
