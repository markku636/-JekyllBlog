---
layout: post
title:  提前強制更新各家 DNS Cache 
date:   2022-06-06 01:01:35 +0800
image:  dns.webp
tags: [jekyll, other-tag, example]
---
## 前言
某次將 DNS 主機託管 Cloud Falre 時，發現中華電信的 DNS 記錄，一直無法更新，就上網查看看有沒有什麼辦法提前讓 DNS 生效，不過查到的方法，僅限於比較大的 DNS 服務商的主機，才有提供提前清除的功能，寫這篇的目的就是做個筆記。

## DNS 相關工具
用來檢查全球 DNS 伺服器中是否能夠解析成功及測試的小工具
DNSChecke : https://dnschecker.org/  
OpenDNS CacheCheck : https://cachecheck.opendns.com/  
DNS 效能測試工具 https://www.dnsperf.com/  

## 清除 DNS 快取
Google(1.1.1.1) - Flush Cache : https://developers.google.com/speed/public-dns/cache  
Purge Cache(CloudFlare) : https://1.1.1.1/purge-cache/  
中華電信 168.95.1.1 : 不提供，只能靜等24小時(台灣 ISP 太落後了，很多都沒支援 API，或讓用戶更方便的功能)  

## Windows清除本機DNS Cache 的方法

```
ipconfig /flushdn
```

## 參考資料
https://study.smallway.tw/other/6195/