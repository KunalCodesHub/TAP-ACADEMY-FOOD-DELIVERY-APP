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


@WebServlet("/my-orders")
public class OrderHistoryServlet extends HttpServlet {
	
	private OrderTableDAO orderTableDAO;
	
	public void init() {
		orderTableDAO = new OrderTableDAOImpl();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null) {
			String returnUrl = request.getContextPath()+"/my-orders";
			String encode = java.net.URLEncoder.encode(returnUrl, "UTF-8");
			response.sendRedirect(request.getContextPath()+"/login?redirect="+encode);
			return;
		}
		
		// Get user-id from session
		int userId = ((User)session.getAttribute("loggedInUser")).getUserId();
		
		// Get orders by user id
		List<OrderTable> ordersByUserId = orderTableDAO.getOrdersByUserId(userId);
		System.out.println(ordersByUserId);
		request.setAttribute("orders", ordersByUserId);
		request.getRequestDispatcher("/myOrders.jsp").forward(request, response);
		return;
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}

}
