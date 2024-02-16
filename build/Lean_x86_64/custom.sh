
#!/bin/bash

# 安装额外依赖软件包
# sudo -E apt-get -y install rename

# 更新feeds文件
# sed -i 's@#src-git helloworld@src-git helloworld@g' feeds.conf.default #启用helloworld
cat feeds.conf.default

# 添加第三方软件包
#git clone https://github.com/db-one/dbone-packages.git -b 18.06 package/dbone-packages
git clone https://github.com/jerrykuku/lua-maxminddb package/lua-maxminddb
git clone https://github.com/0118Add/luci-app-vssr package/luci-app-vssr
git clone https://github.com/xiaorouji/openwrt-passwall package/passwall
git clone https://github.com/xiaorouji/openwrt-passwall-packages package/openwrt-passwall
git clone -b dev --depth 1 https://github.com/vernesong/OpenClash package/luci-app-openclash
git clone https://github.com/sirpdboy/luci-app-ddns-go package/luci-app-ddns-go
git clone https://github.com/sirpdboy/luci-app-partexp package/luci-app-partexp
git clone -b master https://github.com/0118Add/luci-app-unblockneteasemusic.git package/luci-app-unblockneteasemusic
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone https://github.com/gngpp/luci-theme-design package/luci-theme-design

# 更新并安装源
./scripts/feeds clean
./scripts/feeds update -a && ./scripts/feeds install -a -f

# 删除部分默认包
rm -rf feeds/luci/applications/luci-app-qbittorrent
rm -rf feeds/luci/applications/luci-app-vlmcsd
rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/themes/luci-theme-design

#rm -rf package/lean/autocore

# 修改概览里时间显示为中文数字
sed -i 's/os.date()/os.date("%Y-%m-%d") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")/g' package/lean/autocore/files/x86/index.htm

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}/g' package/lean/autocore/files/x86/autocore

# 修改连接数
sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# 修改系统文件
curl -fsSL https://raw.githubusercontent.com/0118Add/N1-Actions-Dabao56/master/backup/x86index.htm > ./package/lean/autocore/files/x86/index.htm
#curl -fsSL https://raw.githubusercontent.com/0118Add/N1-Actions-Dabao56/master/backup/x86index.htm > ./package/lean/autocore/files/x86/index.htm
curl -fsSL https://raw.githubusercontent.com/0118Add/OpenWrt/main/scripts/autocore > ./package/lean/autocore/files/x86/autocore
curl -fsSL https://raw.githubusercontent.com/0118Add/OpenWrt/main/images/cpuinfo > ./package/lean/autocore/files/x86/sbin/cpuinfo

