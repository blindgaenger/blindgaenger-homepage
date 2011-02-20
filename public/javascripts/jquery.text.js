(function($){
  
  $.fn.textNodes = function() {
    return $(this).contents().filter(function() {return this.nodeType == 3;})
  }

  $.fn.bigRunningText = function() {
    $(this).textNodes().replaceWith(function() {
      return $(this).text().trim().split('\n').map(function(s) {
        return "<div>" + s.trim() +"</div>"
      }).join('');
    })
    $(this).bigtext();
  }

  $.fn.bigBreakText = function() {
    $(this).textNodes().wrap('<div/>').end().filter('br').remove();
    $(this).bigtext();
  }
  
})(jQuery);


