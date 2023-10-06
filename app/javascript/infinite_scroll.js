import jquery from "jquery"
window.$ = window.jQuery = jquery

$(document).on('turbo:load', function() {
  $(function() {
    $('.jscroll').jscroll({
      contentSelector: '.jscroll',
      nextSelector: '.next a',
      loadingHtml: '読み込み中',
      padding: 10,
    });
  });
});