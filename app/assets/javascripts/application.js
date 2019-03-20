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
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery3
//= require popper
//= require bootstrap-sprockets
//= require_tree .

$(function(){
  $("#submit_one").click(function(){
    var one = $(this).text();
    var question_id = `${targets.id}`;
    $.ajax({
      type:'post',
      url: '/ajax_1',
      data: {keyword: `${one}`, targets_id: `${question_id}`},
      datatype: 'json'
    })
    .done(function(){
      //通信に成功した時の処理
      $(this).parent().slideUp("fast");
      })
    .fail(function(){
      alert('通信に失敗しました。');
    });
  });
});


$(function(){
  $("#submit_one").click(function(){
    $(this).parent().slideUp("fast");
  })
});
