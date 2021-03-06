
LOCAL_C_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.c,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux))))
LOCAL_CXX_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux)))))
LOCAL_OBJ_FILES := $(notdir $(filter %.o,$(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES) $(LOCAL_SRC_FILES_linux))))))
LOCAL_C_INCLUDES_PARAMS := -I ../base/include -I ../include -I ../libsparse/include $(foreach d, $(LOCAL_C_INCLUDES), -I $d)

built_static_libraries := $(built_static_libraries) $(LOCAL_MODULE).a

.PHONY: all
all: $(LOCAL_MODULE).a

$(LOCAL_MODULE).a: $(LOCAL_OBJ_FILES)
	$(AR) rcs $@ $^

.PHONY: install
install: install-$(LOCAL_MODULE).a
install-$(LOCAL_MODULE).a: LOCAL_MODULE := $(LOCAL_MODULE)
install-$(LOCAL_MODULE).a: $(LOCAL_MODULE).a
	install -m 755 -d $(prefix)/lib
	install -m 755 $(LOCAL_MODULE).a $(prefix)/lib/$(LOCAL_MODULE).a

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
