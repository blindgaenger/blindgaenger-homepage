$(document).ready(function() {

  var iconMap = {
    start:     'home',
    blog:      'feed',
    twitter:   'twitter',
    posterous: 'cloudUp',
    facebook:  'user',
    github:    'github'
  }
  
  $("nav a[href^='#']").anchorAnimate({speed : 700});
  $("#content section[id]").viewport(function() {
    var anchorId = $(this).attr('id');
    $('nav a').blur().selectCurrent('[href=#' + anchorId + ']');
    
    var icon = iconMap[anchorId]
    var attr = {fill: "315-#fff:30-#bbb", stroke: "#fff", "stroke-width": 2}
    $('#paper').drawIcon(icon, attr)
  });
  
});
