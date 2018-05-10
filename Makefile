
.PHONY: all install

all:

install: all
	install -m 755 -d $(prefix)/share/android-make-stub
	install -m 644 src/build_host_executable.mk $(prefix)/share/android-make-stub/build_host_executable.mk
	install -m 644 src/build_host_native_test.mk $(prefix)/share/android-make-stub/build_host_native_test.mk
	install -m 644 src/build_host_shared_library.mk $(prefix)/share/android-make-stub/build_host_shared_library.mk
	install -m 644 src/build_host_static_library.mk $(prefix)/share/android-make-stub/build_host_static_library.mk
	install -m 644 src/clear_vars.mk $(prefix)/share/android-make-stub/clear_vars.mk
	install -m 644 src/base_rules.mk $(prefix)/share/android-make-stub/base_rules.mk
	install -m 644 src/Makefile $(prefix)/share/android-make-stub/Makefile
