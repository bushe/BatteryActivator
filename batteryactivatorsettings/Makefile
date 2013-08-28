include theos/makefiles/common.mk

BUNDLE_NAME = BatteryActivatorSettings
BatteryActivatorSettings_FILES = BatteryActivatorSettings.mm
BatteryActivatorSettings_INSTALL_PATH = /Library/PreferenceBundles
BatteryActivatorSettings_FRAMEWORKS = UIKit
BatteryActivatorSettings_PRIVATE_FRAMEWORKS = Preferences
BatteryActivatorSettings_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/BatteryActivatorSettings.plist$(ECHO_END)
