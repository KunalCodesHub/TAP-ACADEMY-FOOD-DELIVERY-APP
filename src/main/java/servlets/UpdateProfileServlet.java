package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;
import entity.User.Role;


@WebServlet("/update-profile")
public class UpdateProfileServlet extends HttpServlet {
	
	private UserDAO userDao;
	
	public void init() {
		userDao = new UserDAOImpl();
	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 
		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User)session.getAttribute("loggedInUser") : null;
		if (user == null) {
			String returnUrl = request.getContextPath()+"/update-profile";
			String encode = java.net.URLEncoder.encode(returnUrl, "UTF-8");
			response.sendRedirect(request.getContextPath()+"/login?redirect="+encode);
			return;
		}
		
		 String username = request.getParameter("name");
		 String password = request.getParameter("password");
		 String email 	 = request.getParameter("email");
		 String address  = request.getParameter("address");
		 
		 if(username == null || email == null || address == null ||
			username.trim().isEmpty() || email.trim().isEmpty() || address.trim().isEmpty()) {
			 request.setAttribute("errorMsg",  "All fields are required");
			 request.getRequestDispatcher("/profile.jsp").forward(request, response);
			 return;
		 }
		 
		 User update_user = new User();
		 update_user.setUserId(user.getUserId());
		 update_user.setUsername(username);
		 update_user.setPassword((password != null && !password.trim().isEmpty()) ? password : user.getPassword());
		 update_user.setEmail(email);
		 update_user.setAddress(address);
		 update_user.setRole(Role.valueOf(user.getRole()));
		 
		 boolean ok = (userDao.updateUser(update_user) != 0);
		 if (!ok) {
			 request.setAttribute("errorMsg", "Update failed. Try again.");
			 request.getRequestDispatcher("/profile.jsp").forward(request, response);
			 return;
		 }
		 session.setAttribute("loggedInUser", update_user);
		 session.setAttribute("successMsg", "User data updated successfully!");
		 
		 response.sendRedirect(request.getContextPath() + "/profile");
		
	}

}
