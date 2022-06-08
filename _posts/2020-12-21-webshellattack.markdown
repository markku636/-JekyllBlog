---
layout: post
title:  防範WebShell Attack
date:   2020-12-21 15:01:35 +0300
image:  webshellattack.webp
categories: Security
tags:   Resources
---

# 資安問題處理
在調查某次資安的事件中，發現駭客在伺服器留下了後門腳本，網站的js也被竄改過，導到假的flash 網站，經調查，我懷疑遭到Web shell attack。

## 什麼是Web shell attack

接著參考封面這張圖，這些駭客可能透過，

微軟產品的漏洞(Windows 、IIS 、Net Framework)或是員工電腦中毒被當跳版等等方式，

及Web server 寫入權限過大，

將寫好的後門腳本，

放到我們的網頁服務器中，

因為網頁腳本認得這個腳本，

一旦打開了網站就會被執行了。

## 疑問

站在開發人員角度思考，腦袋跑出很多疑惑 ?

為什麼有程式權限修改我們程式?

為什麼這個腳本為什麼還能伺服器運行?  

現在公司不是都是MVC 怎麼還有aspx 引擎?

## 模擬情境
接下來參考了很多資料，我做了一個Poc腳本(Aspx)，去模擬當時的情境，
因為無法模擬怎麼丟進去的，透過手動上傳方式來模擬，發現確實可以用程式任意寫入一個檔案。

```
<%@ Page Language="C#" %>
<%@ Import Namespace="System"%>
<%@ Import Namespace="System.IO"%>
<%@ Import Namespace="System.Text"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">


        protected void Page_Load(object sender, EventArgs e)
        {
			
			  string currentdir =  HttpContext.Current.Server.MapPath("~")
              string path = currentdir + "/HackTest.txt";


            
                // Create the file, or overwrite if the file exists.
                using (FileStream fs = File.Create(path))
                {
                    byte[] info = new UTF8Encoding(true).GetBytes("This is some text in the file.");
                    // Add some information to the file.
                    fs.Write(info, 0, info.Length);
                }

                // Open the stream and read it back.
                using (StreamReader sr = File.OpenText(path))
                {
                    string s = "";
                    while ((s = sr.ReadLine()) != null)
                    {
                        Console.WriteLine(s);
                    }
                }
			
		}

</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>

</body>
</html>
```

☆★最後參考保哥blog發現，IIS預設目錄是安全的，但我們移到Ｘ糟，就繼承了Ｘ糟額外的權限，最後我們IIS的目錄發現確實是能夠寫入及修改檔案的。

<https://blog.miniasp.com/post/2009/03/16/IIS-6-Identity-and-Windows-Access-Control-is-not-what-you-expected>

## 最後我的解決方案
1. 從Web config 移除不必要的網頁腳本 (ASPX 、ASP .... )
1. Review IIS目錄權限，並禁止繼承D磁碟糟權限，限制User只有看的權限，不能夠執行腳本及寫入
1. Windows update 每半年至少做一次更新，有微軟網站公佈的重大資安漏洞，就得提前做。可以由[Windows 更新導覽網站](https://msrc.microsoft.com/update-guide)去查詢有沒有重大資安漏。


