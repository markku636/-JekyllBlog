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
  <div class="">
    {% for tag in site.tags %}	
	<div class="tag-item" id="tag-group-{{ tag[0] | slugify }}">
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
display:none;
}

</style>

<script>

    
       window.onhashchange = function () {              
	
		let array = document.getElementsByClassName("tag-item")

		for (let i=0; i<array.length; i++) {
		array[i].style.display ='none';
		}			 
			  
		document.getElementById('tag-group-' + location.hash.replace('#','')).style.display = "block";
       }
         
    

</script>