# 修改插件名字（修改名字后不知道会不会对插件功能有影响，自己多测试）
#sed -i 's/广告屏蔽大师 Plus+/广告屏蔽/g' feeds/luci/applications/luci-app-adbyby-plus/po/zh-cn/adbyby.po
sed -i 's/Argon 主题设置/Argon设置/g' feeds/luci/applications/luci-app-argon-config/po/zh-cn/argon-config.po
sed -i 's/Design 主题设置/Design设置/g' feeds/luci/applications/luci-app-design-config/po/zh-cn/design-config.po
sed -i 's/一键分区扩容/分区扩容/g' package/luci-app-partexp/po/zh-cn/partexp.po
#sed -i 's/"管理权"/"改密码"/g' feeds/luci/modules/luci-base/po/zh-cn/base.po
#sed -i 's/TTYD 终端/命令行/g' feeds/luci/applications/luci-app-ttyd/po/zh-cn/terminal.po
#sed -i 's/Hello World/OverWall/g' package/luci-app-vssr/luasrc/controller/vssr.lua
#sed -i 's/ShadowSocksR Plus+/SSR Plus+/g' package/helloworld/luci-app-ssr-plus/luasrc/controller/shadowsocksr.lua
#sed -i 's/msgstr "KMS 服务器"/msgstr "KMS激活"/g' feeds/luci/applications/luci-app-vlmcsd/po/zh-cn/vlmcsd.po
#sed -i 's/msgstr "UPnP"/msgstr "UPnP设置"/g' feeds/luci/applications/luci-app-upnp/po/zh-cn/upnp.po
#sed -i 's/Frp 内网穿透/内网穿透/g' feeds/luci/applications/luci-app-frpc/po/zh-cn/frp.po
#sed -i 's/Frpc内网穿透/内网穿透/g' package/luci-app-multi-frpc/po/zh-cn/frp.po
sed -i 's/解除网易云音乐播放限制/音乐解锁/g' package/luci-app-unblockneteasemusic/luasrc/controller/unblockneteasemusic.lua
#sed -i 's/"阿里云盘 WebDAV"/"阿里云盘"/g' package/aliyundrive-webdav/openwrt/luci-app-aliyundrive-webdav/po/zh-cn/aliyundrive-webdav.po
#sed -i 's/V2ray 服务器/V2ray服务/g' feeds/luci/applications/luci-app-v2ray-server/po/zh-cn/v2ray_server.po
#sed -i 's/SoftEther VPN 服务器/SoftEther/g' feeds/luci/applications/luci-app-softethervpn/po/zh-cn/softethervpn.po
#sed -i 's/firstchild(), "VPN"/firstchild(), "GFW"/g' feeds/luci/applications/luci-app-softethervpn/luasrc/controller/softethervpn.lua
#sed -i 's/IPSec VPN 服务器/IPSec VPN/g' feeds/luci/applications/luci-app-ipsec-vpnd/po/zh-cn/ipsec.po
sed -i 's/WireGuard 状态/WiGd状态/g' feeds/luci/applications/luci-app-wireguard/po/zh-cn/wireguard.po
sed -i 's/Turbo ACC 网络加速/网络加速/g' feeds/luci/applications/luci-app-turboacc/po/zh-cn/turboacc.po

# 自定义定制选项
NET="package/base-files/files/bin/config_generate"
ZZZ="package/lean/default-settings/files/zzz-default-settings"
# 读取内核版本
KERNEL_PATCHVER=$(cat target/linux/x86/Makefile|grep KERNEL_PATCHVER | sed 's/^.\{17\}//g')
KERNEL_TESTING_PATCHVER=$(cat target/linux/x86/Makefile|grep KERNEL_TESTING_PATCHVER | sed 's/^.\{25\}//g')
if [[ $KERNEL_TESTING_PATCHVER > $KERNEL_PATCHVER ]]; then
  sed -i "s/$KERNEL_PATCHVER/$KERNEL_TESTING_PATCHVER/g" target/linux/x86/Makefile        # 修改内核版本为最新
  echo "内核版本已更新为 $KERNEL_TESTING_PATCHVER"
else
  echo "内核版本不需要更新"
fi

#
sed -i 's#192.168.1.1#10.0.0.1#g' $NET                                                    # 定制默认IP
# sed -i 's#OpenWrt#OpenWrt-X86#g' $NET                                                     # 修改默认名称为OpenWrt-X86
sed -i 's@.*CYXluq4wUazHjmCDBCqXF*@#&@g' $ZZZ                                             # 取消系统默认密码
#sed -i "s/OpenWrt /ONE build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ              # 增加自己个性名称
# sed -i "/uci commit luci/i\uci set luci.main.mediaurlbase=/luci-static/neobird" $ZZZ        # 设置默认主题(如果编译可会自动修改默认主题的，有可能会失效)
# sed -i 's#localtime  = os.date()#localtime  = os.date("%Y年%m月%d日") .. " " .. translate(os.date("%A")) .. " " .. os.date("%X")#g' package/lean/autocore/files/*/index.htm               # 修改默认时间格式

# ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● #
sed -i 's#%D %V, %C#%D %V, %C Lean_x86_64#g' package/base-files/files/etc/banner               # 自定义banner显示
sed -i 's@list listen_https@# list listen_https@g' package/network/services/uhttpd/files/uhttpd.config               # 停止监听443端口
# sed -i 's#option commit_interval 24h#option commit_interval 10m#g' feeds/packages/net/nlbwmon/files/nlbwmon.config               # 修改流量统计写入为10分钟
# sed -i 's#option database_generations 10#option database_generations 3#g' feeds/packages/net/nlbwmon/files/nlbwmon.config               # 修改流量统计数据周期
# sed -i 's#option database_directory /var/lib/nlbwmon#option database_directory /etc/config/nlbwmon_data#g' feeds/packages/net/nlbwmon/files/nlbwmon.config               # 修改流量统计数据存放默认位置
#sed -i 's#interval: 5#interval: 1#g' feeds/luci/applications/luci-app-wrtbwmon/htdocs/luci-static/wrtbwmon/wrtbwmon.js               # wrtbwmon默认刷新时间更改为1秒
#sed -i '/exit 0/i\ethtool -s eth0 speed 10000 duplex full' package/base-files/files//etc/rc.local               # 强制显示2500M和全双工（默认PVE下VirtIO不识别）

