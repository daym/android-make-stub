
# 1:1 copy of parts of build_host_executable.mk

LOCAL_C_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.c,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux))))
LOCAL_CXX_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux)))))
LOCAL_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux))))))

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

$(LOCAL_MODULE): LOCAL_SRC_FILES := $(LOCAL_SRC_FILES)
$(LOCAL_MODULE): LOCAL_C_INCLUDES := $(LOCAL_C_INCLUDES)
$(LOCAL_MODULE): LOCAL_CFLAGS := $(LOCAL_CFLAGS)
$(LOCAL_MODULE): LOCAL_LDFLAGS := $(LOCAL_LDFLAGS)
$(LOCAL_MODULE): LOCAL_LDLIBS := $(LOCAL_LDLIBS)
$(LOCAL_MODULE): LOCAL_OBJ_FILES := $(LOCAL_OBJ_FILES)
$(LOCAL_MODULE): LOCAL_STATIC_LIBRARIES := $(LOCAL_STATIC_LIBRARIES)
$(LOCAL_MODULE): LOCAL_STATIC_LIBRARIES_PARAMS := $(foreach d,$(LOCAL_STATIC_LIBRARIES),-l$(patsubst lib%,%,$d))
$(LOCAL_MODULE): LOCAL_C_INCLUDES_PARAMS := -I ../base/include -I ../include -I ../libsparse/include $(foreach d,$(LOCAL_C_INCLUDES),-I $d)
$(LOCAL_MODULE): LOCAL_C_LIBS_PARAMS := $(foreach d,$(LOCAL_STATIC_LIBRARIES),-L ../$(patsubst %-host,%,$(patsubst %_host,%,$d)))
$(LOCAL_MODULE): CPPFLAGS := $(CPPFLAGS)
$(LOCAL_MODULE): CFLAGS := $(CFLAGS)
$(LOCAL_MODULE): LDFLAGS := $(LDFLAGS) -lgtest_host
$(LOCAL_MODULE): LOCAL_CONLYFLAGS := $(LOCAL_CONLYFLAGS)

$(LOCAL_MODULE): $(LOCAL_OBJ_FILES) $(built_static_libraries) $(built_shared_libraries)
	$(CXX) -o $@ $(LOCAL_OBJ_FILES) $(LOCAL_LDFLAGS) $(LOCAL_LDLIBS) $(LOCAL_C_LIBS_PARAMS) $(LDFLAGS) $(LOCAL_STATIC_LIBRARIES_PARAMS)

.PHONY: check
check: $(LOCAL_MODULE)
	$(LOCAL_MODULE)
