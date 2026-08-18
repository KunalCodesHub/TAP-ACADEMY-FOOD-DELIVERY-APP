<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- ===== FOOTER START ===== -->
<footer class="footer-section">
    <div class="container">
        <div class="row g-4">
            
            <!-- Column 1: Brand & About -->
            <div class="col-lg-4 col-md-6">
                <div class="footer-brand">
                    <h3 class="text-danger fw-bold mb-3">
                        <i class="bi bi-cup-hot-fill"></i> FoodExpress
                    </h3>
                    <p class="footer-about">
                        Delicious food delivered to your doorstep. We connect you with the best restaurants in your city for a fast, fresh, and reliable food delivery experience.
                    </p>
                    
                    <!-- Social Media Icons -->
                    <div class="social-icons mt-3">
                        <a href="#" class="social-link" title="Facebook">
                            <i class="bi bi-facebook"></i>
                        </a>
                        <a href="#" class="social-link" title="Instagram">
                            <i class="bi bi-instagram"></i>
                        </a>
                        <a href="#" class="social-link" title="Twitter">
                            <i class="bi bi-twitter-x"></i>
                        </a>
                        <a href="#" class="social-link" title="YouTube">
                            <i class="bi bi-youtube"></i>
                        </a>
                        <a href="#" class="social-link" title="LinkedIn">
                            <i class="bi bi-linkedin"></i>
                        </a>
                    </div>
                </div>
            </div>
            
            <!-- Column 2: Quick Links -->
            <div class="col-lg-2 col-md-6">
                <h5 class="footer-heading">Quick Links</h5>
                <ul class="footer-links">
                    <li>
                        <a href="<%= request.getContextPath() %>/index.jsp">
                            <i class="bi bi-chevron-right"></i> Home
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/restaurants.jsp">
                            <i class="bi bi-chevron-right"></i> Restaurants
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/cart.jsp">
                            <i class="bi bi-chevron-right"></i> My Cart
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/login.jsp">
                            <i class="bi bi-chevron-right"></i> Login
                        </a>
                    </li>
                    <li>
                        <a href="<%= request.getContextPath() %>/register.jsp">
                            <i class="bi bi-chevron-right"></i> Sign Up
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- Column 3: Services -->
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-heading">Our Services</h5>
                <ul class="footer-links">
                    <li>
                        <a href="#">
                            <i class="bi bi-chevron-right"></i> Food Delivery
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="bi bi-chevron-right"></i> Restaurant Partner
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="bi bi-chevron-right"></i> Delivery Partner
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="bi bi-chevron-right"></i> Corporate Orders
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="bi bi-chevron-right"></i> Gift Cards
                        </a>
                    </li>
                </ul>
            </div>
            
            <!-- Column 4: Contact Info -->
            <div class="col-lg-3 col-md-6">
                <h5 class="footer-heading">Contact Us</h5>
                <ul class="footer-contact">
                    <li>
                        <i class="bi bi-geo-alt-fill"></i>
                        <span>Bangalore, Karnataka, India - 560001</span>
                    </li>
                    <li>
                        <i class="bi bi-telephone-fill"></i>
                        <span>+91 98765 43210</span>
                    </li>
                    <li>
                        <i class="bi bi-envelope-fill"></i>
                        <span>support@foodexpress.com</span>
                    </li>
                    <li>
                        <i class="bi bi-clock-fill"></i>
                        <span>Open 24/7 - Every Day</span>
                    </li>
                </ul>
            </div>
            
        </div>
        
        <!-- Newsletter Section -->
        <div class="row mt-4">
            <div class="col-12">
                <div class="newsletter-box">
                    <div class="row align-items-center">
                        <div class="col-md-6">
                            <h4 class="text-white mb-2">
                                <i class="bi bi-envelope-paper"></i> Subscribe to Our Newsletter
                            </h4>
                            <p class="text-white-50 mb-0">Get the latest offers and updates delivered to your inbox!</p>
                        </div>
                        <div class="col-md-6">
                            <form class="newsletter-form">
                                <div class="input-group">
                                    <input type="email" class="form-control" placeholder="Enter your email" required>
                                    <button class="btn btn-light" type="submit">
                                        <i class="bi bi-send-fill"></i> Subscribe
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Divider -->
        <hr class="footer-divider">
        
        <!-- Bottom Bar -->
        <div class="row align-items-center">
            <div class="col-md-6 text-center text-md-start">
                <p class="mb-0 copyright-text">
                    &copy; 2025 <strong class="text-danger">FoodExpress</strong>. All Rights Reserved.
                </p>
            </div>
            <div class="col-md-6 text-center text-md-end">
                <p class="mb-0 credit-text">
                    Built with <i class="bi bi-heart-fill text-danger"></i> by 
                    <strong>TAP Academy</strong>
                </p>
            </div>
        </div>
        
        <!-- Payment Methods -->
        <div class="row mt-3">
            <div class="col-12 text-center">
                <p class="mb-2 text-white-50">We Accept:</p>
                <div class="payment-methods">
                    <i class="bi bi-credit-card-2-front"></i>
                    <i class="bi bi-credit-card-2-back"></i>
                    <i class="bi bi-paypal"></i>
                    <i class="bi bi-wallet2"></i>
                    <i class="bi bi-bank"></i>
                    <i class="bi bi-cash-stack"></i>
                </div>
            </div>
        </div>
        
    </div>
    
    <!-- Back to Top Button -->
    <a href="#" class="back-to-top" id="backToTop" title="Back to Top">
        <i class="bi bi-arrow-up"></i>
    </a>
    
</footer>
<!-- ===== FOOTER END ===== -->

<!-- Bootstrap 5 JavaScript Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom JavaScript -->
<script src="<%= request.getContextPath() %>/js/main.js"></script>

</body>
</html>