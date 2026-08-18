package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import dao.MenuDAO;
import dao.impl.MenuDAOImpl;
import entity.CartItem;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
	
	private MenuDAO menuDAO;
	
	public void intit() {
		menuDAO = new MenuDAOImpl();
	}
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null) {	
			System.out.println("🚫 CartServlet: no session, redirecting to login");
			String returnUrl = request.getContextPath() + "/cart";
			String encoded = java.net.URLEncoder.encode(returnUrl, "UTF-8");
			response.sendRedirect(request.getContextPath() + "/login?redirect=" + encoded);
			return;
		}
		System.out.println("✅ CartServlet: user is logged in, forwarding to cart.jsp");
		request.getRequestDispatcher("/cart.jsp").forward(request, response);
		return;
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		if (session == null || session.getAttribute("loggedInUser") == null) {	
			// UNAUTHORIZE ACCESS
			response.setStatus(401);
			response.getWriter().write("{"
									 + "\"success\":false,"
									 + "\"error\":\"not logged in\""
									 + "}");
			return;
			
		} 
		// EXTRACT JSON BODY 
		String jsonBody = request.getReader().
				lines().
				collect(Collectors.joining());
		// CHECK IS BODY IS EMPTY
		if (jsonBody == null || jsonBody.trim().isEmpty()) {
			response.setStatus(400);
			return;
		}
		
		// PARSE THE JSON BODY
		Gson gson = new Gson();
		List<CartItem> items = gson.fromJson(jsonBody, new TypeToken<List<CartItem>>(){}.getType());
		
		// SET THE LIST TO SESSION
		session.setAttribute("cartItems", items);
		
		// SENDBACK JSON RESPONSE
		response.getWriter().write("{\"success\":true,\"count\":"+items.size()+"}");
		
		System.out.println("items: " + items.toString());
		
		return;
	}

}
