package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;


@WebServlet("/admin/users")
public class AdminUsersServlet extends HttpServlet {
	
	private UserDAO userDao;
	
	public void init() {
		userDao = new UserDAOImpl();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* Auth Guard */
		HttpSession session = request.getSession(false);
		User user 			= (session != null) ? (User)session.getAttribute("loggedInUser") : null;
		/* Check user logged in or not */
		if (user == null || !user.getRole().equals("ADMIN")) { /* because user.getRole() return string */
			/* Redirect to home */
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		
		/* Get all the users */
		List<User> users = userDao.getAllUsers();
		
		/* set users in request */
		request.setAttribute("users", users);
		
		/* forward to /admin/user.jap */
		request.getRequestDispatcher("/admin/users.jsp").forward(request, response);
	}

}
