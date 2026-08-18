package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private UserDAO userDAO;
	
	public void init() {
		userDAO = new UserDAOImpl();
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// If already logged in. redirect to home
		HttpSession session = request.getSession();
		if (session != null && session.getAttribute("loggedInUser") != null) {
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		
		// remember me
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("rememberedUser".equals(cookie.getName())) {
					request.setAttribute("rememberedUsername", cookie.getValue());
					break;
				}
			}
		}
		
		//success message
		String msg = request.getParameter("msg");
	    if ("register_success".equals(msg)) {
	        String username = request.getParameter("username");
	        request.setAttribute("success", 
	            "🎉 Registration successful! Welcome " + username + "! Please login to continue.");
	        // Pre-fill username
	        if (username != null) {
	            request.setAttribute("enteredUsername", username);
	        }
	    }
		
		// Forward to login.jsp
		request.getRequestDispatcher("/login.jsp").forward(request,response);
	}

	
	// Process login form
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// From data
		String usernameOrEmail = request.getParameter("username");
		String password        = request.getParameter("password");
		String rememberMe	   = request.getParameter("remeberMe");
		String redirectUrl     = request.getParameter("redirect");
		
		System.out.println("Login attempt: " + usernameOrEmail);
		
		// Validation
		if (usernameOrEmail == null || usernameOrEmail.trim().isEmpty() || password == null || password.trim().isEmpty()) {
			// login failed
			request.setAttribute("error", "Invalid username/email or password!");
            request.setAttribute("enteredUsername", usernameOrEmail);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
		}
		
		User user = userDAO.validateUser(usernameOrEmail.trim(), password);
		        
		 if (user == null) {
		 	// Login failed
		 	request.setAttribute("error", "Invalid username/email or password!");
		 	request.setAttribute("enteredUsername", usernameOrEmail);
		 	request.getRequestDispatcher("/login.jsp").forward(request, response);
		 	return;
		 }
		
		// if login success full - create session
		HttpSession session = request.getSession(true);
	    session.setAttribute("loggedInUser", user);
	    session.setAttribute("userId",       user.getUserId());
	    session.setAttribute("username",     user.getUsername());
	    session.setAttribute("userRole",     user.getRole());
		
	    // Session timeout : 30 min
	    session.setMaxInactiveInterval(30 * 60);
	    
	    // remebet me
	    if ("on".equals(rememberMe) || "true".equals(rememberMe)) {

            Cookie userCookie = new Cookie("rememberedUser", usernameOrEmail);

            userCookie.setMaxAge(7 * 24 * 60 * 60);   // 7 days

            userCookie.setPath("/");

            response.addCookie(userCookie);

        } else {

            // Clear cookie if unchecked

            Cookie clearCookie = new Cookie("rememberedUser", "");

            clearCookie.setMaxAge(0);

            clearCookie.setPath("/");

            response.addCookie(clearCookie);

        }
	    
	    System.out.println("User logged in: " + user.getUsername() + " (Role: " + user.getRole() + ")");
	    
	    if (redirectUrl != null && !redirectUrl.trim().isEmpty()) {
            response.sendRedirect(redirectUrl);
        } else if ("ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home?msg=admin_login");
        } else {
            response.sendRedirect(request.getContextPath() + "/home?msg=login_success");
        }
	}

}
