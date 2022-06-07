---
layout: default
permalink: /tags/
---


<div class="container">
    <h2>所有標籤</h2>
</div>	
<div class=" container">
  <div>
    {% for tag in site.tags %}
    <a href="#{{ tag[0] | slugify }}" class="post-tag">{{ tag[0] }}</a>
    {% endfor %}
  </div>
  <br/>
  <div class="tag-item">
    {% for tag in site.tags %}	
	<div class="">
    <h3 id="{{ tag[0] | slugify }}">{{ tag[0] }}</h3>
	</div>	
    
    {% for post in tag[1] %}
     {% include article-content.html %}
    {% endfor %}
    
    {% endfor %}
  </div>
</div>

<style>
.tag-item{
display:nonef
}

</style>

<script>
$(function(){
$(window).on('hashchange', function(e) { 
$('.tag-item').hide()
$(location.hash).show()
});
}
</script>