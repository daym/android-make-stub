# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is licensed under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0

include $(CLEAR_VARS)

LOCAL_MODULE := invalid-start
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := invalid-start.c

include $(BUILD_HOST_EXECUTABLE)

include $(CLEAR_VARS)

LOCAL_MODULE := hello
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := ../common/hello.c

include $(BUILD_HOST_EXECUTABLE)


include $(CLEAR_VARS)

LOCAL_MODULE := invalid-end
LOCAL_MODULE_TAGS := optional
LOCAL_SRC_FILES := invalid-end.c

include $(BUILD_HOST_EXECUTABLE)
