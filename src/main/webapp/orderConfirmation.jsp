<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.OrderTable, entity.OrderItem, entity.Restaurant" %>
<%@ page import="java.util.List, java.util.HashMap" %>
<%@ page import="java.math.BigDecimal" %>
<% 
	String ctx = request.getContextPath();

	OrderTable orderTable = (OrderTable)request.getAttribute("orderTable");
	
	List<OrderItem> cnfOrders = (List<OrderItem>)request.getAttribute("orderItems");
	
	HashMap<Integer, String> map= (HashMap<Integer, String>)request.getAttribute("map");
	
	Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
	
	if (orderTable == null || cnfOrders == null || restaurant == null || map == null) {
		response.sendRedirect(request.getContextPath() + "/home");
		return;
	}
%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp" %>
<!-- Adding orderConformation.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/orderConfirmation.css">


<div class="container confirmation-wrapper">
	<div class="text-center">
		<i class="bi bi-check-circle-fill success-icon"></i>
		<h1 id="success-msg">Order Placed Successfully!</h1>
		<h4 id="order-no">Order#<%= orderTable.getOrderId() %></h4>
		<p>Estimated Delivery: <%= restaurant.getDeliveryTime() %> minutes</p>
	</div>
	<div class="order-card">
		<p><i class="bi bi-geo-alt-fill"></i>  Delivered at : <%= orderTable.getDeliveryAddress() %></p>
		<p><i class="bi bi-credit-card-fill"></i>  Payment Method: <%= orderTable.getPaymentMethod() %></p>
		<table class="table table-dark table-hover table-borderless">
			<tbody>
				<% for (OrderItem cnfOrder : cnfOrders) { %>
				<tr> 
					<th><%= map.get(cnfOrder.getMenuId()) %> × <%= cnfOrder.getQuantity() %></th>
					<td>₹<%= String.format("%.2f", cnfOrder.getItemTotal()) %></td>
    			</tr>
		<% } %>
			</tbody>
		</table>
		<h2 class="order-total">Total: ₹<%= String.format("%.2f", orderTable.getTotalAmount()) %></h2>
	</div>
	<a href="<%= ctx %>/home" class="btn btn-danger">Home</a>
</div>
<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>