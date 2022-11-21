EINK_VERSION = 77078c97e3834c81dd310db4340755921112d2e7
EINK_SITE = git@[INTERNAL_HOST]:eink
EINK_SITE_METHOD = git
EINK_PREFIX = $(TARGET_DIR)/usr

define EINK_BUILD_CMDS
     $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define EINK_INSTALL_TARGET_CMDS
        (cd $(@D); cp main $(EINK_PREFIX)/bin)
endef

define EINK_CLEAN_CMDS
        $(MAKE) $(EINK_MAKE_OPTS) -C $(@D) clean
endef

$(eval $(generic-package))
