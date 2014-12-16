export ARCHS=armv7 arm64
export TARGET=iphone:latest:7.0
export TARGET_CODESIGN=theos/bin/ldid

include theos/makefiles/common.mk

TWEAK_NAME = Round
Round_FILES = Tweak.xm
Round_FRAMEWORKS = UIKit QuartzCore

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
