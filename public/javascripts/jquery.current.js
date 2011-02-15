/**
 * selects the matching elements and adds a `current` class
 *
 *   $('nav a').selectCurrent(function(el) {
 *     return el.attr('href') == '#foobar'
 *   })
 */
(function($){
  
  $.fn.selectCurrent = function(selector) {
    return $(this).removeClass('current').filter(selector).addClass('current');
  }
  
})(jQuery);


