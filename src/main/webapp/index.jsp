<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Restaurant" %>
<%@ page import="entity.Menu" %>
<%@ page import="dao.RestaurantDAO" %>
<%@ page import="dao.MenuDAO" %>
<%@ page import="dao.impl.RestaurantDAOImpl" %>
<%@ page import="dao.impl.MenuDAOImpl" %>

<%
    // Fetch data directly (in case user comes without going through servlet)
    List<Restaurant> topRestaurants = (List<Restaurant>) request.getAttribute("topRestaurants");
    List<Menu> popularItems = (List<Menu>) request.getAttribute("popularItems");
    
    // If servlet didn't provide data, fetch it here
    if (topRestaurants == null) {
        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        topRestaurants = restaurantDAO.getAllRestaurants();
		topRestaurants.sort((a, b) -> Double.compare(b.getRating().doubleValue(), a.getRating().doubleValue()));
        if (topRestaurants != null && topRestaurants.size() > 6) {
            topRestaurants = topRestaurants.subList(0, 6);
        }
    }
    
    if (popularItems == null) {
        MenuDAO menuDAO = new MenuDAOImpl();
        popularItems = menuDAO.getAllMenus();
        if (popularItems != null && popularItems.size() > 8) {
            popularItems = popularItems.subList(0, 8);
        }
    }
    String ctx = request.getContextPath();
%>

<!-- Include Header -->
<%@ include file="/includes/header.jsp" %>

<!-- Add index page specific CSS -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css">

<!-- Add index page splash css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/splash.css">

<!-- Splash Screen -->
<div id="splash-overlay">
    <div id="splash-circle"></div>
    <div id="splash-logo">
    	<i class="bi bi-cup-hot-fill text-white"></i>FoodExpress
    </div>
</div>	

<!-- ===== HERO SECTION ===== -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center min-vh-75">
            
            <!-- Left Side: Text Content -->
            <div class="col-lg-6">
                <div class="hero-content">
                    <span class="hero-badge">
                        <i class="bi bi-lightning-fill"></i> Fast Delivery in 30 Mins
                    </span>
                    <h1 class="hero-title">
                        Delicious Food <br>
                        <span class="text-warning">Delivered Fresh</span> <br>
                        To Your Door
                    </h1>
                    <p class="hero-subtitle">
                        Order from your favorite restaurants and get fresh, hot food delivered fast. 
                        Choose from thousands of dishes across multiple cuisines.
                    </p>
                    
                    <!-- Search Bar -->
                    <div class="hero-search">
                        <form action="restaurants.jsp" method="get">
                            <div class="input-group">
                                <span class="input-group-text">
                                    <i class="bi bi-search"></i>
                                </span>
                                <input type="text" name="search" class="form-control" 
                                       placeholder="Search restaurants or dishes...">
                                <button class="btn btn-warning" type="submit">
                                    <i class="bi bi-arrow-right"></i> Search
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Stats -->
                    <div class="hero-stats">
                        <div class="stat-item">
                            <h3>20+</h3>
                            <p>Restaurants</p>
                        </div>
                        <div class="stat-item">
                            <h3>500+</h3>
                            <p>Dishes</p>
                        </div>
                        <div class="stat-item">
                            <h3>10K+</h3>
                            <p>Happy Customers</p>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- Right Side: Hero Image -->
            <div class="col-lg-6 d-none d-lg-block">
                <div class="hero-image">
                    <img src="<%= ctx %>/IMG/banner/delivery-boy-0.1.png" 
                         alt="Delicious Food" 
                         class="img-fluid">
                    
                    <!-- Floating Cards -->
                    <div class="floating-card card-1">
                        <i class="bi bi-truck"></i>
                        <div>
                            <h5>Fast Delivery</h5>
                            <p>30 min or free</p>
                        </div>
                    </div>
                    
                    <div class="floating-card card-2">
                        <i class="bi bi-star-fill text-warning"></i>
                        <div>
                            <h5>4.8 Rating</h5>
                            <p>10K+ Reviews</p>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</section>

