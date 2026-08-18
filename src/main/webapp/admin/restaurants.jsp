<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Restaurant" %>
<%
	List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
%>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/restaurantes.css">

<div class="container-fluid dashboard-wrapper py-4">

	<!-- Page Heading -->
	<div class="dashboard-header">
		<div>
			<h2 class="dashboard-title">
				<i class="bi bi-shop"></i> All Restaurants
			</h2>
			<p class="dashboard-subtitle">View registered restaurants</p>
		</div>
		<div class="dashboard-badge">
			<i class="bi bi-shop-window"></i>
			<%= (restaurants != null) ? restaurants.size() : 0 %> Restaurants
		</div>
	</div>

	<!-- Admin Nav Tabs -->
	<div class="dashboard-nav mb-4">
		<a href="<%= request.getContextPath() %>/admin" class="nav-tab">
			<i class="bi bi-grid-fill"></i> Dashboard
		</a>
		<a href="<%= request.getContextPath() %>/admin/orders" class="nav-tab">
			<i class="bi bi-bag-check-fill"></i> Orders
		</a>
		<a href="<%= request.getContextPath() %>/admin/users" class="nav-tab">
			<i class="bi bi-people-fill"></i> Users
		</a>
		<a href="<%= request.getContextPath() %>/admin/restaurants" class="nav-tab active">
			<i class="bi bi-shop"></i> Restaurants
		</a>
	</div>

	<!-- Restaurants Table Card -->
	<div class="admin-table-card">
		<div class="table-responsive">
			<table class="table admin-table">
				<thead>
					<tr>
						<th>Restaurant ID</th>
						<th>Name</th>
						<th>Cuisine Type</th>
						<th>Rating</th>
						<th>Delivery Time</th>
						<th>Status</th>
					</tr>
				</thead>
				<tbody>
					<% if (restaurants != null && !restaurants.isEmpty()) { %>
						<% for (Restaurant r : restaurants) { 
							double rating = r.getRating().doubleValue();
							String ratingClass;
							if (rating >= 4.5)       ratingClass = "rating-excellent";
							else if (rating >= 3.5)  ratingClass = "rating-good";
							else if (rating >= 2.5)  ratingClass = "rating-average";
							else                     ratingClass = "rating-poor";
						%>
							<tr>
								<td><span class="cell-id">#<%= r.getRestaurantId() %></span></td>
								<td>
									<div class="rest-cell">
										<div class="rest-avatar">
											<i class="bi bi-shop"></i>
										</div>
										<span class="rest-name"><%= r.getName() %></span>
									</div>
								</td>
								<td>
									<span class="cuisine-badge">
										<i class="bi bi-egg-fried"></i> <%= r.getCuisineType() %>
									</span>
								</td>
								<td>
									<span class="rating-badge <%= ratingClass %>">
										<i class="bi bi-star-fill"></i> <%= String.format("%.1f", rating) %>
									</span>
								</td>
								<td>
									<span class="cell-time">
										<i class="bi bi-clock-fill"></i> <%= r.getDeliveryTime() %> mins
									</span>
								</td>
								<td>
									<% if (r.isActive()) { %>
										<span class="status-badge status-active">
											<i class="bi bi-check-circle-fill"></i> Active
										</span>
									<% } else { %>
										<span class="status-badge status-inactive">
											<i class="bi bi-x-circle-fill"></i> Inactive
										</span>
									<% } %>
								</td>
							</tr>
						<% } %>
					<% } else { %>
						<tr>
							<td colspan="6" class="empty-row">
								<i class="bi bi-shop-window"></i>
								<p>No restaurants found.</p>
							</td>
						</tr>
					<% } %>
				</tbody>
			</table>
		</div>
	</div>

</div>


<%@ include file="../includes/footer.jsp" %>