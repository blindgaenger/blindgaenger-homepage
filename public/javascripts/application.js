$(document).ready(function() {

  var drawIcon = function(options) {
    $.paper.clear();
    var icon = icons[options['icon']];
    var color = options['color'];
    $.paper.path(icon).attr({fill: "315-" + color + ":30-#bbb", stroke: "#fff", "stroke-width": 2}).scale(6, 6).translate(75, 75);
  }
  $.paper = Raphael('paper', 180, 180);
  $.iconMap = {
    start:     {icon: 'home',    color: '#fff'},
    blog:      {icon: 'feed',    color: '#fff'},
    twitter:   {icon: 'twitter', color: '#fff'},
    posterous: {icon: 'cloudUp', color: '#fff'},
    facebook:  {icon: 'user',    color: '#fff'},
    github:    {icon: 'github',  color: '#fff'}
  }
  
  $("nav a[href^='#']").anchorAnimate({speed : 700});
  $("#content section[id]").viewport(function() {
    var anchorId = $(this).attr('id');
    $('nav a').blur().selectCurrent('[href=#' + anchorId + ']');
    drawIcon($.iconMap[anchorId])
  });

});
