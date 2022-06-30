---
layout: post
title: 驗證 SSR 或 Pre render SEO 是否正常運行幾種方法
date:  2022-06-30 01:01:01 +0800
image: seo.webp
categories: SEO
tags: seo verify
description : 驗證 SSR 或 Pre render SEO 是否正常運行幾種方法
author : Mark ku
---
## 前言
最近面試了一些公司，通常面試官都會問人家網站有什麼優化空間，我也會事前準備，就發現一些公司的 SEO 好像是沒有正常作用，就順手寫了一篇筆記。

### 一、模擬爬蟲訪問網站
### 到 Chrome 市集安裝 [user-agent-switch](https://chrome.google.com/webstore/detail/user-agent-switcher-for-c/djflhoibgkdhkhhcedjiklpkjnoahfmg?hl=zh-TW) 套件

### 參考 [Google Doc](https://developers.google.com/search/blog/2019/10/updating-user-agent-of-googlebot)，得知 Google搜尋引擎的爬蟲，是採用什麼 useragent 來收錄你的網站

```
目前的 Googlebot 使用者代理程式
行動版：
Mozilla/5.0 (Linux; Android 6.0.1; Nexus 5X Build/MMB29P) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2272.96 Mobile Safari/537.36 (compatible; Googlebot/2.1; +https://www.google.com/bot.html)

電腦版：
Mozilla/5.0 (compatible; Googlebot/2.1; +https://www.google.com/bot.html)

「或」

Mozilla/5.0 AppleWebKit/537.36 (KHTML, like Gecko; compatible; Googlebot/2.1; +https://www.google.com/bot.html) Safari/537.36
```

### 依據　Google Doc 的 useragent，模擬 google bot 的訪問你的網站
![](https://i.imgur.com/3K3T80i.png)
### 結果發現被 Cloud Flare 擋下來了
![](https://i.imgur.com/LQMIVyW.png)

### 我參考的 [Cloud falre社群的討論](https://community.cloudflare.com/t/cloudflare-managed-special-rules-are-blocking-googlebot/82911/14)，看起來是他的規則造成，免費版，是無法管理這個規則

![](https://i.imgur.com/smFNMo1.png)

```
Workaround
As @cs-cf said, the best thing to do is to disable the rules individually so you don’t lose all the other Cloudflare Specials benefits.

Step-by-step
Click the Firewall tab
Click the Managed Rules sub-tab
Scroll to Cloudflare Managed Ruleset section
Click the Advanced link above the Help
Change from Description to ID in the modal
Search for 100035 and check carefully what to disable
Change the Mode of the chosen rules to Disable
Rules matching the search
100035 - Fake google bot, based on partial useragent match and ASN
100035B - Prevent fake bingbots from crawling
100035C - Fake google bot, based on exact useragent match and DNS lookup
100035D - Fake google bot, based on partial useragent match and DNS lookup
100035U - Prevent fake BaiduBots from crawling
100035Y - Prevent fake yandexbot from crawling
A seventh rule related to fake bots was deployed during the incident:

100035_BETA - Fake google bot, based on partial useragent match and ASN
```
### 如果 SEO 渲染正常就會顯示正常的頁面
![](https://i.imgur.com/TZci26Z.jpg)

## 二、驗證頁面有沒有正確被 google 收錄

### 訪問該網站，從 html 中取得 head description ，並拿去 google 搜尋
![](https://i.imgur.com/R4ac5dl.png)

### 確認是否有沒有被正確收錄
![](https://i.imgur.com/55WLOCy.png)

