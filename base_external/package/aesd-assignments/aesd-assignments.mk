
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
AESD_ASSIGNMENTS_VERSION = aecaa2ccb6d42bd6409e3a0faef0f9309e18b101
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-shrutikalyankar.git
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

AESD_ASSIGNMENTS_SUBDIR = assignment-3-shrutikalyankar

define AESD_ASSIGNMENTS_BUILD_CMDS
        $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
        $(MAKE) -C $(@D)/server \
                CC="$(TARGET_CC)" \
                CFLAGS="$(TARGET_CFLAGS)" \
                LDFLAGS="$(TARGET_LDFLAGS)"
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
        # Create target directories
        $(INSTALL) -d 0755 $(TARGET_DIR)/usr/bin
        $(INSTALL) -d 0755 $(TARGET_DIR)/etc/finder-app/conf

        # Install config files
        $(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/

        # Install scripts
        $(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/
        $(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/

        # Install writer binary (built in BUILD_CMDS)
        $(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/

        $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket \
                $(TARGET_DIR)/usr/bin/aesdsocket

        $(INSTALL) -D -m 0755 $(@D)/server/aesdsocket-start-stop \
                $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef


$(eval $(generic-package))
