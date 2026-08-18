<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.User, entity.CartItem" %>
<%@ page import="java.util.List" %>
<%
    /* Check if user is logged in */
    User loggedInUser = (session != null) ? (User) session.getAttribute("loggedInUser") : null;
    String loggedInUsername = (loggedInUser != null) ? loggedInUser.getUsername() : null;
    String userRole = (loggedInUser != null) ? loggedInUser.getRole() : null;
    List<CartItem> nevCartItems = (List<CartItem>)session.getAttribute("cartItems");
    int cartCount = 0;
    if (nevCartItems != null) {
    	cartCount = nevCartItems.size();
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>FoodExpress - Delicious Food Delivered</title>
    
    <!-- SweetAlert2 for beautiful popups -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<!-- ═══════════════════════════════════════════════
     DARK NAVBAR
═══════════════════════════════════════════════ -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top shadow-sm">
    <div class="container">
        
        <!-- Brand Logo -->
        <a class="navbar-brand fw-bold" href="<%= request.getContextPath() %>/home">
            <i class="bi bi-cup-hot-fill text-danger"></i>
            <span class="text-danger">Food</span>Express
        </a>
        
        <!-- Mobile toggle -->
        <button class="navbar-toggler" type="button" 
                data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            
            <!-- Nav Links -->
            <ul class="navbar-nav mx-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/home">
                        <i class="bi bi-house-fill"></i> Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/restaurants">
                        <i class="bi bi-shop"></i> Restaurants
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/about.jsp">
                        <i class="bi bi-info-circle"></i> About
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/contact">
                        <i class="bi bi-envelope"></i> Contact
                    </a>
                </li>
            </ul>
            
            <!-- Right side -->
            <div class="d-flex align-items-center gap-3">
                
                <!-- Cart Icon -->
                <a href="<%= request.getContextPath() %>/cart" 
                   class="text-white position-relative text-decoration-none">
                    <i class="bi bi-cart3 fs-4"></i>
                    <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" 
                          style="font-size: 0.65rem;">
                        <%= cartCount %>
                    </span>
                </a>
                
                <!-- ⭐ CONDITIONAL: Login OR User Dropdown ⭐ -->
                <% if (loggedInUser == null) { %>
                    
                    <!-- NOT LOGGED IN - Show Login/Signup buttons -->
                    <a href="<%= request.getContextPath() %>/login" 
                       class="btn btn-outline-light btn-sm">
                        <i class="bi bi-box-arrow-in-right"></i> Login
                    </a>
                    <a href="<%= request.getContextPath() %>/register" 
                       class="btn btn-danger btn-sm">
                        <i class="bi bi-person-plus"></i> Sign Up
                    </a>
                    
                <% } else { %>
                    
                    <!-- LOGGED IN - Show User Dropdown -->
                    <div class="dropdown">
                        <button class="btn btn-outline-danger btn-sm dropdown-toggle d-flex align-items-center gap-3" 
                                type="button"
                                data-bs-toggle="dropdown"
                                aria-expanded="false">
                            <i class="bi bi-person-circle"></i>
                            <span><%= loggedInUsername %></span>
                        </button>
                        <ul class="dropdown-menu dropdown-menu-end dropdown-menu-dark shadow">
                            <li>
                                <h6 class="dropdown-header">
                                    <i class="bi bi-person-fill me-1"></i> 
                                    Signed in as<br>
                                    <strong class="text-danger"><%= loggedInUsername %></strong>
                                </h6>
                            </li>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/profile">
                                    <i class="bi bi-person-badge me-2"></i> My Profile
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/my-orders">
                                    <i class="bi bi-bag-check me-2"></i> My Orders
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item" href="<%= request.getContextPath() %>/cart">
                                    <i class="bi bi-cart me-2"></i> My Cart
                                </a>
                            </li>
                            <% if ("ADMIN".equalsIgnoreCase(userRole)) { %>
                                <li><hr class="dropdown-divider"></li>
                                <li>
                                    <a class="dropdown-item" href="<%= request.getContextPath() %>/admin">
                                        <i class="bi bi-gear me-2"></i> Admin Panel
                                    </a>
                                </li>
                            <% } %>
                            <li><hr class="dropdown-divider"></li>
                            <li>
                                <a class="dropdown-item text-danger" 
                                   href="<%= request.getContextPath() %>/logout"
                                   onclick="return confirm('Are you sure you want to logout?')">
                                    <i class="bi bi-box-arrow-right me-2"></i> Logout
                                </a>
                            </li>
                        </ul>
                    </div>
                    
                <% } %>
                
            </div>
            
        </div>
    </div>
</nav>

<!-- ═══════════════════════════════════════════════
     Session Messages (login success/logout)
═══════════════════════════════════════════════ -->
<%
    String msg = request.getParameter("msg");
    if (msg != null) {
        String alertClass = "alert-success";
        String alertIcon = "bi-check-circle-fill";
        String alertText = "";
        
        switch (msg) {
            case "login_success":
                alertText = "Welcome back, " + loggedInUsername + "! 🎉";
                break;
            case "logout_success":
                alertText = "You've been logged out successfully. See you soon! 👋";
                alertClass = "alert-info";
                alertIcon = "bi-info-circle-fill";
                break;
            case "admin_login":
                alertText = "Welcome Admin! You have full access. 👑";
                break;
            case "register_success":
                alertText = "Account created successfully! Please login. ✨";
                break;
        }
        
        if (!alertText.isEmpty()) {
%>
    <div class="alert <%= alertClass %> alert-dismissible fade show m-0 rounded-0 text-center" role="alert">
        <i class="bi <%= alertIcon %> me-2"></i>
        <%= alertText %>
        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
    </div>
<%
        }
    }
%>