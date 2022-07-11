# Copyright (C) 2018 Danny Milosavljevic <dannym@scratchpost.org>
# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is licensed under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0

.PHONY: all check install

all:

install: all
	install -m 755 -d $(prefix)/share/android/build/core
	install -m 644 src/core/build_host_executable.mk $(prefix)/share/android/build/core/build_host_executable.mk
	install -m 644 src/core/build_host_native_test.mk $(prefix)/share/android/build/core/build_host_native_test.mk
	install -m 644 src/core/build_host_shared_library.mk $(prefix)/share/android/build/core/build_host_shared_library.mk
	install -m 644 src/core/build_host_static_library.mk $(prefix)/share/android/build/core/build_host_static_library.mk
	install -m 644 src/core/clear_vars.mk $(prefix)/share/android/build/core/clear_vars.mk
	install -m 644 src/core/base_rules.mk $(prefix)/share/android/build/core/base_rules.mk
	install -m 644 src/core/main.mk $(prefix)/share/android/build/core/main.mk
check:
	make -C tests/single-host-executable-module
	make -C tests/multiple-host-executable-modules
	make -C tests/target-host-executable-module
	make -C tests/header
