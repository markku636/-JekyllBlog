---
layout: default
title: tags
permalink: /tags/
title: 標籤
---

<div class="arhive-head">
  <div class="container">
    <h1 class="archive-title">Tag: <span>{{ page.tag }}</span></h1>
  </div>
</div>


{% for post in page.posts %}
  {% include article-content.html %}
{% endfor %}


<div class="tags-expo">
  <div class="tags-expo-list">
    {% for tag in site.tags %}
    <a href="#{{ tag[0] | slugify }}" class="post-tag">{{ tag[0] }}</a>
    {% endfor %}
  </div>
  <br/>
  <div class="tags-expo-section">
    {% for tag in site.tags %}
    <h2 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h2>
    <ul class="tags-expo-posts">
      {% for post in tag[1] %}
       {% include article-content.html %}
      {% endfor %}
    </ul>
    {% endfor %}
  </div>
</div>