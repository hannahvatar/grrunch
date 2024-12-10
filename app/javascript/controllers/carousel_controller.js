// app/javascript/controllers/carousel_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.currentPage = 1;
    this.totalPages = parseInt(this.element.dataset.totalPages);
  }

  next() {
    if (this.currentPage < this.totalPages) {
      this.navigate(this.currentPage + 1);
    }
  }

  previous() {
    if (this.currentPage > 1) {
      this.navigate(this.currentPage - 1);
    }
  }

  navigate(page) {
    // Hide current page
    this.element.querySelector(`[data-page="${this.currentPage}"]`).classList.add('hidden');

    // Show new page
    this.element.querySelector(`[data-page="${page}"]`).classList.remove('hidden');

    // Update current page
    this.currentPage = page;

    // Update navigation buttons
    this.updateNavigation();

    // Update URL without page reload
    const url = new URL(window.location);
    url.searchParams.set('page', page);
    window.history.pushState({}, '', url);
  }

  updateNavigation() {
    const prevButton = this.element.querySelector('.carousel-prev');
    const nextButton = this.element.querySelector('.carousel-next');

    prevButton.classList.toggle('hidden', this.currentPage === 1);
    nextButton.classList.toggle('hidden', this.currentPage === this.totalPages);
  }
}
