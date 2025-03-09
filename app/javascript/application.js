// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".copy-password-btn").forEach(button => {
      button.addEventListener("click", (event) => {
        const password = event.target.dataset.password;
        if (password) {
          navigator.clipboard.writeText(password)
            .then(() => {
              alert("Пароль скопійовано до буфера обміну!");
            })
            .catch(err => {
              console.error("Помилка копіювання:", err);
              alert("Не вдалося скопіювати пароль.");
            });
        } else {
          alert("Пароль недоступний.");
        }
      });
    });
  });