#
# Copyright 2015-2020 Loy B. <lonord.b@gmail.com>
# Licensed to the public under the GNU General Public License v3.0.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ss-domain-rule
PKG_VERSION:=1.0.0
PKG_RELEASE:=1

PKG_LICENSE:=GPLv3
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Loy B. <lonord.b@gmail.com>

LUCI_TITLE:=LuCI support for domain-based shadowsocks rules
LUCI_DEPENDS:=+libustream-openssl +ca-certificates +shadowsocks-libev
LUCI_PKGARCH:=all

define Package/$(PKG_NAME)/conffiles
/etc/config/ss-domain-rule
endef

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/postinst
#!/bin/sh
if [ -z "$${IPKG_INSTROOT}" ]; then
	( . /etc/uci-defaults/40_luci-ss-domain-rule ) && rm -f /etc/uci-defaults/40_luci-ss-domain-rule
fi

chmod 755 "$${IPKG_INSTROOT}/etc/init.d/ss-domain-rule" >/dev/null 2>&1
$${IPKG_INSTROOT}/etc/init.d/ss-domain-rule enable >/dev/null 2>&1
exit 0
endef

# call BuildPackage - OpenWrt buildroot signature