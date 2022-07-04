---
layout: post
title: 淺談使用開源 Yarp Revert Proxy 實現滾動式部署 ( Rolling-update ) 設計思路
date:  2022-07-03 01:01:01 +0800
image: balance.webp
categories: devops
tags: yarp reverse proxy load balance rolling update 
description : 淺談使用開源 Yarp Revert Proxy 實現滾動式部署 ( Rolling-update ) 設計思路
author : Mark ku
---
# 淺談使用開源 Yarp Revert Proxy 實現滾動式部署 ( Rolling-update ) 設計思路

## 為何要使用滾動式更新應用程式( Rolling-update )
現今的電子商務網站，幾乎 365天 * 24小時在運營，隨時都可能會員在使用系統，而傳統部署線上應用程式過程中，你的網站是不能夠做生意的，佈署網站的過程中，同時也可能給用戶帶了不好的體驗，平台用戶可能出現錯誤畫面，或被登出，若維護停機時間太久，用戶也可能轉往其他的平台去下單，進而流失用戶，那麼滾動式部署，可以減少因部署的停機時間，給用戶更好的體驗，同時也增加可以做生意的時間。

參考[六大部署策略](https://thenewstack.io/deployment-strategies/)，滾動式佈署是相較容易建置，而這些策略 Load balance 支持，此篇採用的微軟開源的 YARP 反向代理，進行設計滾動式佈署的機制。  

[先前撰寫 YARP 的相關文章](https://blog.markkulab.net/2022/01/13/yarp-reverse-proxy)  

## 設計思路
### 一、首先，將伺服器分組
![](https://i.imgur.com/zSfGciH.png)  
在 LTM 中，在 yarp 中將伺服器分成三個群組:  
All Server 、Batch A 、Batch B，依據部署階段的不同，切換不同的伺服器群組。

All Server  
192.168.0.1  
192.168.0.2  
192.168.0.3  
192.168.0.4  

Batch A   
192.168.0.1  
192.168.0.3  
...

Batch B  
192.168.0.2  
192.168.0.4  
...

### 二、佈署 Batch A 伺服器群組 ( 由 Batch B 服務用戶 ) 
![](https://i.imgur.com/dzRKYnd.png)

#### 1.Call LTM Api ，將伺服器群組，切到 Batch B Only
#### 2.部署應用程式
#### 3.內部測試
#### 4. Call LTM Api，將伺服器群組，切到 Batch A Only

### 三、佈署 Batch B 伺服器群組 ( 由 Batch A 服務用戶 )

![](https://i.imgur.com/BTe4xnV.png)
#### 1.部署應用程式
#### 2.內部測試
#### 3.Call LTM Api，將伺服器群組，切到 All Server 模式
### 驗證在線網站
### 完成伺服器部署

### 需要特別留意的部份
* 後端 API 如果有異動，後端 API 得佈署完再佈署前端
* 後端的部份，API一定得下向相容幾個版本後，才可以移除不需要的功能。
 
## 如何實作
最後參考微軟官方 yarp 的官方文件的範例程式，我們可以很輕易ReassignProxyRequest 指定伺服器群組 (Cluster)，並透過 API 修改目前的伺服器的群組，達到 AB test 及 滾動式部署，
但因為暫時沒時間實作，先將設計概念撰寫下來。

```
public void Configure(IApplicationBuilder app, IProxyStateLookup lookup)
    {
        app.UseRouting();
        app.UseEndpoints(endpoints =>
        {
            endpoints.MapReverseProxy(proxyPipeline =>
            {
                // Custom cluster selection
                proxyPipeline.Use((context, next) =>
                {
                    if (lookup.TryGetCluster(ChooseCluster(context), out var cluster))
                    {
                        context.ReassignProxyRequest(cluster);
                    }

                    return next();
                });
                proxyPipeline.UseSessionAffinity();
                proxyPipeline.UseLoadBalancing();
            });
        });
    }

private string ChooseCluster(HttpContext context)
{
        // Decide which cluster to use. This could be random, weighted, based on headers, etc.
        return Random.Shared.Next(2) == 1 ? "cluster1" : "cluster2";
}
```

## 參考資料
[參考資料連結](https://microsoft.github.io/reverse-proxy/articles/ab-testing.html)  

[參考資料連結](
https://segmentfault.com/a/1190000041000199?fbclid=IwAR2aZheEq9ADoyXk4EckJhjrzb6EGpMFHipK3D88B9L-OUoPkwXW13Wu-yk)  

[參考資料連結](https://thenewstack.io/deployment-strategies/)  
