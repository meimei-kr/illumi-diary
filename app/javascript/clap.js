document.addEventListener("DOMContentLoaded", function () {
  var links = document.querySelectorAll(".clap-link");

  links.forEach(function (link) {
    link.addEventListener("touchstart", function () {
      this.classList.add("active");
    });

    link.addEventListener("touchend", function () {
      this.classList.remove("active");
    });
  });
});
