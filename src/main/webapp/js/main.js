// ===== BACK TO TOP BUTTON =====
const backToTopButton = document.getElementById('backToTop');

// ===== NAVBAR SCROLL EFFECT =====
window.addEventListener('scroll', function() {
    const navbar = document.querySelector('.navbar');
    if (window.scrollY > 50) {
        navbar.style.padding = '10px 0';
        navbar.style.boxShadow = '0 5px 20px rgba(0, 0, 0, 0.5)';
    } else {
        navbar.style.padding = '15px 0';
        navbar.style.boxShadow = '0 4px 6px rgba(0, 0, 0, 0.1)';
    }
});

// Show/Hide button on scroll
window.addEventListener('scroll', function() {
    if (window.pageYOffset > 300) {
        backToTopButton.classList.add('show');
    } else {
        backToTopButton.classList.remove('show');
    }
});

// Smooth scroll to top
backToTopButton.addEventListener('click', function(e) {
    e.preventDefault();
    window.scrollTo({
        top: 0,
        behavior: 'smooth'
    });
});

// ===== NEWSLETTER FORM =====
const newsletterForm = document.querySelector('.newsletter-form');
if (newsletterForm) {
    newsletterForm.addEventListener('submit', function(e) {
        e.preventDefault();
        const email = this.querySelector('input[type="email"]').value;
        alert('Thank you for subscribing with: ' + email);
        this.reset();
    });
}

console.log('Footer loaded successfully! 🚀');