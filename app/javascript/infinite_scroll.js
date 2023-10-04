import $ from 'jquery'

$(function() {
  $('.jscroll').jscroll({
    contentSelector: '.jscroll',
    nextSelector: '.next a',
    loadingHtml: '読み込み中',
    padding: 10,
  });
});