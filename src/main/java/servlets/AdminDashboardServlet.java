package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

import dao.OrderTableDAO;
import dao.RestaurantDAO;
import dao.UserDAO;
import dao.impl.OrderTableDAOImpl;
import dao.impl.RestaurantDAOImpl;
import dao.impl.UserDAOImpl;
import entity.OrderTable;
import entity.User;


@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
	
	private UserDAO userDao;
	private OrderTableDAO orderTableDao;
	private RestaurantDAO restaurantDao;
	
	public void init() {
		userDao 	  = new UserDAOImpl();
		orderTableDao = new OrderTableDAOImpl();
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
		
		/* Fetch info form DB */
		int totalUsers = userDao.getAllUsers().size();
		int totalResaurantes = restaurantDao.getAllRestaurants().size();
		List<OrderTable> allOrders = orderTableDao.getAllOrders();
		int totalOrders = allOrders.size();
		double totalRevenue = 0;
		for(OrderTable order : allOrders) {
			if(order.getStatus() == OrderTable.Status.DELIVERED) {
				totalRevenue += (order.getTotalAmount()).doubleValue();
			}
		}
		System.out.println(totalRevenue);
		request.setAttribute("totalUsers", totalUsers);
		request.setAttribute("totalOrders", totalOrders);
		request.setAttribute("totalRevenue", totalRevenue);
		request.setAttribute("totalRestaurants", totalResaurantes);
		
		request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
		
	}

}