# ●●●●●●●●●●●●●●●●●●●●●●●●定制部分●●●●●●●●●●●●●●●●●●●●●●●● #

cat >> $ZZZ <<-EOF
# 设置旁路由模式
#uci set network.lan.gateway='10.0.0.254'                     # 旁路由设置 IPv4 网关
#uci set network.lan.dns='223.5.5.5 119.29.29.29'            # 旁路由设置 DNS(多个DNS要用空格分开)
#uci set dhcp.lan.ignore='1'                                  # 旁路由关闭DHCP功能
#uci delete network.lan.type                                  # 旁路由桥接模式-禁用
#uci set network.lan.delegate='0'                             # 去掉LAN口使用内置的 IPv6 管理(若用IPV6请把'0'改'1')
#uci set dhcp.@dnsmasq[0].filter_aaaa='1'                     # 禁止解析 IPv6 DNS记录(若用IPV6请把'1'改'0')

# 旁路IPV6需要全部禁用
#uci set network.lan.ip6assign=''                             # IPV6分配长度-禁用
#uci set dhcp.lan.ra=''                                       # 路由通告服务-禁用
#uci set dhcp.lan.dhcpv6=''                                   # DHCPv6 服务-禁用
#uci set dhcp.lan.ra_management=''                            # DHCPv6 模式-禁用

# 如果有用IPV6的话,可以使用以下命令创建IPV6客户端(LAN口)（去掉全部代码uci前面#号生效）
#uci set network.ipv6=interface
#uci set network.ipv6.proto='dhcpv6'
#uci set network.ipv6.ifname='eth0'
#uci set network.ipv6.reqaddress='try'
#uci set network.ipv6.reqprefix='auto'
#uci set firewall.@zone[0].network='lan ipv6'

EOF

# 修改退出命令到最后
sed -i '/exit 0/d' $ZZZ && echo "exit 0" >> $ZZZ

# ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● #


# ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● #
# 下载 OpenClash 内核
grep "CONFIG_PACKAGE_luci-app-openclash=y" $WORKPATH/$CUSTOM_SH >/dev/null
if [ $? -eq 0 ]; then
  echo "正在执行：为OpenClash下载内核"
  mkdir -p $HOME/clash-core
  mkdir -p $HOME/files/etc/openclash/core
  cd $HOME/clash-core
# 下载Dve内核
  wget -q https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-amd64.tar.gz
  if [[ $? -ne 0 ]];then
    wget -q https://github.com/vernesong/OpenClash/releases/download/Clash/clash-linux-amd64.tar.gz
  else
    echo "OpenClash Dve内核压缩包下载成功，开始解压文件"
  fi
  tar -zxvf clash-linux-amd64.tar.gz
  if [[ -f "$HOME/clash-core/clash" ]]; then
    mkdir -p $HOME/files/etc/openclash/core
    mv -f $HOME/clash-core/clash $HOME/files/etc/openclash/core/clash
    chmod +x $HOME/files/etc/openclash/core/clash
    echo "OpenClash Dve内核配置成功"
  else
    echo "OpenClash Dve内核配置失败"
  fi
  rm -rf $HOME/clash-core/clash-linux-amd64.tar.gz
# 下载Meta内核
  wget -q https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz
  if [[ $? -ne 0 ]];then
    wget -q https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-amd64.tar.gz
  else
    echo "OpenClash Meta内核压缩包下载成功，开始解压文件"
  fi
  tar -zxvf clash-linux-amd64.tar.gz
  if [[ -f "$HOME/clash-core/clash" ]]; then
    mv -f $HOME/clash-core/clash $HOME/files/etc/openclash/core/clash_meta
    chmod +x $HOME/files/etc/openclash/core/clash_meta
    echo "OpenClash Meta内核配置成功"
  else
    echo "OpenClash Meta内核配置失败"
  fi
  rm -rf $HOME/clash-core/clash-linux-amd64.tar.gz
