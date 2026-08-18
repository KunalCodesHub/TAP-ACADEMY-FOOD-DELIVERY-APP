<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List, entity.CartItem, entity.User" %>
<%@ page import="dao.impl.RestaurantDAOImpl" %>
<%! RestaurantDAOImpl daoImp = new RestaurantDAOImpl(); %>
<%
	@SuppressWarnings("unchecked")
	List<CartItem> items = (List<CartItem>) session.getAttribute("cartItems");
	User user = (User) session.getAttribute("loggedInUser");
	String userAddress = "";
	Integer restId = null;
	boolean isEmpty = true;
	double subTotal = 0.0;
	double deliveryFee = 0.0;
	double gst = 0.0;
	double total = 0.0;
	
	if (user != null) {
		userAddress = user.getAddress();
	} 
	if (items != null && !items.isEmpty()) {
		isEmpty = false;
		for (CartItem item : items) {
			subTotal += item.getItemTotal();
		}
		restId = items.get(0).getRestaurantId();
	}
	deliveryFee = (subTotal > 500) ? 0.0 : 40.0;
	gst = subTotal * 0.05;
	total = subTotal + deliveryFee + gst; 
	
	String ctx = (String) request.getContextPath();
	int itemCount = (items != null) ? items.size() : 0;
%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp" %>
<!-- Style cart.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/cart.css">


<!-- ============ EMPTY CART ============ -->
<% if (isEmpty) { %>
<div class="container empty-cart-wrapper text-center">
	<div class="empty-cart-icon-wrap">
		<i class="bi bi-cart-x"></i>
	</div>
	<h1>Your Cart is Empty</h1>
	<p>Looks like you haven't added anything yet.<br>Browse restaurants and discover delicious meals!</p>
	<a class="btn btn-danger empty-cta" href="<%= ctx %>/restaurants">
		<i class="bi bi-shop"></i> Browse Restaurants
	</a>
</div>

<% } else { %>

<!-- ============ CART PAGE ============ -->
<div class="container cart-page-wrapper">

	<!-- Page Header -->
	<div class="cart-page-header">
		<div>
			<h1 class="cart-heading">
				<i class="bi bi-cart-fill"></i> Your Cart
			</h1>
			<p class="cart-subheading">Review your items and place your order</p>
		</div>
		<span class="cart-count-badge">
			<i class="bi bi-bag-fill"></i> <%= itemCount %> Item<%= itemCount != 1 ? "s" : "" %>
		</span>
	</div>

	<div class="row cart-main-row">

		<!-- ============ LEFT: CART ITEMS ============ -->
		<div class="col-lg-7">
			<div class="cart-items-container">
				<% for (CartItem item : items) { %>
					<div class="cart-item">
						<div class="cart-item-left">
							<img src="<%= item.getImagePath() %>" alt="<%= item.getItemName() %>" class="cart-item-img">
							<div class="cart-item-info">
								<h6 class="cart-item-name"><%= item.getItemName() %></h6>
								<div class="cart-item-price-line">
									<span class="cart-item-price">₹<%= String.format("%.2f",item.getPrice()) %></span>
									<span class="cart-item-multiplier">×</span>
									<span class="cart-item-qty"><%= item.getQuantity() %></span>
								</div>
							</div>
						</div>

						<div class="cart-item-right">
							<span class="cart-item-total">₹<%= String.format("%.2f", item.getItemTotal()) %></span>
						</div>
					</div>
				<% } %>
			</div>

			<a class="add-more-btn" href="<%= ctx %>/menu?id=<%= restId %>">
				<i class="bi bi-plus-circle"></i> Add More Items
			</a>
		</div>

		<!-- ============ RIGHT: SUMMARY + CHECKOUT ============ -->
		<div class="col-lg-5">

			<!-- Order Summary Card -->
			<div class="order-summary">
				<h5 class="summary-title">
					<i class="bi bi-receipt"></i> Order Summary
				</h5>

				<div class="summary-row">
					<span class="summary-label">Subtotal</span>
					<span class="summary-value">₹<%= String.format("%.2f", subTotal) %></span>
				</div>

				<div class="summary-row">
					<span class="summary-label">
						<i class="bi bi-truck"></i> Delivery Fee
					</span>
					<% if (deliveryFee == 0.0) { %>
						<span class="summary-value free-tag">FREE</span>
					<% } else { %>
						<span class="summary-value">₹<%= String.format("%.2f", deliveryFee) %></span>
					<% } %>
				</div>

				<div class="summary-row">
					<span class="summary-label">GST (5%)</span>
					<span class="summary-value">₹<%= String.format("%.2f", gst) %></span>
				</div>

				<% if (deliveryFee == 0.0 && subTotal > 0) { %>
					<div class="free-delivery-note">
						<i class="bi bi-check-circle-fill"></i> You saved ₹40 on delivery!
					</div>
				<% } else if (deliveryFee > 0) { %>
					<div class="delivery-hint">
						<i class="bi bi-info-circle-fill"></i>
						Add ₹<%= String.format("%.2f", 500 - subTotal) %> more for FREE delivery
					</div>
				<% } %>

				<div class="summary-divider"></div>

				<div class="summary-total-row">
					<span class="summary-total-label">Total</span>
					<span class="summary-total-value">₹<%= String.format("%.2f", total) %></span>
				</div>
			</div>

			<!-- Checkout / Delivery Card -->
			<div class="checkout-card">
				<form action="<%= ctx %>/PlaceOrder" method="POST">

					<label class="form-label">
						<i class="bi bi-geo-alt-fill"></i> Delivery Address
					</label>
					<textarea class="form-control" rows="3" name="deliveryAddress" placeholder="Enter your full address..." required><%= userAddress %></textarea>

					<label class="form-label">
						<i class="bi bi-credit-card-2-front-fill"></i> Payment Method
					</label>

					<div class="payment-options">
						<label class="payment-option">
							<input type="radio" name="paymentMethod" value="CASH" checked>
							<div class="payment-content">
								<i class="bi bi-cash-stack payment-icon"></i>
								<div>
									<div class="payment-name">Cash on Delivery</div>
									<div class="payment-desc">Pay when your order arrives</div>
								</div>
								<i class="bi bi-check-circle-fill payment-check"></i>
							</div>
						</label>

						<label class="payment-option">
							<input type="radio" name="paymentMethod" value="ONLINE">
							<div class="payment-content">
								<i class="bi bi-credit-card-2-front-fill payment-icon"></i>
								<div>
									<div class="payment-name">Pay Online</div>
									<div class="payment-desc">Card, UPI, or Netbanking</div>
								</div>
								<i class="bi bi-check-circle-fill payment-check"></i>
							</div>
						</label>
					</div>

					<button class="btn btn-danger place-order-btn" type="submit">
						<i class="bi bi-bag-check-fill"></i> Proceed to Pay · ₹<%= String.format("%.2f", total) %>
					</button>

					<div class="secure-note">
						<i class="bi bi-shield-fill-check"></i> Secure checkout guaranteed
					</div>
				</form>
			</div>

		</div>
	</div>
</div>

<% } %>

<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>