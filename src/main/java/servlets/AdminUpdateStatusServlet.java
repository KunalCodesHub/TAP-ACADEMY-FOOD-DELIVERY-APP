package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import dao.OrderTableDAO;
import dao.impl.OrderTableDAOImpl;
import entity.OrderTable;
import entity.User;


@WebServlet("/admin/update-status")
public class AdminUpdateStatusServlet extends HttpServlet {
	
	private OrderTableDAO orderTableDao;
	
	public void init() {
		orderTableDao = new OrderTableDAOImpl();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* Auth Guard */
		HttpSession session = request.getSession(false);
		User user 			= (session != null) ? (User)session.getAttribute("loggedInUser") : null;
		/* Check user logged in or not */
		if (user == null || !user.getRole().equals("ADMIN")) { /* because user.getRole() return string */
			/* Redirect to home */
			response.sendRedirect(request.getContextPath() + "/home");
			return;
		}
		
		int orderId   = Integer.parseInt(request.getParameter("orderId"));
		String status =  request.getParameter("status");
		try {	
			int ok = orderTableDao.updateOrderStatus(orderId, OrderTable.Status.valueOf(status));
			if (ok == 0) {
				session.setAttribute("errorMsg", "Failed to update order status. Please try again.");
			} else {
				session.setAttribute("successMsg", "Order status updated successfully.");
			}
		} catch (IllegalArgumentException ex) {
			System.err.println(ex.getMessage());
			session.setAttribute("errorMsg", "Invalid order status selected.");
		} catch (Exception ex) {
			System.err.println(ex.getMessage());
			session.setAttribute("errorMsg", "Something went wrong while updating the order status.");
		}
		response.sendRedirect(request.getContextPath() + "/admin/orders");
	}

}
