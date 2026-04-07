document.addEventListener("DOMContentLoaded", function () {
    var message = document.querySelector("[data-flash-message]");
    if (!message) {
        return;
    }

    window.setTimeout(function () {
        message.classList.add("is-hidden");
    }, 4000);
});
