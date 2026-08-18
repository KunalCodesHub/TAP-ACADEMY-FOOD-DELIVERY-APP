<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int totalUsers       = (int)request.getAttribute("totalUsers");
	int totalOrders      = (int)request.getAttribute("totalOrders");
	double revenue       = (double)request.getAttribute("totalRevenue");
	int totalRestaurants = (int)request.getAttribute("totalRestaurants");
%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="../includes/header.jsp" %>
<!-- Style about.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">

	<div class="container-fluid dashboard-wrapper py-4">

	<!-- Page Heading -->
	<div class="dashboard-header">
		<div>
			<h2 class="dashboard-title">
				<i class="bi bi-speedometer2"></i> Admin Dashboard
			</h2>
			<p class="dashboard-subtitle">Overview of platform activity</p>
		</div>
		<div class="dashboard-badge">
			<i class="bi bi-shield-fill-check"></i> Admin Panel
		</div>
	</div>

	<!-- Navigation Tabs -->
	<div class="dashboard-nav mb-4">
		<a href="<%= request.getContextPath() %>/admin" class="nav-tab active">
			<i class="bi bi-grid-fill"></i> Dashboard
		</a>
		<a href="<%= request.getContextPath() %>/admin/orders" class="nav-tab">
			<i class="bi bi-bag-check-fill"></i> Orders
		</a>
		<a href="<%= request.getContextPath() %>/admin/users" class="nav-tab">
			<i class="bi bi-people-fill"></i> Users
		</a>
		<a href="<%= request.getContextPath() %>/admin/restaurants" class="nav-tab">
			<i class="bi bi-shop"></i> Restaurants
		</a>
	</div>

	<!-- Stat Cards -->
	<div class="row g-4">
		<div class="col-md-6 col-xl-3">
			<div class="stat-card stat-users">
				<div class="stat-icon">
					<i class="bi bi-people-fill"></i>
				</div>
				<div class="stat-info">
					<h6>Total Users</h6>
					<h3><%= totalUsers %></h3>
					<span class="stat-tag">Registered Members</span>
				</div>
			</div>
		</div>

		<div class="col-md-6 col-xl-3">
			<div class="stat-card stat-orders">
				<div class="stat-icon">
					<i class="bi bi-bag-check-fill"></i>
				</div>
				<div class="stat-info">
					<h6>Total Orders</h6>
					<h3><%= totalOrders %></h3>
					<span class="stat-tag">All-time Orders</span>
				</div>
			</div>
		</div>

		<div class="col-md-6 col-xl-3">
			<div class="stat-card stat-restaurants">
				<div class="stat-icon">
					<i class="bi bi-shop"></i>
				</div>
				<div class="stat-info">
					<h6>Total Restaurants</h6>
					<h3><%= totalRestaurants %></h3>
					<span class="stat-tag">Active Partners</span>
				</div>
			</div>
		</div>

		<div class="col-md-6 col-xl-3">
			<div class="stat-card stat-revenue">
				<div class="stat-icon">
					<i class="bi bi-currency-rupee"></i>
				</div>
				<div class="stat-info">
					<h6>Total Revenue</h6>
					<h3>₹<%= String.format("%.2f", revenue) %></h3>
					<span class="stat-tag">Gross Earnings</span>
				</div>
			</div>
		</div>
	</div>

</div>

<!-- FOOTER JSP INCLUDE -->
<%@ include file="../includes/footer.jsp" %>