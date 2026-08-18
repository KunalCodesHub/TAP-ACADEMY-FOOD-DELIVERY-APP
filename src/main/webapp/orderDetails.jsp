<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><!DOCTYPE link PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<!-- import classes -->
<%@ page import="entity.OrderItem, entity.OrderTable, entity.Restaurant" %>
<%@ page import="java.util.List, java.util.HashMap" %>

<%
	String ctx = request.getContextPath();
	OrderTable orderTable        = (OrderTable)request.getAttribute("orderTable");
	Restaurant restaurant 	     = (Restaurant)request.getAttribute("restaurant");
	List<OrderItem> orderItems   = (List<OrderItem>)request.getAttribute("orderItems");
	HashMap<Integer, String> map = (HashMap<Integer, String>)request.getAttribute("map");
	
	if (orderTable == null || orderItems == null || restaurant == null || map == null) {
		response.sendRedirect(request.getContextPath() + "/home");
		return;
	}
%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp" %>
<!-- Reuse orderConfirmation.css for consistent styling -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/orderConfirmation.css">
<div class="container confirmation-wrapper">
	<div class="text-center">
		<i class="bi bi-receipt success-icon receipt-icon"></i>
		<h1 id="success-msg">Order Receipt</h1>
		<h4 id="order-no">Order #<%= orderTable.getOrderId() %></h4>
		<p>Here are your order details</p>
	</div>

	<div class="order-card">
		<p><i class="bi bi-shop"></i>  Restaurant: <%= restaurant.getName() %></p>
		<p><i class="bi bi-geo-alt-fill"></i>  Delivered at : <%= orderTable.getDeliveryAddress() %></p>
		<p><i class="bi bi-credit-card-fill"></i>  Payment Method: <%= orderTable.getPaymentMethod() %></p>
		<p><i class="bi bi-info-circle-fill"></i>  Status: <%= orderTable.getStatus() %></p>

		<table class="table table-dark table-hover table-borderless">
			<tbody>
				<% for (OrderItem item : orderItems) { %>
				<tr> 
					<th><%= map.get(item.getMenuId()) %> × <%= item.getQuantity() %></th>
					<td>₹<%= String.format("%.2f", item.getItemTotal()) %></td>
    			</tr>
				<% } %>
			</tbody>
		</table>
		<p class="order-total">Total: ₹<%= String.format("%.2f", orderTable.getTotalAmount()) %></p>
	</div>

	<a href="<%= ctx %>/my-orders" class="btn btn-danger">
		<i class="bi bi-arrow-left"></i> Back to My Orders
	</a>
</div>


<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>