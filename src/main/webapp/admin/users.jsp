<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.User" %>
<%
	List<User> users = (List<User>) request.getAttribute("users");
%>

<%@ include file="../includes/header.jsp" %>
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/users.css">

<div class="container-fluid dashboard-wrapper py-4">

	<!-- Page Heading -->
	<div class="dashboard-header">
		<div>
			<h2 class="dashboard-title">
				<i class="bi bi-people-fill"></i> All Users
			</h2>
			<p class="dashboard-subtitle">View registered users</p>
		</div>
		<div class="dashboard-badge">
			<i class="bi bi-person-lines-fill"></i>
			<%= (users != null) ? users.size() : 0 %> Users
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
		<a href="<%= request.getContextPath() %>/admin/users" class="nav-tab active">
			<i class="bi bi-people-fill"></i> Users
		</a>
		<a href="<%= request.getContextPath() %>/admin/restaurants" class="nav-tab">
			<i class="bi bi-shop"></i> Restaurants
		</a>
	</div>

	<!-- Users Table Card -->
	<div class="admin-table-card">
		<div class="table-responsive">
			<table class="table admin-table">
				<thead>
					<tr>
						<th>User ID</th>
						<th>Username</th>
						<th>Email</th>
						<th>Role</th>
						<th>Created Date</th>
					</tr>
				</thead>
				<tbody>
					<% if (users != null && !users.isEmpty()) { %>
						<% for (User u : users) { 
							String role = String.valueOf(u.getRole()).toUpperCase();
							String roleClass = "role-default";
							if (role.equals("ADMIN"))         roleClass = "role-admin";
							else if (role.equals("CUSTOMER")) roleClass = "role-customer";
							else if (role.equals("OWNER"))    roleClass = "role-owner";
						%>
							<tr>
								<td><span class="cell-id">#<%= u.getUserId() %></span></td>
								<td>
									<div class="user-cell">
										<div class="user-avatar">
											<%= u.getUsername().substring(0, 1).toUpperCase() %>
										</div>
										<span class="user-name"><%= u.getUsername() %></span>
									</div>
								</td>
								<td>
									<span class="cell-email">
										<i class="bi bi-envelope-fill"></i> <%= u.getEmail() %>
									</span>
								</td>
								<td><span class="role-badge <%= roleClass %>"><%= u.getRole() %></span></td>
								<td><span class="cell-date"><%= u.getCreatedDate() %></span></td>
							</tr>
						<% } %>
					<% } else { %>
						<tr>
							<td colspan="5" class="empty-row">
								<i class="bi bi-person-x"></i>
								<p>No users found.</p>
							</td>
						</tr>
					<% } %>
				</tbody>
			</table>
		</div>
	</div>

</div>

<%@ include file="../includes/footer.jsp" %>