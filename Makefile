
HOST_OS = linux

my-dir = .
STUBDIR = /home/dannym/src/android-make-stub/stub

CLEAR_VARS = $(STUBDIR)/clear_vars.mk
BUILD_HOST_STATIC_LIBRARY = $(STUBDIR)/build_static_library.mk
BUILD_HOST_EXECUTABLE = $(STUBDIR)/build_host_executable.mk

include Android.mk
