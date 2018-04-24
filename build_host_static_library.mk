
LOCAL_OBJ_FILES := $(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES))))
LOCAL_C_INCLUDES_PARAMS := -I ../base/include -I ../include -I ../libsparse/include $(foreach d, $(LOCAL_C_INCLUDES), -I $d)

$(LOCAL_MODULE).a: $(LOCAL_OBJ_FILES)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) -c $(CFLAGS) $(LOCAL_CFLAGS) -I $(LOCAL_C_INCLUDES_PARAMS) $<

%.o: %.cc
	$(CXX) -c $(CFLAGS) $(LOCAL_CFLAGS) -I $(LOCAL_C_INCLUDES_PARAMS) $<
