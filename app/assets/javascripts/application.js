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
//= require Chart.bundle
//= require chartkick
//= require_tree .

$(document).ready(function() {
  $('.alert').fadeOut(4500);
});

$(document).on('turbolinks:load', function(){
  $("#button").on("click", function() {
    var questions = ["今日の晩御飯何にしようかな？", "初デートはどこがいい？", "明日は何しようかな？", "どれが好き？", "明日はどこに行こうかな？"];
    var target = (questions[Math.floor(Math.random() * questions.length)]);
    $("#content").val(target);
  });
});

$(function() {
  $('#charge_icon').popover({
    trigegr: 'hover', // HTMLオプションをtrueにする
  });
});