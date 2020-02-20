-- Copyright 2015-2020 Loy B. <lonord.b@gmail.com>
-- Licensed to the public under the GNU General Public License v3.0.

module("luci.controller.ss-domain-rule", package.seeall)

function index()
	if not nixio.fs.access("/etc/config/ss-domain-rule") then
		return
	end

	entry({"admin", "services", "ss-domain-rule"}, cbi("ss-domain-rule/settings"), _("Shadowsocks Domain-based Rules")).dependent=false

end