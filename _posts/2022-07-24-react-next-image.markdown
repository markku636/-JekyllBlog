---
layout: post
title: Nextjs image loader 造成，docker image 肥大的問題及效能消耗的問題
date:  2022-07-27 01:01:01 +0800
image: nextjs.webp
categories: Frontend
tags: React Next image loader docker image too big
description : Nextjs image loader 造成，docker image 肥大的問題及效能消耗的問題
author : Mark Ku
---

## 問題
透過 next/image 元件的載入圖片，都會透過 next server 去調整圖片大小，圖片路徑會渲染成如下面範圍:

```
<img src="https://www.markkulab.com/_next/image?url=https://content.markkulab.com//Images/en-US/Lobby/same_day_rdy_next_01.png&w=1920&q=75"/>
```

## 造成影響
* next 伺服器渲染的效能的消耗
* docker 映像檔過大

## 我參考了[一個網站](https://nzxt.com/assets/cms)，他們也是採用 next js，應該也是用 next/image 載入圖片，因為他們採用　imgix 的縮圖服務，所以沒發生這個問題，

## 參考 [next 官方文件](https://nextjs.org/docs/api-reference/next/image#loader-configuration)，發現 next/image 的 loader 是可以客製化設定的

```
images: {
    loader: 'imgix',
    path: 'https://example.com/myaccount/',
  },
}
```

## 可行的解決方案
* 啟動 Cloudflare Image Optimization
https://developers.cloudflare.com/images/image-resizing/integration-with-frameworks/  
* 購買 imgix 服務 ( 省時，但花錢 300 USD / month )
* 自架 image loader，ex: uploadcare or  ... 
* 棄用 next/image，自己寫新的圖片載元件，透過 cloudflare 類似的服務縮圖服務 =>　不建議太麻煩了