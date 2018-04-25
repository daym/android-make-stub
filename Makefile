
.PHONY: all install

all:

install: all
	install -m 755 -d $(prefix)/share/android-make-stub
	install -m 644 src/build_host_executable.mk $(prefix)/share/android-make-stub/build_host_executable.mk
	install -m 644 src/build_host_shared_library.mk $(prefix)/share/android-make-stub/build_host_shared_library.mk
	install -m 644 src/build_host_static_library.mk $(prefix)/share/android-make-stub/build_host_static_library.mk
	install -m 644 src/clear_vars.mk $(prefix)/share/android-make-stub/clear_vars.mk
