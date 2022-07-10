# Copyright (C) 2018 Danny Milosavljevic <dannym@scratchpost.org>
# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is licensed under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# We enable users to pass LOCAL_MODULE=<local module> to make, to only
# build the specified local module. However we can't keep the value in
# LOCAL_MODULE as it is then (re)defined in Android.mk

TARGET := $(LOCAL_MODULE)
undefine LOCAL_MODULE
override undefine LOCAL_MODULE

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
	if [ -d "include" ] ; then \
		find include -type d \
			-exec install -m 755 -d $(prefix)/'{}' ';' && \
		find include -type f -name "*.h" \
			-exec install -m 755 '{}' $(prefix)/'{}' ';' ; \
	fi

include Android.mk
