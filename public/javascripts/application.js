$(document).ready(function() {
  
  $("nav a").anchorAnimate({speed : 700});
  
  var updateScrollObserver = function() {
    var anchorId = $(this).attr('id');
    $('nav a').blur().selectCurrent('[href=#' + anchorId + ']');
    $('#icon img').selectCurrent('[alt=' + anchorId + ']');
  }
  
  var sectionAnchors = $("#content [id]")
  var currentAnchor = $(window.location.hash);
  if (currentAnchor.length == 0) currentAnchor = sectionAnchors.first();
  currentAnchor.each(updateScrollObserver);
  sectionAnchors.anchorScroll(updateScrollObserver);

});
