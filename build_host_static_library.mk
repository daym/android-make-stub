
LOCAL_OBJ_FILES := $(patsubst %.c,%.o,$(LOCAL_SRC_FILES))
LOCAL_C_INCLUDES_PARAMS := -I $(GOOGLETEST_INCLUDE) -I ../base/include -I ../include -I ../libsparse/include $(foreach d, $(LOCAL_C_INCLUDES), -I $d)

$(LOCAL_MODULE).a: $(LOCAL_OBJ_FILES)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) -c $(LOCAL_CFLAGS) -I $(LOCAL_C_INCLUDES_PARAMS) $<
