---
layout: default
permalink: /categories/
title: 分章分類
---

<div class="container">
    <h2>所有分類</h2>
</div>	
<div class=" container">
  <div class="categories-expo-list container">
    {% for category in site.categories %}
    <a href="#{{ category[0] | slugify }}" class="post-category">{{ category[0] }}</a>
    {% endfor %}
  </div>
  <br/>
  <div class="">
    {% for category in site.categories %}	
	<div class="container">
    <h3 id="{{ category[0] | slugify }}">{{ category[0] }}</h3>
	</div>	
    
    {% for post in category[1] %}
     {% include article-content.html %}
    {% endfor %}
    
    {% endfor %}
  </div>
</div>