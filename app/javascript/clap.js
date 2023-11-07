document.addEventListener("DOMContentLoaded", function () {
  var link = document.querySelector(".clap-link");

  link.addEventListener("touchstart", function () {
    this.classList.add("active");
  });

  link.addEventListener("touchend", function () {
    this.classList.remove("active");
  });
});
