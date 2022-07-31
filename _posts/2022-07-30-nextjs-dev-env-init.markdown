---
layout: post
title: 快速建立 Next js 開發環境筆記 ( ESlint + Style + Prettier )
date:  2022-07-30 01:01:01 +0800
image: nextjs.webp
categories: Frontend
tags: React Next dev init env enviorment
description : Next js 快速建立開發環境筆記 ( ESlint + Style + Prettier )
author : Mark Ku
---
## 目的
ESlint + StyleLint + Prettier 己經現今前端開發協作相當重要的工具，他可以讓團隊有一致的程式碼風格及規範，並透過 Vscode 開發工具，能夠協助修正一些錯誤。

* ESlint : 程式碼撰寫風格校驗，開發階段找到很多潛在問題。
* StyleLint : CSS 自動校驗是不是符合團隊規範，自動調整成團隊規範的 CSS。
* Prettier: 讓團隊有一致的，自動整理程式碼格式。

## 建立 next js 應用程式
```
npx create-next-app@latest --typescript
npm run dev
```
### 自動化安裝相關的套件( 專在案目錄執行，可以寫成 powershell )

```
code --install-extension  dbaeumer.vscode-eslint 
npm add eslint --save -D 

code --install-extension  stylelint.vscode-stylelint
npm add stylelint-config-standard-scss --save -D

code --install-extension  esbenp.prettier-vscode
```

## 建立相關套件的配置檔案
### .vscode\settings.json 

```
{
  "editor.codeActionsOnSave": {
    "source.fixAll.eslint": true,  // 存檔時自動修正 eslint 錯誤
    "source.fixAll.stylelint": true, // 存檔時自動修正 stylelint 錯誤
  },
  "editor.defaultFormatter": "esbenp.prettier-vscode",
  "[html,javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "editor.formatOnSave": true, //true = 開啟,false = 關閉
}
```

### .eslintrc.json
```
{
  "extends": ["next/core-web-vitals","eslint:recommended"]
}
```

### .stylelintrc
```
{
    "extends": "stylelint-config-standard-scss",
    "rules": {
        "color-hex-case": "upper",
        "block-no-empty": true,
        "color-hex-length": "long",
        "selector-type-no-unknown": [true, {
            "ignoreTypes": []
        }],
        "selector-pseudo-element-no-unknown": [true, {
            "ignorePseudoElements": []
        }],
        "comment-no-empty": true,
        "shorthand-property-no-redundant-values": true,
        "value-no-vendor-prefix": true,
        "property-no-vendor-prefix": true,
        "number-leading-zero": "never",
        "no-empty-first-line": true,
        "no-descending-specificity": null,
        "at-rule-no-unknown": null,
        "order/properties-order": [
            "position",
            "top",
            "right",
            "bottom",
            "left",
            "z-index",
            "display",
            "justify-content",
            "align-items",
            "float",
            "clear",
            "overflow",
            "overflow-x",
            "overflow-y",
            "margin",
            "margin-top",
            "margin-right",
            "margin-bottom",
            "margin-left",
            "border",
            "border-style",
            "border-width",
            "border-color",
            "border-top",
            "border-top-style",
            "border-top-width",
            "border-top-color",
            "border-right",
            "border-right-style",
            "border-right-width",
            "border-right-color",
            "border-bottom",
            "border-bottom-style",
            "border-bottom-width",
            "border-bottom-color",
            "border-left",
            "border-left-style",
            "border-left-width",
            "border-left-color",
            "border-radius",
            "padding",
            "padding-top",
            "padding-right",
            "padding-bottom",
            "padding-left",
            "width",
            "min-width",
            "max-width",
            "height",
            "min-height",
            "max-height",
            "font-size",
            "font-family",
            "font-weight",
            "text-align",
            "text-justify",
            "text-indent",
            "text-overflow",
            "text-decoration",
            "white-space",
            "color",
            "background",
            "background-position",
            "background-repeat",
            "background-size",
            "background-color",
            "background-clip",
            "opacity",
            "filter",
            "list-style",
            "outline",
            "visibility",
            "box-shadow",
            "text-shadow",
            "resize",
            "transition"
        ]

    }
}
```

### .prettierrc

```
{
    "arrowParens": "always",
    "bracketSpacing": true,
    "endOfLine": "lf",
    "htmlWhitespaceSensitivity": "css",
    "insertPragma": false,
    "jsxBracketSameLine": false,
    "jsxSingleQuote": false,
    "printWidth": 80,
    "proseWrap": "preserve",
    "quoteProps": "as-needed",
    "requirePragma": false,
    "semi": true,
    "singleQuote": true,
    "tabWidth": 2,
    "trailingComma": "es5",
    "useTabs": false,
    "vueIndentScriptAndStyle": false,
    "parser": "babel"
  }
```

## 完成配置，你己擁有三大功能。