<!-- ===== CATEGORIES SECTION ===== -->
<section class="section-padding bg-dark">
    <div class="container">
        <div class="section-title">
            <span class="section-subtitle">EXPLORE</span>
            <h2>Popular Categories</h2>
            <p>Choose from a variety of delicious food categories</p>
        </div>
        
        <div class="row g-4">
            <div class="col-6 col-md-3">
                <a href="restaurants.jsp?category=breakfast" class="category-link">
                    <div class="category-card">
                        <div class="category-icon bg-warning-subtle">
                            <i class="bi bi-cup-hot-fill"></i>
                        </div>
                        <h4>Breakfast</h4>
                        <p>Start your day right</p>
                        <span class="category-count">10+ Items</span>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-3">
                <a href="restaurants.jsp?category=lunch" class="category-link">
                    <div class="category-card">
                        <div class="category-icon bg-danger-subtle">
                            <i class="bi bi-egg-fried"></i>
                        </div>
                        <h4>Lunch & Dinner</h4>
                        <p>Hearty meals</p>
                        <span class="category-count">15+ Items</span>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-3">
                <a href="restaurants.jsp?category=desserts" class="category-link">
                    <div class="category-card">
                        <div class="category-icon bg-info-subtle">
                            <i class="bi bi-cake2-fill"></i>
                        </div>
                        <h4>Desserts</h4>
                        <p>Sweet treats</p>
                        <span class="category-count">11+ Items</span>
                    </div>
                </a>
            </div>
            
            <div class="col-6 col-md-3">
                <a href="restaurants.jsp?category=drinks" class="category-link">
                    <div class="category-card">
                        <div class="category-icon bg-success-subtle">
                            <i class="bi bi-cup-straw"></i>
                        </div>
                        <h4>Drinks</h4>
                        <p>Refreshing beverages</p>
                        <span class="category-count">8+ Items</span>
                    </div>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- ===== FEATURES SECTION ===== -->
<section class="section-padding bg-dark">
    <div class="container">
        <div class="section-title">
            <span class="section-subtitle">WHY US</span>
            <h2>Why Choose FoodExpress?</h2>
            <p>We provide the best food delivery experience</p>
        </div>
        
        <div class="row g-4">
            <div class="col-md-6 col-lg-3">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-truck"></i>
                    </div>
                    <h4>Fast Delivery</h4>
                    <p>Hot food delivered to your doorstep in 30 minutes or less.</p>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-3">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-shield-check"></i>
                    </div>
                    <h4>Safe & Hygienic</h4>
                    <p>All restaurants follow strict hygiene and safety standards.</p>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-3">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-wallet2"></i>
                    </div>
                    <h4>Easy Payment</h4>
                    <p>Multiple payment options including UPI, Cards, and Cash.</p>
                </div>
            </div>
            
            <div class="col-md-6 col-lg-3">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="bi bi-headset"></i>
                    </div>
                    <h4>24/7 Support</h4>
                    <p>Our customer support team is available round the clock.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== POPULAR RESTAURANTS SECTION ===== -->
<section class="section-padding bg-dark">
    <div class="container">
        <div class="section-title">
            <span class="section-subtitle">RESTAURANTS</span>
            <h2>Popular Restaurants</h2>
            <p>Order from the best restaurants in your city</p>
        </div>
        
        <div class="row g-4">
            <% 
                if (topRestaurants != null && !topRestaurants.isEmpty()) {
                    for (Restaurant r : topRestaurants) {
            %>
                        <div class="col-md-6 col-lg-4">
                            <div class="restaurant-card">
                                <div class="restaurant-image">
                                    <img src="<%= request.getContextPath() %>/<%= r.getImagePath() %>" alt="<%= r.getName() %>"
     								onerror="this.onerror=null; this.src='https://via.placeholder.com/500x400/dc3545/ffffff?text=' + encodeURIComponent('<%= r.getName() %>');">
                                    <span class="restaurant-badge">
                                        <i class="bi bi-star-fill"></i> <%= r.getRating() %>
                                    </span>
                                </div>
                                <div class="restaurant-info">
                                    <h4><%= r.getName() %></h4>
                                    <p class="cuisine">
                                        <i class="bi bi-tag-fill"></i> <%= r.getCuisineType() %>
                                    </p>
                                    <div class="restaurant-meta">
                                        <span>
                                            <i class="bi bi-clock"></i> <%= r.getDeliveryTime() %> mins
                                        </span>
                                        <span>
                                            <i class="bi bi-geo-alt"></i> 
                                            <%= r.getAddress().length() > 20 ? 
                                                r.getAddress().substring(0, 20) + "..." : 
                                                r.getAddress() %>
                                        </span>
                                    </div>
                                    <a href="menu.jsp?id=<%= r.getRestaurantId() %>" 
                                       class="btn btn-danger w-100 mt-3">
                                        View Menu <i class="bi bi-arrow-right"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
            <%
                    }
                } else {
            %>
                    <div class="col-12 text-center py-5">
                        <i class="bi bi-shop display-1 text-muted"></i>
                        <h4 class="mt-3">No restaurants available</h4>
                        <p class="text-muted">Please check back later</p>
                    </div>
            <%
                }
            %>
        </div>
        
        <div class="text-center mt-5">
            <a href="restaurants.jsp" class="btn btn-outline-danger btn-lg custom-btn">
                View All Restaurants <i class="bi bi-arrow-right"></i>
            </a>
        </div>
    </div>
