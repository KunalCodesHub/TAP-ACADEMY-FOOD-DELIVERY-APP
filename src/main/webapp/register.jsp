<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    /* Get error message and preserved form values */
    String error = (String) request.getAttribute("error");
    String enteredUsername = (String) request.getAttribute("enteredUsername");
    String enteredEmail    = (String) request.getAttribute("enteredEmail");
    String enteredAddress  = (String) request.getAttribute("enteredAddress");
    
    if (enteredUsername == null) enteredUsername = "";
    if (enteredEmail == null)    enteredEmail = "";
    if (enteredAddress == null)  enteredAddress = "";
    
    String ctx = request.getContextPath();
%>

    <link rel="stylesheet" href="<%= ctx %>/css/register.css">


    <!-- HEADER -->
    <%@ include file="includes/header.jsp" %>

    <!-- ═══════════════════════════════════════════════
         REGISTER SECTION
    ═══════════════════════════════════════════════ -->
    <section class="register-wrapper">
        <div class="register-card">
            
            <!-- ══════════════════════════════════════
                 LEFT - Branding
            ══════════════════════════════════════ -->
            <div class="register-brand-side">
                
                <div class="brand-logo-register">
                    <i class="bi bi-cup-hot-fill"></i>
                    <span>FoodExpress</span>
                </div>
                
                <h2 class="welcome-heading">Join the Foodie<br>Community! 🎉</h2>
                
                <p class="welcome-text">
                    Create your account and unlock a world of delicious meals delivered fast to your doorstep.
                </p>
                
                <div class="benefits-list">
                    <div class="benefit-item">
                        <div class="benefit-icon-wrap"><i class="bi bi-gift-fill"></i></div>
                        <span>Free delivery on first order</span>
                    </div>
                    <div class="benefit-item">
                        <div class="benefit-icon-wrap"><i class="bi bi-star-fill"></i></div>
                        <span>Exclusive member discounts</span>
                    </div>
                    <div class="benefit-item">
                        <div class="benefit-icon-wrap"><i class="bi bi-clock-history"></i></div>
                        <span>Save favorite orders</span>
                    </div>
                    <div class="benefit-item">
                        <div class="benefit-icon-wrap"><i class="bi bi-truck"></i></div>
                        <span>Real-time order tracking</span>
                    </div>
                </div>
                
            </div>
            
            <!-- ══════════════════════════════════════
                 RIGHT - Registration Form
            ══════════════════════════════════════ -->
            <div class="register-form-side">
                
                <div class="form-header-register">
                    <h1 class="form-title-register">Create Account ✨</h1>
                    <p class="form-subtitle-register">Fill in your details to get started</p>
                </div>
                
                <!-- Error alert -->
                <% if (error != null) { %>
                    <div class="alert-register alert-error-register">
                        <i class="bi bi-exclamation-circle-fill"></i>
                        <span><%= error %></span>
                    </div>
                <% } %>
                
                <!-- Registration Form -->
                <form method="POST" action="<%= ctx %>/register" id="registerForm">
                    
                    <!-- Username & Email in same row -->
                    <div class="form-row">
                        
                        <!-- Username -->
                        <div class="form-group-reg">
                            <label class="form-label-reg" for="username">
                                USERNAME <span class="required">*</span>
                            </label>
                            <div class="input-wrapper-reg">
                                <input type="text"
                                       id="username"
                                       name="username"
                                       class="form-input-reg"
                                       placeholder="e.g., john_doe"
                                       value="<%= enteredUsername %>"
                                       required
                                       minlength="3"
                                       maxlength="20"
                                       pattern="[A-Za-z0-9_]{3,20}">
                                <i class="bi bi-person-fill input-icon-reg"></i>
                                <i class="bi bi-check-circle-fill field-status" id="usernameStatus"></i>
                            </div>
                            <div class="field-hint">3-20 chars, letters/numbers/underscore</div>
                        </div>
                        
                        <!-- Email -->
                        <div class="form-group-reg">
                            <label class="form-label-reg" for="email">
                                EMAIL <span class="required">*</span>
                            </label>
                            <div class="input-wrapper-reg">
                                <input type="email"
                                       id="email"
                                       name="email"
                                       class="form-input-reg"
                                       placeholder="your@email.com"
                                       value="<%= enteredEmail %>"
                                       required>
                                <i class="bi bi-envelope-fill input-icon-reg"></i>
                                <i class="bi bi-check-circle-fill field-status" id="emailStatus"></i>
                            </div>
                            <div class="field-hint">We'll never share your email</div>
                        </div>
                        
                    </div>
                    
                    <!-- Password & Confirm in same row -->
                    <div class="form-row">
                        
                        <!-- Password -->
                        <div class="form-group-reg">
                            <label class="form-label-reg" for="password">
                                PASSWORD <span class="required">*</span>
                            </label>
                            <div class="input-wrapper-reg">
                                <input type="password"
                                       id="password"
                                       name="password"
                                       class="form-input-reg"
                                       placeholder="Min 6 characters"
                                       required
                                       minlength="6"
                                       style="padding-right: 40px;">
                                <i class="bi bi-lock-fill input-icon-reg"></i>
                                <button type="button" 
                                        class="pwd-toggle-reg" 
                                        onclick="togglePwd('password', 'eyeIcon1')">
                                    <i class="bi bi-eye" id="eyeIcon1"></i>
                                </button>
                            </div>
                            <!-- Password strength meter -->
                            <div class="pwd-strength-container">
                                <div class="pwd-strength-bar" id="pwdBar"></div>
                            </div>
                            <div class="pwd-strength-text" id="pwdText">Password strength</div>
                        </div>
                        
                        <!-- Confirm Password -->
                        <div class="form-group-reg">
                            <label class="form-label-reg" for="confirmPassword">
                                CONFIRM PASSWORD <span class="required">*</span>
                            </label>
                            <div class="input-wrapper-reg">
                                <input type="password"
                                       id="confirmPassword"
                                       name="confirmPassword"
                                       class="form-input-reg"
                                       placeholder="Re-enter password"
                                       required
                                       minlength="6"
                                       style="padding-right: 40px;">
                                <i class="bi bi-shield-lock-fill input-icon-reg"></i>
                                <button type="button" 
                                        class="pwd-toggle-reg" 
                                        onclick="togglePwd('confirmPassword', 'eyeIcon2')">
                                    <i class="bi bi-eye" id="eyeIcon2"></i>
                                </button>
                            </div>
                            <div class="field-hint" id="matchText">Passwords must match</div>
                        </div>
                        
                    </div>
                    
                    <!-- Address (full width) -->
                    <div class="form-group-reg">
                        <label class="form-label-reg" for="address">
                            DELIVERY ADDRESS <span class="required">*</span>
                        </label>
                        <div class="input-wrapper-reg">
                            <textarea id="address"
                                      name="address"
                                      class="form-input-reg"
                                      placeholder="Enter your full delivery address..."
                                      rows="2"
                                      required
                                      maxlength="255"><%= enteredAddress %></textarea>
                            <i class="bi bi-geo-alt-fill input-icon-reg"></i>
                        </div>
                        <div class="field-hint">Where should we deliver your orders?</div>
                    </div>
                    
                    <!-- Terms & Conditions -->
                    <div class="terms-wrapper">
                        <input type="checkbox" id="terms" name="terms" required>
                        <label for="terms">
                            I agree to the <a href="#" onclick="alert('Terms coming soon!'); return false;">Terms & Conditions</a> 
                            and <a href="#" onclick="alert('Privacy Policy coming soon!'); return false;">Privacy Policy</a>. 
                            I confirm I'm at least 18 years old.
                        </label>
                    </div>
                    
                    <!-- Register Button -->
                    <button type="submit" class="btn-register" id="submitBtn">
                        <i class="bi bi-person-check-fill"></i>
                        <span>Create My Account</span>
                    </button>
                    
                </form>
                
                <!-- Login link -->
                <div class="login-prompt">
                    Already have an account? 
                    <a href="<%= ctx %>/login">Sign In Instead</a>
                </div>
                
            </div>
            
        </div>
    </section>

    <!-- FOOTER -->
    <%@ include file="includes/footer.jsp" %>

    <!-- SCRIPTS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        /* ═══════════════════════════════════════════════
           Toggle password visibility
        ═══════════════════════════════════════════════ */
        function togglePwd(fieldId, iconId) {
            const field = document.getElementById(fieldId);
            const icon = document.getElementById(iconId);
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.className = 'bi bi-eye-slash';
            } else {
                field.type = 'password';
                icon.className = 'bi bi-eye';
            }
        }
        
        /* ═══════════════════════════════════════════════
           Username validation (real-time)
        ═══════════════════════════════════════════════ */
        const usernameInput = document.getElementById('username');
        const usernameStatus = document.getElementById('usernameStatus');
        const usernameRegex = /^[A-Za-z0-9_]{3,20}$/;
        
        usernameInput.addEventListener('input', function() {
            const val = this.value.trim();
            if (val === '') {
                usernameStatus.className = 'bi field-status';
                return;
            }
            
            if (usernameRegex.test(val)) {
                usernameStatus.className = 'bi bi-check-circle-fill field-status valid';
            } else {
                usernameStatus.className = 'bi bi-x-circle-fill field-status invalid';
            }
        });
        
        /* ═══════════════════════════════════════════════
           Email validation (real-time)
        ═══════════════════════════════════════════════ */
        const emailInput = document.getElementById('email');
        const emailStatus = document.getElementById('emailStatus');
        const emailRegex = /^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
        
        emailInput.addEventListener('input', function() {
            const val = this.value.trim();
            if (val === '') {
                emailStatus.className = 'bi field-status';
                return;
            }
            
            if (emailRegex.test(val)) {
                emailStatus.className = 'bi bi-check-circle-fill field-status valid';
            } else {
                emailStatus.className = 'bi bi-x-circle-fill field-status invalid';
            }
        });
        
        /* ═══════════════════════════════════════════════
           Password strength meter
        ═══════════════════════════════════════════════ */
        const pwdInput = document.getElementById('password');
        const pwdBar = document.getElementById('pwdBar');
        const pwdText = document.getElementById('pwdText');
        
        pwdInput.addEventListener('input', function() {
            const pwd = this.value;
            let strength = 0;
            
            if (pwd.length >= 6) strength++;
            if (pwd.length >= 10) strength++;
            if (/[A-Z]/.test(pwd) && /[a-z]/.test(pwd)) strength++;
            if (/\d/.test(pwd)) strength++;
            if (/[^A-Za-z0-9]/.test(pwd)) strength++;
            
            pwdBar.className = 'pwd-strength-bar';
            pwdText.className = 'pwd-strength-text';
            
            if (pwd.length === 0) {
                pwdText.textContent = 'Password strength';
            } else if (strength <= 2) {
                pwdBar.classList.add('weak');
                pwdText.classList.add('weak');
                pwdText.textContent = '⚠️ Weak password';
            } else if (strength <= 3) {
                pwdBar.classList.add('medium');
                pwdText.classList.add('medium');
                pwdText.textContent = '👍 Medium strength';
            } else {
                pwdBar.classList.add('strong');
                pwdText.classList.add('strong');
                pwdText.textContent = '💪 Strong password';
            }
            
            /* Also check confirm password match */
            checkPasswordMatch();
        });
        
        /* ═══════════════════════════════════════════════
           Confirm password match check
        ═══════════════════════════════════════════════ */
        const confirmInput = document.getElementById('confirmPassword');
        const matchText = document.getElementById('matchText');
        
        function checkPasswordMatch() {
            const pwd = pwdInput.value;
            const confirm = confirmInput.value;
            
            if (confirm === '') {
                matchText.textContent = 'Passwords must match';
                matchText.style.color = '#6c757d';
                return;
            }
            
            if (pwd === confirm) {
                matchText.textContent = '✅ Passwords match!';
                matchText.style.color = '#75d99e';
            } else {
                matchText.textContent = '❌ Passwords do not match';
                matchText.style.color = '#ff6b7a';
            }
        }
        
        confirmInput.addEventListener('input', checkPasswordMatch);
        
        /* ═══════════════════════════════════════════════
           Form submit validation
        ═══════════════════════════════════════════════ */
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const pwd = pwdInput.value;
            const confirm = confirmInput.value;
            const terms = document.getElementById('terms').checked;
            
            if (pwd !== confirm) {
                e.preventDefault();
                alert('❌ Passwords do not match!');
                return false;
            }
            
            if (pwd.length < 6) {
                e.preventDefault();
                alert('❌ Password must be at least 6 characters!');
                return false;
            }
            
            if (!terms) {
                e.preventDefault();
                alert('❌ Please accept the Terms & Conditions!');
                return false;
            }
            
            /* Show loading state */
            const btn = document.getElementById('submitBtn');
            btn.innerHTML = '<i class="bi bi-hourglass-split"></i> <span>Creating account...</span>';
            btn.disabled = true;
        });
    </script>
