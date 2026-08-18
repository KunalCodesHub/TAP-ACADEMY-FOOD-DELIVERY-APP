package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.mysql.cj.Session;

import dao.UserDAO;
import dao.impl.UserDAOImpl;
import entity.User;


@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
	
	private UserDAO userDao;
	
	public void init() {
		userDao = new UserDAOImpl();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User)session.getAttribute("loggedInUser") : null;
		if (user == null) {
			String returnUrl = request.getContextPath()+"/profile";
			String encode = java.net.URLEncoder.encode(returnUrl, "UTF-8");
			response.sendRedirect(request.getContextPath()+"/login?redirect="+encode);
			return;
		}
		
		String msg = (String)session.getAttribute("successMsg");
		if (msg != null) {
			request.setAttribute("successMsg", msg);
		    session.removeAttribute("successMsg");
		}
		
		// Get user details by Id
		User getUser = userDao.getUserById(user.getUserId());
		request.setAttribute("user", getUser);
		request.getRequestDispatcher("profile.jsp").forward(request, response);
	}

}
