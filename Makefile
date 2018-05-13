TARGET = iphone:clang:11.2:latest
ARCHS = arm64

GO_EASY_ON_ME = 1
FINALPACKAGE = 1
DEBUG = 0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = ToothModule
$(BUNDLE_NAME)_BUNDLE_EXTENSION = bundle
$(BUNDLE_NAME)_CFLAGS +=  -fobjc-arc -I$(THEOS_PROJECT_DIR)/headers
$(BUNDLE_NAME)_FILES = $(wildcard *.m) $(wildcard *.xm) $(wildcard BluetoothManager/*.m)
$(BUNDLE_NAME)_PRIVATE_FRAMEWORKS = BluetoothManager
$(BUNDLE_NAME)_LDFLAGS += $(THEOS_PROJECT_DIR)/Frameworks/ControlCenterUIKit.tbd
$(BUNDLE_NAME)_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk

SUBPROJECTS += preferences

include $(THEOS_MAKE_PATH)/aggregate.mk
