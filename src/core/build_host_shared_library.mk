# Copyright (C) 2018 Danny Milosavljevic <dannym@scratchpost.org>
# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is licensed under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0

include $(BUILD_SYSTEM)target_local_module.mk

ifeq ($(LOCAL_MODULE),$(TARGET))

LOCAL_C_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.c,%.o,$(LOCAL_SRC_FILES))))
LOCAL_CXX_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux)))))
LOCAL_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux))))))
LOCAL_C_INCLUDES_PARAMS := -I ../base/include -I ../include -I ../libsparse/include $(foreach d, $(LOCAL_C_INCLUDES), -I $d)
LOCAL_WHOLE_STATIC_LIBRARIES_PARAMS := -Wl,--whole-archive $(foreach d,$(LOCAL_WHOLE_STATIC_LIBRARIES),-l$(patsubst lib%,%,$d)) -Wl,--no-whole-archive

SO := $(LOCAL_MODULE).so.0

built_shared_libraries := $(built_shared_libraries) $(SO)

.PHONY: all
all: $(SO)

$(SO):
$(SO): LOCAL_LDLIBS_linux := $(LOCAL_LDLIBS_linux)
$(SO): LOCAL_LDLIBS := $(LOCAL_LDLIBS)
$(SO): LOCAL_WHOLE_STATIC_LIBRARIES_PARAMS := $(LOCAL_WHOLE_STATIC_LIBRARIES_PARAMS)
$(SO): LOCAL_OBJ_FILES := $(LOCAL_OBJ_FILES)
$(SO): LDLIBS := $(LDLIBS)
$(SO): $(LOCAL_OBJ_FILES) $(built_static_libraries)
	$(CC) -shared -o $@ -fPIC -Wl,-soname,$@ $(LOCAL_OBJ_FILES) $(LOCAL_WHOLE_STATIC_LIBRARIES_PARAMS) -L . $(LOCAL_LDLIBS) $(LOCAL_LDLIBS_linux) $(LDLIBS)

.PHONY: install
install: install-$(SO)
install-$(SO): LOCAL_MODULE := $(LOCAL_MODULE)
install-$(SO): $(SO)
	install -m 755 -d $(prefix)/lib
	install -m 755 $(SO) $(prefix)/lib/$(SO)

$(LOCAL_C_OBJ_FILES):
$(LOCAL_C_OBJ_FILES): LOCAL_CFLAGS := $(LOCAL_CFLAGS)
$(LOCAL_C_OBJ_FILES): LOCAL_CONLY_FLAGS := $(LOCAL_CONLYFLAGS)
$(LOCAL_C_OBJ_FILES): CPPFLAGS := $(CPPFLAGS)
$(LOCAL_C_OBJ_FILES): CFLAGS := $(CFLAGS)
$(LOCAL_C_OBJ_FILES): LOCAL_C_INCLUDES_PARAMS := $(LOCAL_C_INCLUDES_PARAMS)
$(LOCAL_C_OBJ_FILES): $(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux)
	$(CC) -c -fPIC $(LOCAL_CFLAGS) $(LOCAL_CONLYFLAGS) $(CPPFLAGS) $(CFLAGS) $(LOCAL_C_INCLUDES_PARAMS) $^

$(LOCAL_CXX_OBJ_FILES):
$(LOCAL_CXX_OBJ_FILES): LOCAL_CFLAGS := $(LOCAL_CFLAGS)
$(LOCAL_CXX_OBJ_FILES): LOCAL_CONLY_FLAGS := $(LOCAL_CONLYFLAGS)
$(LOCAL_CXX_OBJ_FILES): CPPFLAGS := $(CPPFLAGS)
$(LOCAL_CXX_OBJ_FILES): CXXFLAGS := $(CXXFLAGS)
$(LOCAL_CXX_OBJ_FILES): LOCAL_C_INCLUDES_PARAMS := $(LOCAL_C_INCLUDES_PARAMS)
$(LOCAL_CXX_OBJ_FILES): $(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux)
	$(CXX) -c -fPIC $(LOCAL_CFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(LOCAL_C_INCLUDES_PARAMS) $^

endif # ifneq ($(LOCAL_MODULE),$(TARGET))
