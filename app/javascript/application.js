// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "@popperjs/core";
import "bootstrap";

document.addEventListener('DOMContentLoaded', function () {
  const track = document.querySelector('.carousel__track');
  const slides = Array.from(track.children);
  const dotsNav = document.querySelector('.carousel__nav');
  const dots = Array.from(dotsNav.children);

  const slideWidth = slides[0].getBoundingClientRect().width;
  let autoRotateInterval;
  let isManualControl = false;

  // Arrange slides side by side
  slides.forEach((slide, index) => {
    slide.style.left = `${slideWidth * index}px`;
  });

  const moveToSlide = (track, currentSlide, targetSlide) => {
    track.style.transform = `translateX(-${targetSlide.style.left})`;
    currentSlide.classList.remove('current-slide');
    targetSlide.classList.add('current-slide');
  };

  const updateDots = (currentDot, targetDot) => {
    currentDot.classList.remove('current-slide');
    targetDot.classList.add('current-slide');
  };

  // Auto-rotation function
  const autoRotate = () => {
    const currentSlide = track.querySelector('.current-slide');
    const nextSlide = currentSlide.nextElementSibling || slides[0];
    const currentDot = dotsNav.querySelector('.current-slide');
    const nextDot = currentDot.nextElementSibling || dots[0];

    moveToSlide(track, currentSlide, nextSlide);
    updateDots(currentDot, nextDot);
  };

  // Function to start auto-rotation
  const startAutoRotate = () => {
    autoRotateInterval = setInterval(autoRotate, 3000);
  };

  // Start initial auto-rotation
  startAutoRotate();

  // Event listener for the dots navigation
  dotsNav.addEventListener('click', (e) => {
    const targetDot = e.target.closest('.carousel__indicator');
    if (!targetDot) return;

    // Clear existing intervals
    clearInterval(autoRotateInterval);

    const currentSlide = track.querySelector('.current-slide');
    const currentDot = dotsNav.querySelector('.current-slide');
    const targetIndex = dots.indexOf(targetDot);
    const targetSlide = slides[targetIndex];

    moveToSlide(track, currentSlide, targetSlide);
    updateDots(currentDot, targetDot);

    // Resume auto-rotation after 10 seconds
    setTimeout(() => {
      startAutoRotate();
    }, 3000); // 10 seconds delay
  });
});
