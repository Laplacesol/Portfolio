$(document).ready(function() {
    $('.dropdown').hover(function() {
      $(this).find('.dropdown-menu').first().stop(true, true).slideDown();
    }, function() {
      $(this).find('.dropdown-menu').first().stop(true, true).slideUp();
    });
  });

  
  // get the navbar element to add text when the user scrolls down
const navbar = document.getElementById('navbar');

// listen for the scroll event on the window
window.addEventListener('scroll', function() {
  // if the user has scrolled down past the height of the navbar, add the "scroll" class to the navbar
  if (window.scrollY > navbar.offsetHeight) {
    navbar.classList.add('scroll');
  } else {
    // otherwise, remove the "scroll" class
    navbar.classList.remove('scroll');
  }
});
