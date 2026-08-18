<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp" %>
<!-- Style about.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/about.css">


<!-- =================== HERO SECTION =================== -->
<section class="about-hero">
	<div class="container">
		<div class="text-center">
			<i class="bi bi-cup-hot-fill about-hero-icon"></i>
			<h1 class="about-hero-title">About <span class="brand-highlight">FoodExpress</span></h1>
			<p class="about-hero-subtitle">
				Delivering happiness, one meal at a time. Fresh food from the best restaurants,
				straight to your doorstep — fast, safe, and always delicious.
			</p>
		</div>
	</div>
</section>


<!-- =================== OUR STORY =================== -->
<section class="about-section">
	<div class="container">
		<div class="row align-items-center">
			<div class="col-md-6">
				<h2 class="section-title">Our Story</h2>
				<p class="section-text">
					Founded in 2024, <strong>FoodExpress</strong> started with a simple idea —
					make great food accessible to everyone. What began as a small team of food
					enthusiasts has grown into a trusted platform serving thousands of customers.
				</p>
				<p class="section-text">
					We partner with the finest local restaurants to bring you a diverse menu of
					cuisines, all delivered by our dedicated fleet of delivery partners in record time.
				</p>
			</div>
			<div class="col-md-6 text-center">
				<div class="story-visual">
					<i class="bi bi-shop-window"></i>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- =================== STATS =================== -->
<section class="about-stats">
	<div class="container">
		<div class="row">
			<div class="col-md-3 col-6">
				<div class="stat-card">
					<i class="bi bi-people-fill"></i>
					<h3>50K+</h3>
					<p>Happy Customers</p>
				</div>
			</div>
			<div class="col-md-3 col-6">
				<div class="stat-card">
					<i class="bi bi-shop"></i>
					<h3>500+</h3>
					<p>Partner Restaurants</p>
				</div>
			</div>
			<div class="col-md-3 col-6">
				<div class="stat-card">
					<i class="bi bi-bag-check-fill"></i>
					<h3>1M+</h3>
					<p>Orders Delivered</p>
				</div>
			</div>
			<div class="col-md-3 col-6">
				<div class="stat-card">
					<i class="bi bi-geo-alt-fill"></i>
					<h3>25+</h3>
					<p>Cities Served</p>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- =================== FEATURES / WHY US =================== -->
<section class="about-section">
	<div class="container">
		<div class="text-center section-header">
			<h2 class="section-title">Why Choose Us?</h2>
			<p class="section-subtitle">What makes FoodExpress your favorite food companion</p>
		</div>

		<div class="row">
			<div class="col-md-4">
				<div class="feature-card">
					<div class="feature-icon">
						<i class="bi bi-lightning-charge-fill"></i>
					</div>
					<h4>Lightning Fast Delivery</h4>
					<p>Hot meals delivered to your doorstep in 30 minutes or less. We value your time.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="feature-card">
					<div class="feature-icon">
						<i class="bi bi-shield-fill-check"></i>
					</div>
					<h4>Safe & Secure</h4>
					<p>Contactless delivery, verified restaurants, and encrypted payments — every single time.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="feature-card">
					<div class="feature-icon">
						<i class="bi bi-star-fill"></i>
					</div>
					<h4>Top-Rated Restaurants</h4>
					<p>Hand-picked partners known for quality, hygiene, and mouth-watering flavors.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="feature-card">
					<div class="feature-icon">
						<i class="bi bi-cash-coin"></i>
					</div>
					<h4>Best Prices</h4>
					<p>Exclusive deals, member discounts, and free delivery on orders above ₹500.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="feature-card">
					<div class="feature-icon">
						<i class="bi bi-headset"></i>
					</div>
					<h4>24/7 Support</h4>
					<p>Our friendly customer support team is always ready to help — anytime, anywhere.</p>
				</div>
			</div>

			<div class="col-md-4">
				<div class="feature-card">
					<div class="feature-icon">
						<i class="bi bi-heart-fill"></i>
					</div>
					<h4>Made with Love</h4>
					<p>Every meal is prepared with care and delivered with a smile. Because you deserve it.</p>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- =================== MISSION & VISION =================== -->
<section class="about-section">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<div class="mv-card">
					<i class="bi bi-bullseye"></i>
					<h3>Our Mission</h3>
					<p>
						To make quality food accessible to everyone by connecting people with the
						best restaurants in their city, delivered swiftly and safely.
					</p>
				</div>
			</div>
			<div class="col-md-6">
				<div class="mv-card">
					<i class="bi bi-eye-fill"></i>
					<h3>Our Vision</h3>
					<p>
						To become the most loved food delivery platform, transforming how the world
						discovers, orders, and enjoys food — one delicious meal at a time.
					</p>
				</div>
			</div>
		</div>
	</div>
</section>


<!-- =================== CTA =================== -->
<section class="about-cta">
	<div class="container text-center">
		<h2>Ready to order your favorite meal?</h2>
		<p>Explore hundreds of restaurants and get your food delivered in minutes.</p>
		<a href="<%= request.getContextPath() %>/restaurants" class="btn btn-danger cta-btn">
			<i class="bi bi-shop"></i> Explore Restaurants
		</a>
	</div>
</section>


<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>