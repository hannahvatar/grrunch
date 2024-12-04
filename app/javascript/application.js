// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@popperjs/core";
import "bootstrap";

document.addEventListener('DOMContentLoaded', function () {
  const track = document.querySelector('.carousel__track'); // The track element containing slides
  const slides = Array.from(track.children); // Convert slides to an array for easier manipulation
  const nextButton = document.querySelector('.carousel__button--right'); // Next button
  const prevButton = document.querySelector('.carousel__button--left'); // Previous button
  const dotsNav = document.querySelector('.carousel__nav'); // Dots navigation
  const dots = Array.from(dotsNav.children); // Convert dots to an array

  const slideWidth = slides[0].getBoundingClientRect().width; // Get the width of a single slide

  // Arrange slides side by side based on their index
  slides.forEach((slide, index) => {
    slide.style.left = `${slideWidth * index}px`;
  });

  // Function to move to a target slide
  const moveToSlide = (track, currentSlide, targetSlide) => {
    track.style.transform = `translateX(-${targetSlide.style.left})`;
    currentSlide.classList.remove('current-slide'); // Remove active class from the current slide
    targetSlide.classList.add('current-slide'); // Add active class to the target slide
  };

  // Function to update the dot indicators
  const updateDots = (currentDot, targetDot) => {
    currentDot.classList.remove('current-slide'); // Remove active class from the current dot
    targetDot.classList.add('current-slide'); // Add active class to the target dot
  };

  // Function to check and toggle button visibility (optional)
  const toggleArrows = (slides, prevButton, nextButton, targetIndex) => {
    prevButton.disabled = targetIndex === 0; // Disable the prev button if at the first slide
    nextButton.disabled = targetIndex === slides.length - 1; // Disable the next button if at the last slide
  };

  // Event listener for the next button
  nextButton.addEventListener('click', () => {
    const currentSlide = track.querySelector('.current-slide');
    const nextSlide = currentSlide.nextElementSibling || slides[0]; // Loop to the first slide
    const currentDot = dotsNav.querySelector('.current-slide');
    const nextDot = currentDot.nextElementSibling || dots[0]; // Loop to the first dot
    const nextIndex = slides.indexOf(nextSlide);

    moveToSlide(track, currentSlide, nextSlide);
    updateDots(currentDot, nextDot);
    toggleArrows(slides, prevButton, nextButton, nextIndex); // Optional button visibility
  });

  // Event listener for the previous button
  prevButton.addEventListener('click', () => {
    const currentSlide = track.querySelector('.current-slide');
    const prevSlide = currentSlide.previousElementSibling || slides[slides.length - 1]; // Loop to the last slide
    const currentDot = dotsNav.querySelector('.current-slide');
    const prevDot = currentDot.previousElementSibling || dots[dots.length - 1]; // Loop to the last dot
    const prevIndex = slides.indexOf(prevSlide);

    moveToSlide(track, currentSlide, prevSlide);
    updateDots(currentDot, prevDot);
    toggleArrows(slides, prevButton, nextButton, prevIndex); // Optional button visibility
  });

  // Event listener for the dots navigation
  dotsNav.addEventListener('click', (e) => {
    const targetDot = e.target.closest('button'); // Ensure the clicked element is a dot button
    if (!targetDot) return;

    const currentSlide = track.querySelector('.current-slide');
    const currentDot = dotsNav.querySelector('.current-slide');
    const targetIndex = dots.indexOf(targetDot); // Get the index of the clicked dot
    const targetSlide = slides[targetIndex];

    moveToSlide(track, currentSlide, targetSlide);
    updateDots(currentDot, targetDot);
    toggleArrows(slides, prevButton, nextButton, targetIndex); // Optional button visibility
  });
});
