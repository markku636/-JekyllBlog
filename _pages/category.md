---
layout: default
permalink: /categories/
title: 文章分類
---

<div class="container">
    <h2>所有分類</h2>
</div>	
<div class=" container">
  <div class="categories-expo-list container">
  {% assign tags = site.tags | sort %}
	{% for tag in tags %}
	<span class="site-tag">
    <a href="/tag/{{ tag | first | slugify }}/"
        style="font-size: {{ tag | last | size  |  times: 4 | plus: 80  }}%">
            {{ tag[0] | replace:'-', ' ' }} ({{ tag | last | size }})
    </a>
	</span>
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

<style>
.site-tag a {
    display: inline-block;
    margin-right: 12px;
}
</style>
