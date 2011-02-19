$(document).ready(function() {
  
  $("nav a").anchorAnimate({speed : 700});
  
  $("h1 a[id]").anchorScroll(function() {
    var anchorId = this.id;
    $('nav a').blur().selectCurrent('[href=#' + anchorId + ']');
    $('#icon img').selectCurrent('[alt=' + anchorId + ']');
  });
  
});
