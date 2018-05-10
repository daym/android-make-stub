
.PHONY: all install

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
