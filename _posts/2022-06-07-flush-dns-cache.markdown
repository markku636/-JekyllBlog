---
layout: post
title:  提前強制更新 DNS Cache
date:   2022-06-07 01:01:35 +0800
image:  dns.webp
tags:   dns cache clear 
---
## 問題
在某次將 DNS 主機託管，Cloud Falre 時，發現中華電信的 DNS 一直無法更新，上網查看看有沒有什麼辦法提前讓 DNS 生效，不過這個方法，僅限於比較大的 DNS 公司的主機，才有提供清除的功能。

## DNS 相關工具
檢查網址的 DNS 狀態，就能發現是否在全球 DNS 伺服器中完全解析成功
DNSChecke : https://dnschecker.org/
OpenDNS CacheCheck : https://cachecheck.opendns.com/
DNS 效能測試工具 https://www.dnsperf.com/

## 清除 DNS 快取
Google(1.1.1.1) - Flush Cache : https://developers.google.com/speed/public-dns/cache
Purge Cache(CloudFlare) : https://1.1.1.1/purge-cache/
中華電信 168.95.1.1 : 不提供，靜等24小時(台灣 ISP 太落後了，都只能等待，都手動清除)

## Windows清除本機DNS Cache 的方法
```
ipconfig /flushdn
```

## 參考資料

https://study.smallway.tw/other/6195/