$(document).ready(function() {

  var drawIcon = function(options) {
    $.paper.clear();
    var icon = icons[options['icon']];
    var color = options['color'];
    $.paper.path(icon).attr({fill: "315-" + color + ":70-#bbb", stroke: "#000", "stroke-width": 4}).scale(6, 6).translate(75, 75);
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
  
  $("nav a").anchorAnimate({speed : 700});
  
  var updateScrollObserver = function() {
    var anchorId = $(this).attr('id');
    $('nav a').blur().selectCurrent('[href=#' + anchorId + ']');
    drawIcon($.iconMap[anchorId])
  }
  
  var sectionAnchors = $("#content [id]")
  var currentAnchor = $(window.location.hash);
  if (currentAnchor.length == 0) currentAnchor = sectionAnchors.first();
  currentAnchor.each(updateScrollObserver);
  sectionAnchors.anchorScroll(updateScrollObserver);

});
