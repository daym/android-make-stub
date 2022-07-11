# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is licensed under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := header-test
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := hello.c
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

include $(BUILD_HOST_EXECUTABLE)
