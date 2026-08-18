<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.OrderTable" %>
<%@ page import="java.util.List" %>
<% 
	List<OrderTable> orders = (List<OrderTable>)request.getAttribute("orders"); 
	
	// Flash message
	String successMsg = (String) session.getAttribute("successMsg");
	String errorMsg   = (String) session.getAttribute("errorMsg");
	if (successMsg != null) session.removeAttribute("successMsg");
	if (errorMsg != null) session.removeAttribute("errorMsg");
%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="../includes/header.jsp" %>
<!-- Style about.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/orders.css">

<div class="container-fluid dashboard-wrapper py-4">

	<!-- Page Heading -->
	<div class="dashboard-header">
		<div>
			<h2 class="dashboard-title">
				<i class="bi bi-bag-check-fill"></i> Manage Orders
			</h2>
			<p class="dashboard-subtitle">View and update order statuses</p>
		</div>
		<div class="dashboard-badge">
			<i class="bi bi-clipboard-data-fill"></i>
			<%= (orders != null) ? orders.size() : 0 %> Orders
		</div>
	</div>

	<!-- Admin Nav Tabs -->
	<div class="dashboard-nav mb-4">
		<a href="<%= request.getContextPath() %>/admin" class="nav-tab">
			<i class="bi bi-grid-fill"></i> Dashboard
		</a>
		<a href="<%= request.getContextPath() %>/admin/orders" class="nav-tab active">
			<i class="bi bi-bag-check-fill"></i> Orders
		</a>
		<a href="<%= request.getContextPath() %>/admin/users" class="nav-tab">
			<i class="bi bi-people-fill"></i> Users
		</a>
		<a href="<%= request.getContextPath() %>/admin/restaurants" class="nav-tab">
			<i class="bi bi-shop"></i> Restaurants
		</a>
	</div>

	<!-- Flash Messages -->
	<% if (successMsg != null) { %>
		<div class="admin-alert admin-alert-success alert-dismissible fade show" role="alert">
			<i class="bi bi-check-circle-fill"></i> <%= successMsg %>
			<button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
		</div>
	<% } %>
	<% if (errorMsg != null) { %>
		<div class="admin-alert admin-alert-error alert-dismissible fade show" role="alert">
			<i class="bi bi-exclamation-triangle-fill"></i> <%= errorMsg %>
			<button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert"></button>
		</div>
	<% } %>

	<!-- Orders Table Card -->
	<div class="admin-table-card">
		<div class="table-responsive">
			<table class="table admin-table">
				<thead>
					<tr>
						<th>Order ID</th>
						<th>User ID</th>
						<th>Restaurant ID</th>
						<th>Amount</th>
						<th>Payment</th>
						<th>Date</th>
						<th>Status</th>
						<th class="text-end">Action</th>
					</tr>
				</thead>
				<tbody>
					<% if (orders != null && !orders.isEmpty()) { %>
						<% for (OrderTable order : orders) {
							String formId = "statusForm_" + order.getOrderId();
							String statusName = order.getStatus().name();
							String statusClass;
							switch (order.getStatus()) {
								case PENDING:          statusClass = "status-pending";   break;
								case CONFIRMED:        statusClass = "status-confirmed"; break;
								case PREPARING:        statusClass = "status-progress";  break;
								case OUT_FOR_DELIVERY: statusClass = "status-progress";  break;
								case DELIVERED:        statusClass = "status-delivered"; break;
								case CANCELLED:        statusClass = "status-cancelled"; break;
								default:               statusClass = "status-default";
							}
						%>
							<tr>
								<td><span class="cell-id">#<%= order.getOrderId() %></span></td>
								<td><span class="cell-muted">U-<%= order.getUserId() %></span></td>
								<td><span class="cell-muted">R-<%= order.getRestaurantId() %></span></td>
								<td><span class="cell-amount">₹<%= String.format("%.2f", order.getTotalAmount()) %></span></td>
								<td><span class="cell-payment"><i class="bi bi-credit-card-fill"></i> <%= order.getPaymentMethod() %></span></td>
								<td><span class="cell-date"><%= order.getOrderDate() %></span></td>
								<td>
									<form id="<%= formId %>" method="post" action="<%= request.getContextPath() %>/admin/update-status">
										<input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
										<select name="status" class="form-select form-select-sm status-select <%= statusClass %>">
											<% for (OrderTable.Status s : OrderTable.Status.values()) { %>
												<option value="<%= s.name() %>" <%= (order.getStatus() == s) ? "selected" : "" %>><%= s.name() %></option>
											<% } %>
										</select>
									</form>
								</td>
								<td class="text-end">
									<button type="submit" form="<%= formId %>" class="btn btn-sm update-btn">
										<i class="bi bi-arrow-clockwise"></i> Update
									</button>
								</td>
							</tr>
						<% } %>
					<% } else { %>
						<tr>
							<td colspan="8" class="empty-row">
								<i class="bi bi-inbox"></i>
								<p>No orders found.</p>
							</td>
						</tr>
					<% } %>
				</tbody>
			</table>
		</div>
	</div>

</div>

<!-- FOOTER JSP INCLUDE -->
<%@ include file="../includes/footer.jsp" %>