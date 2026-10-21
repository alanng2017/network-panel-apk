#!/bin/bash
# 从路由器抓取状态数据，生成静态JSON文件
ROUTER="http://192.168.66.1"
COOKIE="sysauth=aba068e8249c4d1b8e13442f89ce43b7"

echo "=== 抓取状态数据 ==="
curl -s -b "$COOKIE" "$ROUTER/cgi-bin/luci/nradio/status/runtime/wan,cpe,cpe_4,cpe_6,cpe1,cpe1_4,cpe1_6" \
  > /root/network_panel_app/www/status.json 2>/dev/null
echo "状态数据: $(wc -c < /root/network_panel_app/www/status.json 2>/dev/null || echo 0) 字节"

echo "=== 抓取锁频状态 ==="
curl -s -b "$COOKIE" "$ROUTER/cgi-bin/luci/nradio/cellular/cpestatus/earfcn?sim=1" \
  > /root/network_panel_app/www/lock.json 2>/dev/null
echo "锁频数据: $(wc -c < /root/network_panel_app/www/lock.json 2>/dev/null || echo 0) 字节"
