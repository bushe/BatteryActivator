include theos/makefiles/common.mk

TWEAK_NAME = BatteryActivator
BatteryActivator_FILES = Tweak.xm BatteryActivatorDataSource.xm
BatteryActivator_FRAMEWORKS = UIKit
BatteryActivator_LIBRARIES = activator

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += batteryactivatorsettings
include $(THEOS_MAKE_PATH)/aggregate.mk
