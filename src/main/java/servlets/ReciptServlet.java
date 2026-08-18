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
import java.util.Map;

import dao.MenuDAO;
import dao.OrderItemDAO;
import dao.OrderTableDAO;
import dao.RestaurantDAO;
import dao.impl.MenuDAOImpl;
import dao.impl.OrderItemDAOImpl;
import dao.impl.OrderTableDAOImpl;
import dao.impl.RestaurantDAOImpl;
import entity.OrderItem;
import entity.OrderTable;
import entity.Restaurant;
import entity.User;


@WebServlet("/OrderDetails")
public class ReciptServlet extends HttpServlet {
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
	
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
		// Check user Logged-in
    	HttpSession session = request.getSession(false);
    	User user 	 		= (session != null) ? (User) session.getAttribute("loggedInUser") : null;
    	
    	if (user == null) {
    		// redirect to login page
    		response.sendRedirect(request.getContextPath() + "/login");
    		return;
    	}
    	
    	// read and validate orderId
    	int orderId;
    	try {
    		orderId = Integer.parseInt(request.getParameter("orderId"));
 
    	} catch (Exception ex) {
    		System.err.println(ex.getMessage());
    		response.sendRedirect(request.getContentType() + "/my-orders");
    		return;
    	}
    	
    	// Fetch order 
    	OrderTable orderTable = orderTableDAO.getOrderById(orderId);
    	if(orderTable == null || orderTable.getUserId() != user.getUserId()) {
    		response.sendRedirect(request.getContextPath() + "/my-orders");
    		return;
    	}
    	
    	// Fetch related data
    	List<OrderItem> orderItems = orderItemDAO.getOrderItemsByOrderId(orderTable.getOrderId());
    	Restaurant restaurant 	   = restaurantDAO.getRestaurantById(orderTable.getRestaurantId());
    	
    	// Build menuId -> menuName map
    	Map<Integer, String> map = new HashMap<>();
    	for (OrderItem item : orderItems) {
    		String itmeName = menuDAO.getMenuById(item.getMenuId()).getItemName();
    		map.put(item.getMenuId(), itmeName);
    	}
    	System.out.println(map);
    	
    	// set Attribute and forward to orderDetails
    	request.setAttribute("orderTable", orderTable);
    	request.setAttribute("orderItems", orderItems);
    	request.setAttribute("restaurant", restaurant);
    	request.setAttribute("map", map);
    	
    	request.getRequestDispatcher("/orderDetails.jsp").forward(request, response);
	}

}