# 下载TUN内核
  wget -q  https://raw.githubusercontent.com/vernesong/OpenClash/core/master/core_version
  TUN="clash-linux-amd64-"$(sed -n '2p' core_version)".gz"
  wget -q https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/$TUN
  if [[ $? -ne 0 ]];then
    wget -q https://raw.githubusercontent.com/vernesong/OpenClash/core/master/premium/$TUN
  else
    echo "OpenClash TUN内核压缩包下载成功，开始解压文件"
  fi
  gunzip  $TUN
  TUNS="$(ls | grep -Eo "clash-linux-amd64-.*")"
  if [[ -f "$HOME/clash-core/$TUNS" ]]; then
    mv -f $HOME/clash-core/clash-linux-amd64-* $HOME/files/etc/openclash/core/clash_tun
    chmod +x $HOME/files/etc/openclash/core/clash_tun
    echo "OpenClash TUN内核配置成功"
  else
    echo "OpenClash TUN内核配置失败"
  fi
  rm -rf $HOME/clash-core/$TUN

  rm -rf $HOME/clash-core
fi

# ●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●● #


# 创建自定义配置文件

cd $WORKPATH
touch ./.config

#
# ●●●●●●●●●●●●●●●●●●●●●●●●固件定制部分●●●●●●●●●●●●●●●●●●●●●●●●
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
#        ■|  # 取消编译VMware镜像:                    |■
#        ■|  cat >> .config <<EOF                   |■
#        ■|  # CONFIG_VMDK_IMAGES is not set        |■
#        ■|  EOF                                    |■
#          ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译x64固件:
cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
EOF

# 设置固件大小:
cat >> .config <<EOF
CONFIG_TARGET_KERNEL_PARTSIZE=16
CONFIG_TARGET_ROOTFS_PARTSIZE=500
EOF

# 固件压缩:
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_GZIP=y
EOF

# 编译UEFI固件:
cat >> .config <<EOF
CONFIG_EFI_IMAGES=y
CONFIG_TARGET_ROOTFS_TARGZ=y
EOF

# IPv6支持:
cat >> .config <<EOF
CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
CONFIG_PACKAGE_ipv6helper=y
EOF

# 编译PVE/KVM、Hyper-V、VMware镜像以及镜像填充
cat >> .config <<EOF
CONFIG_QCOW2_IMAGES=y
CONFIG_VHDX_IMAGES=y
CONFIG_VMDK_IMAGES=y
CONFIG_TARGET_IMAGES_PAD=y
EOF

# 多文件系统支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-fs-nfs=y
# CONFIG_PACKAGE_kmod-fs-nfs-common=y
# CONFIG_PACKAGE_kmod-fs-nfs-v3=y
# CONFIG_PACKAGE_kmod-fs-nfs-v4=y
# CONFIG_PACKAGE_kmod-fs-ntfs=y
# CONFIG_PACKAGE_kmod-fs-squashfs=y
# EOF

# USB3.0支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-usb-ohci=y
# CONFIG_PACKAGE_kmod-usb-ohci-pci=y
# CONFIG_PACKAGE_kmod-usb2=y
# CONFIG_PACKAGE_kmod-usb2-pci=y
# CONFIG_PACKAGE_kmod-usb3=y
# EOF

# 多线多拨:
# cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-syncdial=y #多拨虚拟WAN
# CONFIG_PACKAGE_luci-app-mwan3=y #MWAN负载均衡
# CONFIG_PACKAGE_luci-app-mwan3helper=n #MWAN3分流助手
# EOF

