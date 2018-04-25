
LOCAL_C_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.c,%.o,$(LOCAL_SRC_FILES))))
LOCAL_CXX_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES)))))
LOCAL_OBJ_FILES := $(notdir $(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES)))))
LOCAL_C_INCLUDES_PARAMS := -I ../base/include -I ../include -I ../libsparse/include $(foreach d, $(LOCAL_C_INCLUDES), -I $d)

SO := $(LOCAL_MODULE).so.0

built_static_libraries := $(built_static_libraries) $(SO)

.PHONY: all
all: $(SO)

$(SO): $(LOCAL_OBJ_FILES)
	$(CC) -shared -fPIC -Wl,-soname,$(SO)

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
$(LOCAL_C_OBJ_FILES): $(LOCAL_SRC_FILES)
	$(CC) -c -fPIC $(LOCAL_CFLAGS) $(LOCAL_CONLYFLAGS) $(CPPFLAGS) $(CFLAGS) $(LOCAL_C_INCLUDES_PARAMS) $^

$(LOCAL_CXX_OBJ_FILES):
$(LOCAL_CXX_OBJ_FILES): LOCAL_CFLAGS := $(LOCAL_CFLAGS)
$(LOCAL_CXX_OBJ_FILES): LOCAL_CONLY_FLAGS := $(LOCAL_CONLYFLAGS)
$(LOCAL_CXX_OBJ_FILES): CPPFLAGS := $(CPPFLAGS)
$(LOCAL_CXX_OBJ_FILES): CXXFLAGS := $(CXXFLAGS)
$(LOCAL_CXX_OBJ_FILES): LOCAL_C_INCLUDES_PARAMS := $(LOCAL_C_INCLUDES_PARAMS)
$(LOCAL_CXX_OBJ_FILES): $(LOCAL_SRC_FILES)
	$(CXX) -c -fPIC $(LOCAL_CFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(LOCAL_C_INCLUDES_PARAMS) $^
