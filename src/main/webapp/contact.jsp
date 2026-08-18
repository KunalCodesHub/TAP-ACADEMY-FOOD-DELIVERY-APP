<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.User"%>
<%
	String ctx 		  = request.getContextPath();
	String successMsg = (String)request.getAttribute("successMsg");
	String errorMsg   = (String)request.getAttribute("errorMsg");
%>

<!-- HEADER JSP INCLUDE -->
<%@ include file="includes/header.jsp" %>
<!-- Style cart.css -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/contact.css">


<div class="container contact-wrapper">
	<div class="text-center">
        <i class="bi bi-headset contact-icon"></i>
        <h1 class="contact-title">Get in Touch</h1>
        <p class="contact-subtitle">We'd love to hear from you. Send us a message!</p>
    </div>
    
    <% if (successMsg != null) { %>
        <div class="contact-alert contact-alert-success">
            <i class="bi bi-check-circle-fill"></i> <%= successMsg %>
        </div>
    <% } %>
    <% if (errorMsg != null) { %>
        <div class="contact-alert contact-alert-error">
            <i class="bi bi-exclamation-triangle-fill"></i> <%= errorMsg %>
        </div>
    <% } %>
    <div class="row contact-row">
        <!-- LEFT: Info Cards -->
        <div class="col-md-5">
            <div class="contact-info-card">
                <div class="info-item">
                    <i class="bi bi-geo-alt-fill"></i>
                    <div>
                        <h6>Our Address</h6>
                        <p>123 Food Street, Portland, OR 97201</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="bi bi-telephone-fill"></i>
                    <div>
                        <h6>Call Us</h6>
                        <p>+1 (555) 123-4567</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="bi bi-envelope-fill"></i>
                    <div>
                        <h6>Email Us</h6>
                        <p>support@foodexpress.com</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="bi bi-clock-fill"></i>
                    <div>
                        <h6>Working Hours</h6>
                        <p>Mon–Sun: 9 AM – 11 PM</p>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- RIGHT: Contact Form -->
        <div class="col-md-7">
            <form action="<%= ctx %>/contact" method="POST" class="contact-form">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Name" required>

                <label>Email Address</label>
                <input type="email" name="email" placeholder="Email" required>

                <label>Subject</label>
                <input type="text" name="subject" placeholder="How can we help?" required>

                <label>Message</label>
                <textarea name="message" rows="5" placeholder="Write your message here..." required></textarea>

                <button type="submit" class="btn btn-danger contact-submit-btn">
                    <i class="bi bi-send-fill"></i> Send Message
                </button>
            </form>
        </div>
    </div>
</div>

<!-- FOOTER JSP INCLUDE -->
<%@ include file="includes/footer.jsp" %>