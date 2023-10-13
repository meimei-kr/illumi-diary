window.check = function() {
  if (window.confirm("削除してもよろしいですか？")) {
    return true;
  } else {
    return false;
  }
}