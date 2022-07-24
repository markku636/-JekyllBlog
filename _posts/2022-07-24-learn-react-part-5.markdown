---
layout: post
title: React 學習筆記 - 路由 ( Router ) - Part's 5
date:  2022-07-24 01:01:01 +0800
image: react.webp
categories: Frontend
tags: React get start
description : React 學習筆記 - 路由 ( Router ) - Part's 5
author : Mark Ku
---
## 路由的原理原理
路由的原理，依據 url 請求，動態去載入相對應的元件。
## 安裝 react router ( 最常見 )
```
npm install react-router-dom --save // 基於 react-router 實作的 lib 
npm install @types/react-router-dom --save-deve // 官方沒提供
```
## 使用方法
React 露由用法主要是由這三個所組成  
BroserRouter + Switch+ Route  
```
app.tsx
<BroserRouter>
<Switch>
    <Route exect path="/" component={HomePage} />
     <Route path="/sign" render={()=><h1>sign</h1>} />
    <Route render={()=><h1>404</h1>} />
     
 </Switch>
</BroserRouter>
```
* exect - 嚴謹的，完全匹配，才會生效
* Switch - 避免頁面推疊，要用使 Switch，只會有一個頁面組件生效。
* 404 頁面要放在最後一個，所有沒匹配才會生效

## 如何透過路由傳遞參數
### 1. 使用 "?" 來傳遞參數

```
http://localhost:3000/product?id=5
```
### 2. 使用路由 Segments 來 傳遞參數

```
http://localhost:3000/product/123456
```

### 透過 RouteComponentProps 取得路由的參數
```
import React from "react";
import { RouteComponentProps } from "react-router-dom";

interface MatchParams {
  touristRouteId: string;
}

export const DetailPage: React.FC<RouteComponentProps<MatchParams>> = (
  props
) => {
//   console.log(props.history);
//   console.log(props.location);
//   console.log(props.match);
  return <h1>路游路线详情页面, 路线ID: {props.match.params.touristRouteId}</h1>;
};
```
   
### 子組件獲得路由的參數資訊 
使用組件 React Route 時，預設會在子組件中 props 取得 match 、history、location ，但如果要跨組件傳遞時則  
* 使用 app context 來做
* hoc 高階組件 (共享組件)
```
import React from "react";
import PropTypes from "prop-types";
import { withRouter } from "react-router";

class ShowTheLocation extends React.Component {
  // 將match、location、history當成props傳入ShowTheLocation組件，可以讓原本沒有接收props或是state的component能夠因為location的改變而render
  static propTypes = {
    match: PropTypes.object.isRequired,
    location: PropTypes.object.isRequired,
    history: PropTypes.object.isRequired
  };

  render() {
    const { match, location, history } = this.props;

    return <div>You are now at {location.pathname}</div>;
  }
}

const ShowTheLocationWithRouter = withRouter(ShowTheLocation);
export default ShowTheLocationWithRouter;
```
* 使用 Hook 函數取得 ( 簡化取得 )

```
import { useHistory, useLocation, useParams, useRouteMatch } from "react-router-dom";
const history = useHistory();
const location = useLocation();
const { touristRouteId }: MatchParams = useParams();
const match = useRouteMatch();

```

## 導頁
React 導頁的方式主要有兩種
### 1. history push
```
<Button onClick={() => history.push("signIn")}>登入</Button>
```

### 2. 使用 link 組件 ( 封裝過的 a 標籤 + history push )
``` 
<Link to={`detail/${id}`}>
  連結      
</Link>
``` 
## 未完成 