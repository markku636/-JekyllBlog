---
layout: default
permalink: /tags/
---
<div class="arhive-head">
  <div class="container">
    <h1 class="archive-title">Tag: <span id="tagName"></span></h1>
  </div>
 </div>
  
  <div class="">
    {% for tag in site.tags %}	
	<div class="tag-item" id="tag-group-{{ tag[0] | slugify }}" >
    	
    {% for post in tag[1] %}
     {% include article-content.html %}
    {% endfor %}
    </div>
    {% endfor %}	
  </div>	  


<style>
.tag-item{
display:none;
}

</style>

<script>
	var showTagContent = function(){
	var array = document.getElementsByClassName("tag-item")

	for (let i=0; i<array.length; i++) {
	array[i].style.display ='none';
	}			 
			  
	var hashtag =decodeURIComponent(location.hash.replace('#',''))
	var showEle =  document.getElementById('tag-group-' + hashtag)
		
	if(showEle)
	{
		showEle.style.display = "block";
	}
	document.getElementById('tagName').textContent = hashtag
		
		
}
    
window.onhashchange = function () {              
	showTagContent()
}
         
    
window.onload = function() {
  showTagContent()
};

</script>