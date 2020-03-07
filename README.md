# luci-app-ss-domain-rule

[![build](https://img.shields.io/travis/lonord/luci-app-ss-domain-rule.svg?style=flat-square)](https://travis-ci.org/lonord/luci-app-ss-domain-rule)

运行于OpenWrt/LEDE上的Shadowsocks域名规则，支持gfwlist

## 安装

1. 到 [release](https://github.com/lonord/luci-app-ss-domain-rule/releases) 页面下载最新版 luci-app-ss-domain-rule 和 luci-i18n-ss-domain-rule-zh-cn (简体中文翻译文件)
2. 将下载好的 ipk 文件上传到路由器任意目录下, 如 /tmp
3. 首先安装依赖包`dnsmasq-full`，需要加上`--force-overwrite`参数
4. 随后安装 luci-app-ss-domain-rule 再安装 luci-i18n-ss-domain-rule-zh-cn

```sh
opkg update
opkg install --force-overwrite dnsmasq-full
opkg install luci-app-ss-domain-rule_*.ipk
opkg install luci-i18n-ss-domain-rule-zh-cn_*.ipk
```

## 使用

以gfwlist+ss透明代理+dns转发为例

1. 首先配置Shadowsocks-libev的ss-redir服务用于TCP流量转发，同时需要开启Shadowsocks-libev的转发规则
2. 配置ss-tunnel用于转发dns请求，监听本地5353端口，对端地址为8.8.8.8:53
3. 进入Shadowsocks域名规则页面开启服务，勾选‘指定其他DNS服务器’，保存并应用

## 卸载

卸载时需要先卸载 luci-i18n-ss-domain-rule-zh-cn, 再卸载 luci-app-ss-domain-rule

```sh
opkg remove luci-i18n-ss-domain-rule-zh-cn
opkg remove luci-app-ss-domain-rule
```

## 许可证

GPLv3
