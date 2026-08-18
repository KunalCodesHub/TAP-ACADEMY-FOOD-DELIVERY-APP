package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.regex.Pattern;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import entity.User.Role;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private UserDAO userDAO;
    
    // Email regex pattern
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");
    // Username regex: 3-20 chars, letters/numbers/underscore
    private static final Pattern USERNAME_PATTERN = Pattern.compile("^[A-Za-z0-9_]{3,20}$");
	
    public void inti() throws ServletException {
    	userDAO = new UserDAOImpl();
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// redirect to home if already account created
		HttpSession exitingSession = request.getSession(false);
		if (exitingSession != null && exitingSession.getAttribute("loggedInUser") != null) {
	            response.sendRedirect(request.getContextPath() + "/home");
	            return;
		}
		
		// If account not created
		request.getRequestDispatcher("/register.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// Fetch from data
		String username        = request.getParameter("username");
        String email           = request.getParameter("email");
        String password        = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String address         = request.getParameter("address");
        String terms           = request.getParameter("terms");
        
        System.out.println("Registration for: " + username + " | " + email);
        
        // Preserve form value if error!
        request.setAttribute("enteredUsername", username);
        request.setAttribute("enteredEmail", email);
        request.setAttribute("enteredAddress", address);
        
     // Check 1: All required fields present
        if (isEmpty(username) || isEmpty(email) || isEmpty(password) || isEmpty(confirmPassword) || isEmpty(address)) {
            
            request.setAttribute("error", "Please fill in all required fields!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Trim inputs
        username = username.trim();
        email    = email.trim().toLowerCase();
        address  = address.trim();
        
        // Check 2: Username format (3-20 chars, alphanumeric + underscore)
        if (!USERNAME_PATTERN.matcher(username).matches()) {
            request.setAttribute("error", "Username must be 3-20 characters (letters, numbers, underscore only)");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check 3: Email format
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            request.setAttribute("error", "Please enter a valid email address!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check 4: Password strength (min 6 chars)
        if (password.length() < 6) {
            request.setAttribute("error", "Password must be at least 6 characters long!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check 5: Password matches
        if (!confirmPassword.equals(password)) {
        	request.setAttribute("error", "Passwords do not match!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check 6: Terms & Conditions accepted
        if (!"on".equals(terms) && !"true".equals(terms)) {
            request.setAttribute("error", "Please accept the Terms & Conditions!");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check 7: Username uniqueness
        if (userDAO.isUsernameExists(username)) {
            request.setAttribute("error", "Username '" + username + "' is already taken. Please choose another.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check 8: Email uniqueness
        if (userDAO.isEmailExists(email)) {
            request.setAttribute("error", "Email '" + email + "' is already registered. Please login instead.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Register user
        User newUser = new User();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(password);       
        newUser.setAddress(address);
        newUser.setRole(Role.valueOf("CUSTOMER")); // Convert Sting to enum
        
        boolean success = userDAO.registerUser(newUser);
        
        if (success) {
            System.out.println("User registered: " + username);
            // Redirect to login with success message
            response.sendRedirect(request.getContextPath() + "/login?msg=register_success&username=" + username);
        } else {
            System.err.println("Registration failed for: " + username);
            request.setAttribute("error", "Something went wrong. Please try again later.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
	}
	

	private boolean isEmpty(String str) {
		if (str == null || str.trim().isEmpty()) {
			return true;
		}
		return false;
	}

	
}
