package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import dao.MenuDAO;
import dao.OrderItemDAO;
import dao.OrderTableDAO;
import dao.RestaurantDAO;
import dao.impl.MenuDAOImpl;
import dao.impl.OrderItemDAOImpl;
import dao.impl.OrderTableDAOImpl;
import dao.impl.RestaurantDAOImpl;
import entity.Menu;
import entity.OrderItem;
import entity.OrderTable;
import entity.Restaurant;


@WebServlet("/OrderConfirmation")
public class OrderConfirmation extends HttpServlet {
	
	private OrderItemDAO orderItemDAO;
	private OrderTableDAO orderTableDAO;
	private RestaurantDAO restaurantDAO;
	private MenuDAO menuDAO;
	
	public void init() {
		orderItemDAO  = new OrderItemDAOImpl();
		orderTableDAO = new OrderTableDAOImpl();
		restaurantDAO = new RestaurantDAOImpl();
		menuDAO 	  = new MenuDAOImpl();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/* Check only existing session don't create new one */
		HttpSession session = request.getSession(false);
		
		/* Guard 1: If session is null OR loggedInUser attribute is null → sendRedirect to login + return */
		if (session == null || session.getAttribute("loggedInUser") == null) {
			String returnUrl = request.getContextPath() + "/cart";
			String encoded = java.net.URLEncoder.encode(returnUrl, "UTF-8");
			response.sendRedirect(request.getContextPath() + "/login?redirect=" + encoded);
			return;
		}
		/* Guard 2: Get lastOrderId from session. If it's null → sendRedirect to home/menu + return */
		Integer lastOrderId = (Integer)session.getAttribute("lastOrderId");
		if (lastOrderId == null) {
			response.sendRedirect(request.getContextPath() + "/restaurants");
			return;
		}
		session.removeAttribute("lastOrderId");
		
		/* fetch the order and items */
		OrderTable orderTable = orderTableDAO.getOrderById((int)lastOrderId);
		Restaurant restaurant = restaurantDAO.getRestaurantById(orderTable.getRestaurantId());
		List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId((int)lastOrderId);
		HashMap<Integer, String> hashMap = new HashMap<Integer,String>();
		for(OrderItem i : orderItems) {
			int mId = i.getMenuId();
			String itemName = menuDAO.getMenuById(mId).getItemName();
			hashMap.put(mId, itemName);
		}
		
		request.setAttribute("orderTable", orderTable);
		request.setAttribute("orderItems", orderItems);
		request.setAttribute("restaurant", restaurant);
		request.setAttribute("map", hashMap);
		
		/* Forward to order-conformation.jsp */
		request.getRequestDispatcher("/orderConfirmation.jsp").forward(request, response);
		
	}

}
