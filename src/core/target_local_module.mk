# Copyright (C) 2022 Denis 'GNUtoo' Carikli <GNUtoo@cyberdimension.org>
#
# This file is licensed under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# This enables to build specific LOCAL_MODULE with
# make [...] TARGET=<local module name>
#
# To enable to match a LOCAL_MODULE you need to include this file with
#     include $(BUILD_SYSTEM)target_local_module.mk
#
# Then you need to wrap the code that won't be executed if the TARGET=
# is different with the following code:
#     ifeq ($(LOCAL_MODULE),$(TARGET))
#     [...]
#     endif # ifeq ($(LOCAL_MODULE),$(TARGET))

ifeq ($(strip $(TARGET)),)
ifneq ($(strip $(LOCAL_MODULE)),)
TARGET := $(LOCAL_MODULE)
endif # ($(strip $(LOCAL_MODULE)),)
endif # ifeq ($(strip $(TARGET)),)

