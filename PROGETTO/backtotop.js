document.addEventListener("DOMContentLoaded", function() {
    const btn = document.getElementById("back-to-top");
    window.addEventListener("scroll", function() {
        btn.style.display = (window.scrollY > 300) ? "block" : "none";
    });
    btn.addEventListener("click", function() {
        window.scrollTo({ top: 0, behavior: "smooth" });
    });
});
