import $ from 'jquery';

$(document).on("turbo:load", function() {
  console.log("jquery called")
  const maxCount = 140;

  function updateCount(textArea, textCount) {
    const count = textArea.val().length;
    const newCount = maxCount - count;
    textCount.text(`${newCount} / ${maxCount}`)
    textCount.css("color", newCount < 0 ? "red" : "#666b74");
  }

  $(".js-text-area-container").each(function() {
    const textArea = $(this).find(".js-text");
    const textCount = $(this).find(".js-text-count");

    // 初期表示時
    updateCount(textArea, textCount);

    // 入力時
    textArea.on("input", () => updateCount(textArea, textCount));
  });
});