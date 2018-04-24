
LOCAL_OBJ_FILES := $(patsubst %.c,%.o,$(LOCAL_SRC_FILES))

$(LOCAL_MODULE).a: $(LOCAL_OBJ_FILES)
	$(AR) rcs $@ $^

%.o: %.c
	$(CC) -c $(LOCAL_CFLAGS) -I $(LOCAL_C_INCLUDESX) $<