# 第三方插件选择:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-oaf is not set #应用过滤
CONFIG_PACKAGE_luci-app-openclash=y #OpenClash客户端
# CONFIG_PACKAGE_luci-app-serverchan is not set #微信推送
# CONFIG_PACKAGE_luci-app-eqos is not set #IP限速
# CONFIG_PACKAGE_luci-app-control-weburl is not set #网址过滤
# CONFIG_PACKAGE_luci-app-smartdns is not set #smartdns服务器
# CONFIG_PACKAGE_luci-app-adguardhome is not set #ADguardhome
# CONFIG_PACKAGE_luci-app-poweroff is not set #关机（增加关机功能）
CONFIG_PACKAGE_luci-app-argon-config=y #argon主题设置
CONFIG_PACKAGE_luci-app-design-config=y
# CONFIG_PACKAGE_luci-theme-atmaterial_new is not set #atmaterial 三合一主题
# CONFIG_PACKAGE_luci-theme-neobird is not set #Neobird 主题
# CONFIG_PACKAGE_luci-app-autotimeset is not set #定时重启系统，网络
# CONFIG_PACKAGE_luci-app-ddnsto is not set #小宝开发的DDNS.to内网穿透
# CONFIG_PACKAGE_ddnsto is not set #DDNS.to内网穿透软件包
EOF

# ShadowsocksR插件:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-ssr-plus=y
# CONFIG_PACKAGE_luci-app-ssr-plus_INCLUDE_SagerNet_Core is not set
EOF

# Passwall插件:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-passwall2 is not set
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_Iptables_Transparent_Proxy=y
# CONFIG_PACKAGE_luci-app-passwall_Nftables_Transparent_Proxy is not set
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Brook is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Haproxy=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Hysteria=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_NaiveProxy is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Libev_Client=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Libev_Server is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Client=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Shadowsocks_Rust_Server=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Client=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Server is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Simple_Obfs=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_SingBox=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_GO=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Trojan_Plus is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_tuic_client=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Geodata=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Plugin is not set
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray=y
# CONFIG_PACKAGE_luci-app-passwall_INCLUDE_Xray_Plugin is not set
EOF

# Turbo ACC 网络加速:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-turboacc=y
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_BBR_CCA=y
# CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_DNSFORWARDER is not set
# CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_DNSPROXY is not set
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_OFFLOADING=y
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_SHORTCUT_FE=y
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_SHORTCUT_FE_CM=y
CONFIG_PACKAGE_luci-app-turboacc_INCLUDE_SHORTCUT_FE_DRV=y
EOF

