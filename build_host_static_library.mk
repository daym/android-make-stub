
LOCAL_OBJ_FILES := $(patsubst %.cpp,%.o,$(patsubst %.c,%.o,$(patsubst %.cc,%.o,$(LOCAL_SRC_FILES))))
LOCAL_C_INCLUDES_PARAMS := -I ../base/include -I ../include -I ../libsparse/include $(foreach d, $(LOCAL_C_INCLUDES), -I $d)

$(LOCAL_MODULE).a: $(LOCAL_OBJ_FILES)
	$(AR) rcs $@ $^

.PHONY: install
install: install-$(LOCAL_MODULE).a
install-$(LOCAL_MODULE).a: LOCAL_MODULE := $(LOCAL_MODULE)
install-$(LOCAL_MODULE).a: $(LOCAL_MODULE).a
	install -m 755 -d $(prefix)/lib
	install -m 755 $(LOCAL_MODULE).a $(prefix)/lib/$(LOCAL_MODULE).a

%.o: %.c
	$(CC) -c $(CFLAGS) $(LOCAL_CFLAGS) -I $(LOCAL_C_INCLUDES_PARAMS) $<

%.o: %.cc
	$(CXX) -c $(CFLAGS) $(LOCAL_CFLAGS) -I $(LOCAL_C_INCLUDES_PARAMS) $<
