package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import dao.RestaurantDAO;
import dao.impl.RestaurantDAOImpl;
import entity.Restaurant;
import entity.User;


@WebServlet("/admin/restaurants")
public class AdminRestaurantsServlet extends HttpServlet {
	
	private RestaurantDAO restaurantDao;
	
	public void init() {
		restaurantDao = new RestaurantDAOImpl();
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
		
		/* get all restaurants */
		List<Restaurant> restaurants = restaurantDao.getAllRestaurants();
		
		/* set in request */
		request.setAttribute("restaurants", restaurants);
		
		/* forward to /admin/restaurant.jsp */
		request.getRequestDispatcher("/admin/restaurants.jsp").forward(request, response);
		
	}

}
