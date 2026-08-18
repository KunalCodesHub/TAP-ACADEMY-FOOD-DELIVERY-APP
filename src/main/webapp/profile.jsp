<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.User" %>

<%
	User user 		  = (User)request.getAttribute("user");
	String successMsg = (String)request.getAttribute("successMsg");
	String errorMsg	  = (String)request.getAttribute("errorMsg");
%>
    
<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp" %>
<!-- Style cart.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/profile.css">

<div class="container profile-wrapper">

	<div class="text-center profile-header">
		<i class="bi bi-person-circle profile-icon"></i>
		<h1 class="profile-title">My Profile</h1>
		<p class="profile-subtitle">Manage your account information</p>
	</div>

	<% if (successMsg != null) { %>
		<div class="profile-alert profile-alert-success">
			<i class="bi bi-check-circle-fill"></i> <%= successMsg %>
		</div>
	<% } %>

	<% if (errorMsg != null) { %>
		<div class="profile-alert profile-alert-error">
			<i class="bi bi-exclamation-triangle-fill"></i> <%= errorMsg %>
		</div>
	<% } %>

	<div class="row profile-row">
		<!-- LEFT: Profile Info -->
		<div class="col-md-5">
			<div class="profile-card info-card">
				<div class="card-body">
					<h4 class="card-heading">
						<i class="bi bi-person-badge-fill"></i> Account Info
					</h4>

					<div class="info-item">
						<i class="bi bi-person-fill"></i>
						<div>
							<span class="info-label">Username</span>
							<span class="info-value"><%= user.getUsername() %></span>
						</div>
					</div>

					<div class="info-item">
						<i class="bi bi-envelope-fill"></i>
						<div>
							<span class="info-label">Email</span>
							<span class="info-value"><%= user.getEmail() %></span>
						</div>
					</div>

					<div class="info-item">
						<i class="bi bi-geo-alt-fill"></i>
						<div>
							<span class="info-label">Address</span>
							<span class="info-value"><%= user.getAddress() %></span>
						</div>
					</div>

					<div class="info-item">
						<i class="bi bi-shield-fill-check"></i>
						<div>
							<span class="info-label">Role</span>
							<span class="info-value role-badge"><%= user.getRole() %></span>
						</div>
					</div>

					<div class="info-item">
						<i class="bi bi-calendar-event-fill"></i>
						<div>
							<span class="info-label">Joined</span>
							<span class="info-value"><%= user.getCreatedDate() %></span>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- RIGHT: Edit Form -->
		<div class="col-md-7">
			<div class="profile-card edit-card">
				<div class="card-body">
					<h4 class="card-heading">
						<i class="bi bi-pencil-square"></i> Edit Profile
					</h4>

					<form action="<%= request.getContextPath() %>/update-profile" method="post" class="profile-form">

						<label>Username</label>
						<input type="text" name="name" value="<%= user.getUsername() %>" required>

						<label>Email</label>
						<input type="email" name="email" value="<%= user.getEmail() %>" required>

						<label>Address</label>
						<textarea name="address" rows="3" required><%= user.getAddress() %></textarea>

						<label>New Password <span class="label-hint">(leave blank to keep current)</span></label>
						<input type="password" name="password" placeholder="Enter new password">

						<button type="submit" class="btn btn-danger profile-submit-btn">
							<i class="bi bi-check2-circle"></i> Update Profile
						</button>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>