</section>


<!-- ===== HOW IT WORKS SECTION ===== -->
<section class="section-padding bg-dark">
    <div class="container">
        <div class="section-title">
            <span class="section-subtitle">PROCESS</span>
            <h2>How It Works</h2>
            <p>Order food in just 3 simple steps</p>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <div class="step-icon">
                        <i class="bi bi-search"></i>
                    </div>
                    <h4>Choose Restaurant</h4>
                    <p>Browse through our list of top-rated restaurants and select your favorite.</p>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <div class="step-icon">
                        <i class="bi bi-menu-button-wide"></i>
                    </div>
                    <h4>Select Food</h4>
                    <p>Pick your favorite dishes from the menu and add them to your cart.</p>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <div class="step-icon">
                        <i class="bi bi-truck"></i>
                    </div>
                    <h4>Enjoy Delivery</h4>
                    <p>Sit back and relax while we deliver hot, fresh food to your doorstep.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== TESTIMONIALS SECTION ===== -->
<section class="section-padding bg-dark">
    <div class="container">
        <div class="section-title">
            <span class="section-subtitle">REVIEWS</span>
            <h2>What Our Customers Say</h2>
            <p>Real reviews from real customers</p>
        </div>
        
        <div class="row g-4">
            <div class="col-md-4">
                <div class="testimonial-card">
                    <div class="testimonial-stars">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </div>
                    <p class="testimonial-text">
                        "The food was absolutely delicious and arrived hot! Fastest delivery I've ever experienced."
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">R</div>
                        <div>
                            <h5>Rahul Sharma</h5>
                            <span>Regular Customer</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="testimonial-card">
                    <div class="testimonial-stars">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </div>
                    <p class="testimonial-text">
                        "Great variety of restaurants and dishes. The app is very easy to use. Highly recommended!"
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">P</div>
                        <div>
                            <h5>Priya Patel</h5>
                            <span>Food Lover</span>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="testimonial-card">
                    <div class="testimonial-stars">
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                        <i class="bi bi-star-fill"></i>
                    </div>
                    <p class="testimonial-text">
                        "Excellent service! Customer support helped me quickly when I had an issue. Very satisfied!"
                    </p>
                    <div class="testimonial-author">
                        <div class="author-avatar">A</div>
                        <div>
                            <h5>Amit Kumar</h5>
                            <span>Happy Customer</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ===== CALL TO ACTION SECTION ===== -->
<section class="cta-section">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <h2 class="text-white">Ready to Order Delicious Food?</h2>
                <p class="text-white-50 mb-lg-0">
                    Join thousands of happy customers and get your favorite food delivered to your door!
                </p>
            </div>
            <div class="col-lg-4 text-lg-end">
                <a href="register.jsp" class="btn btn-warning btn-lg">
                    Get Started Now <i class="bi bi-arrow-right"></i>
                </a>
            </div>
        </div>
    </div>
</section>

<!-- Include Footer -->
<%@ include file="/includes/footer.jsp" %>
<script>
    window.addEventListener("load", function() {
        setTimeout(function() {
            var splash = document.getElementById("splash-overlay");
            splash.classList.add("hide-splash");
            setTimeout(function() {
                splash.remove();
            }, 600);
        }, 3200);
    });
</script>
