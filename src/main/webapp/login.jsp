<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* Get error/success messages from request attributes */
    String error = (String) request.getAttribute("error");
    String success = (String) request.getAttribute("success");
    String enteredUsername = (String) request.getAttribute("enteredUsername");
    String rememberedUsername = (String) request.getAttribute("rememberedUsername");
    
    /* Priority: entered username > remembered > empty */
    String usernameValue = "";
    if (enteredUsername != null) {
        usernameValue = enteredUsername;
    } else if (rememberedUsername != null) {
        usernameValue = rememberedUsername;
    }
    
    /* Check if there's a redirect URL (e.g., from cart page) */
    String redirectUrl = request.getParameter("redirect");
    if (redirectUrl == null) redirectUrl = "";
    
    /* Context path */
    String ctx = request.getContextPath();
%>

<link rel="Stylesheet" href="<%= ctx%>/css/login.css"/>
	<!-- HEADER --> 
    <%@ include file="includes/header.jsp" %>

    <!-- LOGIN SECTION -->
    <section class="login-wrapper">
        <div class="login-card">
            
            <!-- LEFT SIDE - Branding -->
            <div class="login-brand-side">
                
                <div class="brand-logo">
                    <i class="bi bi-cup-hot-fill"></i>
                    <span>FoodExpress</span>
                </div>
                
                <h2 class="brand-tagline">
                    Delicious Food<br>Delivered Fast
                </h2>
                
                <p class="brand-description">
                    Login to explore thousands of restaurants and get your favorite meals delivered to your doorstep!
                </p>
                
                <div class="brand-features">
                    <div class="feature-item">
                        <i class="bi bi-lightning-charge-fill"></i>
                        <span>30-min express delivery</span>
                    </div>
                    <div class="feature-item">
                        <i class="bi bi-shield-check"></i>
                        <span>Secure & safe payments</span>
                    </div>
                    <div class="feature-item">
                        <i class="bi bi-percent"></i>
                        <span>Exclusive member offers</span>
                    </div>
                    <div class="feature-item">
                        <i class="bi bi-headset"></i>
                        <span>24/7 customer support</span>
                    </div>
                </div>
                
            </div>
            
            <!-- RIGHT SIDE - Login Form -->
            <div class="login-form-side">
                
                <div class="form-header">
                    <h1 class="form-title">Welcome Back! 👋</h1>
                    <p class="form-subtitle">Login to your account to continue</p>
                </div>
                
                <!-- Error message -->
                <% if (error != null) { %>
                    <div class="alert-custom alert-error">
                        <i class="bi bi-exclamation-circle-fill"></i>
                        <span><%= error %></span>
                    </div>
                <% } %>
                
                <!-- Success message -->
                <% if (success != null) { %>
                    <div class="alert-custom alert-success">
                        <i class="bi bi-check-circle-fill"></i>
                        <span><%= success %></span>
                    </div>
                <% } %>
                
                <!-- Login Form -->
                <form method="POST" action="<%= ctx %>/login" id="loginForm">
                    
                    <!-- Hidden redirect URL -->
                    <input type="hidden" name="redirect" value="<%= redirectUrl %>">
                    
                    <!-- Username/Email -->
                    <div class="form-group-custom">
                        <label class="form-label-custom" for="username">
                            USERNAME OR EMAIL
                        </label>
                        <div class="input-wrapper">
                            <i class="bi bi-person-fill input-icon"></i>
                            <input type="text"
                                   id="username"
                                   name="username"
                                   class="form-input-custom"
                                   placeholder="Enter your username or email"
                                   value="<%= usernameValue %>"
                                   required
                                   autofocus>
                        </div>
                    </div>
                    
                    <!-- Password -->
                    <div class="form-group-custom">
                        <label class="form-label-custom" for="password">
                            PASSWORD
                        </label>
                        <div class="input-wrapper">
                            <i class="bi bi-lock-fill input-icon"></i>
                            <input type="password"
                                   id="password"
                                   name="password"
                                   class="form-input-custom"
                                   placeholder="Enter your password"
                                   required
                                   style="padding-right: 45px;">
                            <button type="button"
                                    class="password-toggle"
                                    onclick="togglePassword()"
                                    id="togglePwdBtn"
                                    title="Show/Hide Password">
                                <i class="bi bi-eye" id="eyeIcon"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Remember me + Forgot -->
                    <div class="form-options">
                        <label class="remember-me">
                            <input type="checkbox" name="rememberMe" 
                                   <%= rememberedUsername != null ? "checked" : "" %>>
                            <span>Remember me</span>
                        </label>
                        
                        <a href="#" class="forgot-link" 
                           onclick="alert('Password reset feature coming soon!'); return false;">
                            Forgot password?
                        </a>
                    </div>
                    
                    <!-- Login Button -->
                    <button type="submit" class="btn-login">
                        <i class="bi bi-box-arrow-in-right"></i>
                        <span>Sign In</span>
                    </button>
                    
                </form>
                
                <!-- Divider -->
                <div class="divider">
                    <span>OR</span>
                </div>
                
                <!-- Signup prompt -->
                <div class="signup-prompt">
                    Don't have an account? 
                    <a href="<%= ctx %>/register">Create Account</a>
                </div>
                
                <!-- Demo credentials (remove in production) -->
                <div class="demo-info">
                    <strong>💡 Demo Credentials:</strong><br>
                    Username: <code>john_doe</code> | Password: <code>pass123</code>
                    <br><small style="opacity:0.8">(Or any user from your database)</small>
                </div>
                
            </div>
            
        </div>
    </section>

    <!-- FOOTER -->
    <%@ include file="includes/footer.jsp" %>

    <!-- SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        /* Toggle password visibility */
        function togglePassword() {
            const pwdField = document.getElementById('password');
            const eyeIcon = document.getElementById('eyeIcon');
            
            if (pwdField.type === 'password') {
                pwdField.type = 'text';
                eyeIcon.className = 'bi bi-eye-slash';
            } else {
                pwdField.type = 'password';
                eyeIcon.className = 'bi bi-eye';
            }
        }
        
        /* Form validation before submit */
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value.trim();
            
            if (username === '' || password === '') {
                e.preventDefault();
                alert('Please fill in all fields!');
                return false;
            }
            
            /* Show loading state on button */
            const btn = document.querySelector('.btn-login');
            btn.innerHTML = '<i class="bi bi-hourglass-split"></i> <span>Signing in...</span>';
            btn.disabled = true;
        });
    </script>

