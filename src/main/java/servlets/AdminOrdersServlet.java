package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import dao.OrderTableDAO;
import dao.impl.OrderTableDAOImpl;
import entity.OrderTable;
import entity.User;


@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {
	
	private OrderTableDAO orderTableDao;
	
	public void init() {
		orderTableDao = new OrderTableDAOImpl();
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
		
		/* Get all Orders */
		List<OrderTable> orders = orderTableDao.getAllOrders();
		
		/* Setting request */
		request.setAttribute("orders", orders);
		
		/* Forward request */
		request.getRequestDispatcher("/admin/orders.jsp").forward(request, response);
		
	}
}
