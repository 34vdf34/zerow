TELEMETRYMSG_VERSION = dad64184d48b1867b452b2b02a0f1cf0e06cb044
TELEMETRYMSG_SITE = https://codeberg.org/48554e6d/telemetrymsg.git
TELEMETRYMSG_SITE_METHOD = git
TELEMETRYMSG_DEPENDENCIES = libcurl
TELEMETRYMSG_PREFIX = $(TARGET_DIR)/usr

define TELEMETRYMSG_BUILD_CMDS
     $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define TELEMETRYMSG_INSTALL_TARGET_CMDS
        (cd $(@D); cp telemetryclient telemetryserver $(TELEMETRYMSG_PREFIX)/bin)
endef

define TELEMETRYMSG_CLEAN_CMDS
        $(MAKE) $(TELEMETRYMSG_MAKE_OPTS) -C $(@D) clean
endef

$(eval $(generic-package))
