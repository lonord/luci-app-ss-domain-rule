-- Copyright 2015-2020 Loy B. <lonord.b@gmail.com>
-- Licensed to the public under the GNU General Public License v3.0.

require("luci.sys")

m = Map("ss-domain-rule", translate("Shadowsocks Domain-based Rules"), translate("Configure domain-based redirection rules of shadowsocks."))

s = m:section(NamedSection, "general", "general", "")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))
o.rmempty = false

o = s:option(DynamicList, "forward_domain", translate("Forward Domain"), translate("Forward through ss-redir for packets with dst domain in this list"))
o.datatype = "hostname"

o = s:option(DynamicList, "bypass_domain", translate("Bypass Domain"), translate("Bypass ss-redir for packets with dst domain in this list"))
o.datatype = "hostname"

o = s:option(Value, "forward_ipset_name", translate("Forward IPSet Name"), translate("Setname of ipset used by ss-rule to forward packages"))

o = s:option(Value, "bypass_ipset_name", translate("Bypass IPSet Name"), translate("Setname of ipset used by ss-rule to bypass packages"))

o = s:option(Flag, "gfwlist_enable", translate("Use GFWList"), translate("Add domain in GFWList to forward domain"))

o = s:option(Flag, "gfwlist_auto_update", translate("Auto Update GFWList"), translate("Auto update GFWList every day"))
o:depends("gfwlist_enable", "1")

gfw_update_date = luci.sys.exec("/etc/init.d/ss-domain-rule gfwlist -l")
if gfw_update_date == nil or gfw_update_date == "" then
	gfw_update_date = translate("Never")
end
o = s:option(Button, "_update", translate("Update GFWList"), "%s: %s" % { translate("Last update"), gfw_update_date })
o.inputtitle = translate("Update Now")
o.inputstyle = "apply"
o.write = function ()
	luci.sys.exec("/etc/init.d/ss-domain-rule gfwlist -u -b")
	o.description = translate("Update action proceeded")
	return 1
end
o:depends("gfwlist_enable", "1")

return m