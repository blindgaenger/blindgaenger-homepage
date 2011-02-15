jQuery.fn.anchorScroll = function(callback) {
  $.anchorIds = {};

  $(this).each(function(){
    $.anchorIds[$(this).attr('id')] = true;
  });
  
  $(window).scroll(function(){
    var scrollOffset = $(this).scrollTop();
    for (anchorId in $.anchorIds) {
      var anchor = $('a[id="' + anchorId + '"]');
      if (scrollOffset >= anchor.offset().top - 700) {
        if (scrollOffset <= anchor.offset().top + anchor.outerHeight(true)) {
          callback(anchorId);
          return;
        }
      }
    }
  });
  
};

$(document).ready(function() {
  
  $("nav a").anchorAnimate({speed : 700});
  
  $("h1 a[id]").anchorScroll(function(anchorId) {
    $('nav a').selectCurrent('[href=#' + anchorId + ']');
    $('#icon img').selectCurrent('[alt=' + anchorId + ']');
  });
  
});