# 常用LuCI插件:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-adbyby-plus is not set #adbyby去广告
# CONFIG_PACKAGE_luci-app-webadmin is not set #Web管理页面设置
# CONFIG_PACKAGE_luci-app-ddns is not set #DDNS服务
# CONFIG_PACKAGE_ddns-scripts_aliyun is not set
# CONFIG_PACKAGE_ddns-scripts_dnspod is not set
# CONFIG_DEFAULT_luci-app-vlmcsd is not set
CONFIG_PACKAGE_luci-app-filetransfer=y #系统-文件传输
CONFIG_PACKAGE_luci-app-autoreboot=y #定时重启
# CONFIG_PACKAGE_luci-app-upnp is not set #通用即插即用UPnP(端口自动转发)
# CONFIG_PACKAGE_luci-app-arpbind is not set #IP/MAC绑定
# CONFIG_PACKAGE_luci-app-accesscontrol is not set #上网时间控制
# CONFIG_PACKAGE_luci-app-wol is not set #网络唤醒
# CONFIG_PACKAGE_luci-app-nps is not set #nps内网穿透
# CONFIG_PACKAGE_luci-app-frpc is not set #Frp内网穿透
# CONFIG_PACKAGE_luci-app-nlbwmon is not set #宽带流量监控
# CONFIG_PACKAGE_luci-app-wrtbwmon is not set #实时流量监测
# CONFIG_PACKAGE_luci-app-haproxy-tcp is not set #Haproxy负载均衡
CONFIG_PACKAGE_luci-app-diskman=y #磁盘管理磁盘信息
# CONFIG_PACKAGE_luci-app-transmission is not set #Transmission离线下载
# CONFIG_PACKAGE_luci-app-qbittorrent is not set #qBittorrent离线下载
# CONFIG_PACKAGE_luci-app-amule is not set #电驴离线下载
# CONFIG_PACKAGE_luci-app-xlnetacc is not set #迅雷快鸟
# CONFIG_PACKAGE_luci-app-zerotier is not set #zerotier内网穿透
# CONFIG_PACKAGE_luci-app-hd-idle is not set #磁盘休眠
# CONFIG_PACKAGE_luci-app-unblockmusic is not set #解锁网易云灰色歌曲
# CONFIG_PACKAGE_luci-app-airplay2 is not set #Apple AirPlay2音频接收服务器
# CONFIG_PACKAGE_luci-app-music-remote-center is not set #PCHiFi数字转盘遥控
# CONFIG_PACKAGE_luci-app-usb-printer is not set #USB打印机
# CONFIG_PACKAGE_luci-app-sqm is not set #SQM智能队列管理
# CONFIG_PACKAGE_luci-app-jd-dailybonus is not set #京东签到服务
# CONFIG_PACKAGE_luci-app-uugamebooster is not set #UU游戏加速器
# CONFIG_PACKAGE_luci-app-dockerman is not set #Docker管理
CONFIG_PACKAGE_luci-app-ddns-go=y
CONFIG_PACKAGE_luci-app-unblockneteasemusic=y
CONFIG_PACKAGE_luci-app-partexp=y
CONFIG_PACKAGE_luci-app-ttyd=y #ttyd
CONFIG_PACKAGE_luci-app-wireguard=y #wireguard端
CONFIG_PACKAGE_luci-app-vssr=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Xray=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Trojan=y
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Kcptun is not set
# CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Xray_plugin is not set
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_ShadowsocksR_Libev_Server=y
CONFIG_PACKAGE_luci-app-vssr_INCLUDE_Hysteria=y
#
# VPN相关插件(禁用):
#
# CONFIG_PACKAGE_luci-app-v2ray-server is not set #V2ray服务器
# CONFIG_PACKAGE_luci-app-pptp-server is not set #PPTP VPN 服务器
# CONFIG_PACKAGE_luci-app-ipsec-vpnd is not set #ipsec VPN服务
# CONFIG_PACKAGE_luci-app-openvpn-server is not set #openvpn服务
# CONFIG_PACKAGE_luci-app-softethervpn is not set #SoftEtherVPN服务器
#
# 文件共享相关(禁用):
#
# CONFIG_PACKAGE_luci-app-minidlna is not set #miniDLNA服务
# CONFIG_PACKAGE_luci-app-vsftpd is not set #FTP 服务器
# CONFIG_PACKAGE_luci-app-samba is not set #网络共享
# CONFIG_PACKAGE_autosamba is not set #网络共享
# CONFIG_PACKAGE_automount is not set
# CONFIG_PACKAGE_samba36-server is not set #网络共享
EOF

# LuCI主题:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-theme-argon=y
CONFIG_PACKAGE_luci-theme-design=y
EOF

# 常用软件包:
cat >> .config <<EOF
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
CONFIG_PACKAGE_screen=y
CONFIG_PACKAGE_tree=y
CONFIG_PACKAGE_vim-fuller=y
CONFIG_PACKAGE_wget=y
CONFIG_PACKAGE_bash=y
CONFIG_PACKAGE_kmod-tun=y
CONFIG_PACKAGE_snmpd=y
CONFIG_PACKAGE_libcap=y
CONFIG_PACKAGE_libcap-bin=y
CONFIG_PACKAGE_ip6tables-mod-nat=y
CONFIG_PACKAGE_iptables-mod-extra=y
# CONFIG_PACKAGE_vsftpd is not set
CONFIG_PACKAGE_openssh-sftp-server=y
CONFIG_PACKAGE_qemu-ga=y
CONFIG_PACKAGE_kmod-tcp-bbr=y
CONFIG_PACKAGE_kmod-ipt-offload=y
CONFIG_PACKAGE_kmod-fast-classifier=y
CONFIG_PACKAGE_kmod-shortcut-fe-cm=y
CONFIG_PACKAGE_kmod-shortcut-fe-drv=y
EOF

# 其他软件包:
cat >> .config <<EOF
CONFIG_HAS_FPU=y
EOF


# 
# ●●●●●●●●●●●●●●●●●●●●●●●●固件定制部分结束●●●●●●●●●●●●●●●●●●●●●●●● #
# 

sed -i 's/^[ \t]*//g' ./.config

# 返回目录
cd $HOME

# 配置文件创建完成
