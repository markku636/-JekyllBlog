---
layout: post
title: 透過 Google tag manger 將電子商務平台使用者行為搜集至 Google Analysis ( 本篇採用 GA4 )
date:  2022-08-29 01:01:01 +0800
image: google-analytics.png
categories: Google Analysis
tags: ga4 google analysis google tag manger gtm integration
description : 透過 Google tag manger 將電子商務平台使用者行為搜集至 Google Analysis ( 本篇採用 GA4 )
author : Mark ku
---
# 透過 Google tag manger 將電子商務平台使用者行為搜集至 Google Analysis ( 本篇採用 GA4 )

## 目的
我們通常會想蒐集會員在電子網站的操作行為，並將其數據整合在 GA 中。

## 事前準備
* 建立 Google Analysis 帳號，並設定好域名
* 在你的網站，埋入 Google Analysis js 程式
* 在你的網站，埋入 GTM 代碼 

## 步驟
### 首先，登入 GA後，設定 > 資料串流 > 選取你的資料串來來源 > 複製評估 ID
![](https://i.imgur.com/QwADcFW.png)
### [登入GTM] > 建立帳戶(https://tagmanager.google.com/#/home) 
![](https://i.imgur.com/Q6NAP6r.png)

## 接著，我們將 GA 帳號和 GTM 進行關聯，並將其名命為 "GA4整合"，代碼 > 新增 > Google Analytics (分析)：GA4 設定 > 貼上先前從 GA複製的評估 ID > All Pages > 儲存
![](https://i.imgur.com/rNSMGh8.png)

## 我們通常會想蒐集會員在網站的行為，並透過前端程式碼去推送事件給GA 
```
export const checkoutViewEvent = (params: GTMProducts[]) => {
  if (window.dataLayer) {
    window.dataLayer.push({ ecommerce: null });
    window.dataLayer.push({
      event: 'checkout',
      ecommerce: {
        checkout: {
          actionField: {
            step: 1,
          },
          products: params,
        },
      },
    });
  }
};
```
## 建立自訂事件
![](https://i.imgur.com/vWUYcSp.png)

## 將剛建立的自訂事件關聯到先前的 "GA4整合" 
代碼 > 新增 > Google Analytics (分析)：GA4 事件 > 選取 "GA4整合" > 事件名稱 checkout >  觸發條件 checkout > 儲存
![](https://i.imgur.com/oy9K8oi.png)

## 你可以預覽功能除錯，來確認 GTM 是不是有收到事件，並將其轉發到 GA
![](https://i.imgur.com/47vGi0N.png)

## 最後，提交
![](https://i.imgur.com/dbWjmxo.png)
## 靜待等待 24~48小時後，登入 GA，在報表 > 參與 > 事件，你就可以看到你的自訂事件
![](https://i.imgur.com/viiVtbe.png)

## 參考資料
### [Google Analytics 4 事件追蹤指南（2022）](https://www.haranhuang.com/google-analytics-4-event-tracking.html?fbclid=IwAR2R-WTqazL3LCTwAN0R-wmRquXLWFk5pBVqONEkfeRQSi17UHM9z9XRwKE)
### [GTM 安裝 Google Analytics 4 網站資料串流教學](https://datasupplied.com/google-tag-manager/setup-ga4-web-stream/?fbclid=IwAR2DW0NRSN9K3wMh6-egb7XjarUQpruZAmKQYeMuCzVw0zVncRy819cU1pA)
### [新版GA4電子商務事件，新舊差異與Purchase轉換一次解析](https://www.bnext.com.tw/article/63984/new-version-of-ga4-e-commerce-events?fbclid=IwAR3EKq9sAYTcoo-xT96MejTLMYAgh45iAmAkOt92GiCFEdjA6VshVac-WJA)
