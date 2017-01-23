// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require spree/frontend

//= require_tree .
//= require spree/frontend/spree_auth

$(document).ready(function() {
  $('.search-block>input').focus(function () {
    $('.search-result').addClass('visible')
  });

  $('body').click(function(event) {
    if (!$(event.target).closest(".search-block>input").length) {
      if ($(event.target).closest(".search-result").length) return;
      $(".search-result").removeClass('visible');
      // event.stopPropagation();
    }
  });


  var a = 26,
      n = 9;
  var h = a * n + 2 * a + 2;

  $('.btn-group').on('click', '.dropdown-menu > li > div', function(e) {
    e.preventDefault();
    e.stopPropagation();
  });
  $('ul.dropdown-menu>li').each(function () {
    if ($(this).find('.sub-cat li').size() > 9){
      $(this).find('.sub-cat').css({'padding':a+'px 0','height':h+'px','overflow':'hidden'});
      $(this).find('.arrow-list').show();
    }
  });
  $('#up_list').on('click',function () {
    if(!$(this).hasClass('inactive')){
      $(this).addClass('inactive');
      $(this).parent().find('ul').animate({'top':'+='+a+'px'}, 50);
      $('#down_list').removeClass('inactive');
      if ($(this).parent().find('ul').position()['top'] != 0){
        $(this).removeClass('inactive');
      }
    }
  });
  $('#down_list').on('click',function () {
    if(!$(this).hasClass('inactive')){
      $(this).addClass('inactive');
      $(this).parent().find('ul').animate({'top':'-='+a+'px'}, 50);
      $('#up_list').removeClass('inactive');
      var hl = $(this).parent().find('ul').height();
      var param = h - hl -2;
      if ($(this).parent().find('ul').position()['top'] > param){
        $(this).removeClass('inactive');
      }
    }
  });
});
