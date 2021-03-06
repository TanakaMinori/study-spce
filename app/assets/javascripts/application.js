// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require jquery.turbolinks
//= require turbolinks
//= require_tree .

$(function(){
  $('.home').click(function(){
  location.href = "/";
  });
  
  $('.menu-logo').click(function(){
    location.href = "/";
  });
  
  $('.toggle').click(function(){
    if($(this).hasClass('open')){
      $(this).removeClass('open');
      $('nav').hide();
    }else{
      $(this).addClass('open');
      $('nav').show();
    };
  });
  
  $('.btn-right').click(function(){
    $('#search-form').css("display","block");
    $('.close-btn').click(function(){
      $('#search-form').css("display", "none");
    });
  });
  
  $('.btn-left').click(function(){
    $('#area-index').css("display", "block");
    $('.close-btn').click(function(){
      $('#area-index').css("display", "none");
    });
  });
  
  $('.fa-user-cog').hover(function(){
    $('.user-edit-pop').css("display", "block");
  }, function(){
    $('.user-edit-pop').css("display", "none");
  }
  );
  
});
