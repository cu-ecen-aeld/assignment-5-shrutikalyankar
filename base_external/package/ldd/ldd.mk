LDD_VERSION = ecd4bd53db2c6a1f826cb9adc1b87ff6a5d6ec53

LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-shrutikalyankar.git
LDD_SITE_METHOD = git

LDD_LICENSE = GPL-2.0
LDD_LICENSE_FILES = COPYING

LDD_MODULE_SUBDIRS = misc-modules scull

$(eval $(kernel-module))
$(eval $(generic-package))
