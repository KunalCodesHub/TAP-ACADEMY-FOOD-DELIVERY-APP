<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="entity.OrderTable"%>
<%@page import="java.util.List"%>
<%@page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter"%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp"%>
<!-- Style cart.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/myOrders.css">

<%
	String ctx = request.getContextPath();
	List<OrderTable> orders = (List<OrderTable>) request.getAttribute("orders");
	if (orders == null || orders.isEmpty()) {
%>
	<div class="container empty-orders text-center">
		<i class="bi bi-bag-x"></i>
		<h1>No Orders Found</h1>
		<p>You haven't placed any orders yet. Start exploring delicious food!</p>
		<a class="btn btn-danger" href="<%= ctx %>/restaurants">Browse Restaurants</a>
	</div>
<%
	} else {
%>
	<div class="container my-orders-wrapper">
		<h1 class="orders-heading">
			<i class="bi bi-bag-check-fill"></i> My Orders
		</h1>
		<p class="orders-subtitle">Track and manage all your past orders</p>

		<div class="orders-list">
<%
		for (OrderTable order : orders) {

			String statusText  = order.getStatus().name();
			String s           = statusText.toUpperCase();
			String statusClass = "status-default";
			String statusIcon  = "bi-hourglass-split";
			LocalDateTime date   = order.getOrderDate();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MMM-dd-yyyy HH:mm:ss");
			String orderDate = date.format(formatter);

			if (s.equals("DELIVERED")) {
				statusClass = "status-delivered";
				statusIcon  = "bi-check-circle-fill";
			} else if (s.equals("PENDING")) {
				statusClass = "status-pending";
				statusIcon  = "bi-hourglass-split";
			} else if (s.equals("CONFIRMED")) {
				statusClass = "status-confirmed";
				statusIcon  = "bi-check2-circle";
			} else if (s.equals("PREPARING")) {
				statusClass = "status-progress";
				statusIcon  = "bi-fire";
			} else if (s.equals("OUT_FOR_DELIVERY")) {
				statusClass = "status-progress";
				statusIcon  = "bi-truck";
			} else if (s.equals("CANCELLED")) {
				statusClass = "status-cancelled";
				statusIcon  = "bi-x-circle-fill";
			}

			String statusLabel = statusText.replace("_", " ");
%>
			<div class="order-card">
				<div class="order-card-header">
					<div>
						<h5 class="order-id">Order #<%= order.getOrderId() %></h5>
						<span class="order-payment">
							<i class="bi bi-credit-card-fill"></i> <%= order.getPaymentMethod() %>
						</span>
					</div>
					<div class="order-header-right">
						<span class="order-status <%= statusClass %>">
							<i class="bi <%= statusIcon %>"></i> <%= statusLabel %>
						</span>
						<span class="order-date">
                			<i class="bi bi-calendar-event"></i> <%= orderDate %>
            			</span>
					</div>
				</div>

				<div class="order-card-body">
					<div class="order-total-block">
						<span class="label">Total Amount</span>
						<span class="amount">₹<%= String.format("%.2f", order.getTotalAmount()) %></span>
					</div>
					<a href="<%= ctx %>/OrderDetails?orderId=<%= order.getOrderId() %>" 
          			   class="btn view-receipt-btn">
            				<i class="bi bi-receipt"></i> View Receipt
        			</a>
				</div>
			</div>
<%
		}
%>
		</div>
	</div>
<%
	}
%>

<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>