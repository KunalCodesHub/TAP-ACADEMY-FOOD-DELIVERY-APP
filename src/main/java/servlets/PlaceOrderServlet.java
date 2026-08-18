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

import dao.OrderItemDAO;
import dao.OrderTableDAO;
import dao.impl.OrderItemDAOImpl;
import dao.impl.OrderTableDAOImpl;
import entity.CartItem;
import entity.OrderItem;
import entity.OrderTable;
import entity.User;


@SuppressWarnings("serial")
@WebServlet("/PlaceOrder")
public class PlaceOrderServlet extends HttpServlet {
	
	private OrderItemDAO orderItemDAO;
	private OrderTableDAO orderTableDAO;
	
	public void init() {
		orderItemDAO = new OrderItemDAOImpl();
		orderTableDAO = new OrderTableDAOImpl();
	}
	
       
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null ) {
			String returnUrl = request.getContextPath() + "/cart";
			String encoded = java.net.URLEncoder.encode(returnUrl, "UTF-8");
			response.sendRedirect(request.getContextPath() + "/login?redirect=" + encoded);
			return;
		}
		List<CartItem> items = (List<CartItem>)session.getAttribute("cartItems");
		if (items.isEmpty()) {
			response.sendRedirect(request.getContextPath() + "/menu");
			return;
		} else {
			String address = request.getParameter("deliveryAddress");
			System.out.println("ADDRESS"+address);
			String paymentMethod = request.getParameter("paymentMethod");
			double subTotal = 0.0;
			for (CartItem item : items) {
				subTotal += item.getItemTotal();
			}
			double deliveryFee = (subTotal > 500) ? 0.0 : 40.0;
			double gst = subTotal * 0.05;
			double total = subTotal + deliveryFee + gst;
			User user = (User) session.getAttribute("loggedInUser");
			int userId = user.getUserId();
			int restId = items.get(0).getRestaurantId();
			System.out.println(restId + " " + userId);
			
			/* Order Table */
			OrderTable orderTable = new OrderTable();
			orderTable.setUserId(userId);
			orderTable.setRestaurantId(restId);
			orderTable.setTotalAmount(BigDecimal.valueOf(total));
			orderTable.setPaymentMethod(OrderTable.PaymentMethod.valueOf(paymentMethod));
			orderTable.setStatus(OrderTable.Status.PENDING);
			orderTable.setDeliveryAddress(address);
			
			/* INSERT TO ORDER TABLE */
			int placedOrderId = orderTableDAO.addOrder(orderTable);
			System.out.println(placedOrderId);
			for (CartItem item : items) {
				OrderItem orderItem = new OrderItem();
				orderItem.setOrderId(placedOrderId);
				orderItem.setMenuId(item.getMenuId());
				orderItem.setQuantity(item.getQuantity());
				orderItem.setItemTotal(BigDecimal.valueOf(item.getItemTotal()));
				orderItemDAO.addOrderItem(orderItem);
			}
			session.setAttribute("cartItems", null);
			session.setAttribute("lastOrderId", placedOrderId);
			response.sendRedirect(request.getContextPath() + "/OrderConfirmation");
			
		}
	}

}
