-- Copyright 2015-2020 Loy B. <lonord.b@gmail.com>
-- Licensed to the public under the GNU General Public License v3.0.

require("luci.sys")

m = Map("ss-domain-rule", translate("Shadowsocks Domain-based Rules"), translate("Configure domain-based redirection rules of shadowsocks."))

s = m:section(NamedSection, "general", "general", "")
s.addremove = false
s.anonymous = true

o = s:option(Flag, "enable", translate("Enable"))

o = s:option(DynamicList, "forward_domain", translate("Forward Domain"), translate("Forward through ss-redir for packets with dst domain in this list"))
o.datatype = "hostname"

o = s:option(DynamicList, "bypass_domain", translate("Bypass Domain"), translate("Bypass ss-redir for packets with dst domain in this list"))
o.datatype = "hostname"

o = s:option(Value, "forward_ipset_name", translate("Forward IPSet Name"), translate("Setname of ipset used by ss-rule to forward packages"))

o = s:option(Value, "bypass_ipset_name", translate("Bypass IPSet Name"), translate("Setname of ipset used by ss-rule to bypass packages"))

o = s:option(Flag, "dns_forward_enable", translate("Use Alternative DNS Server"), translate("Use alternative DNS server for forwarded domain"))

o = s:option(Value, "dns_forward_addr", translate("Alternative DNS Server IP"), translate("IP of alternative DNS server for forwarded domain"))
o.datatype = "ip4addr"
o:depends("dns_forward_enable", "1")

o = s:option(Value, "dns_forward_port", translate("Alternative DNS Server Port"), translate("Port of alternative DNS server for forwarded domain"))
o.datatype = "port"
o:depends("dns_forward_enable", "1")

o = s:option(Flag, "gfwlist_enable", translate("Use GFWList"), translate("Add domain in GFWList to forward domain"))

gfw_update_date = luci.sys.exec("/etc/init.d/ss-domain-rule gfwlist -l")
if gfw_update_date == nil or gfw_update_date == "" then
	gfw_update_date = translate("Never")
end
o = s:option(Flag, "gfwlist_auto_update", translate("Auto Update GFWList"), "%s (%s: %s)" % { translate("Auto update GFWList every day"), translate("Last update"), gfw_update_date })
o:depends("gfwlist_enable", "1")

return m