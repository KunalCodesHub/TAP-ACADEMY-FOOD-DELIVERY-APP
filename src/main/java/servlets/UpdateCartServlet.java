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
import com.google.gson.JsonObject;

import entity.CartItem;


@WebServlet("/UpdateCart")
public class UpdateCartServlet extends HttpServlet {

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("calling update servlet");
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
	
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedInUser") == null) {
			response.setStatus(401);
			response.getWriter().print("{"
									 + "\"success\":false,"
									 + "\"error\":\"not logged in\""
									 + "}");
			return;
		}
		
		
		String jsonBody = request.getReader().lines().collect(Collectors.joining());
		JsonObject json = new Gson().fromJson(jsonBody, JsonObject.class);
		int menuId = json.get("menuId").getAsInt();
		int newQuantity = json.get("newQuantity").getAsInt();
		
		
		List<CartItem> items = (List<CartItem>) session.getAttribute("cartItems");
		if (items == null || items.isEmpty()) {
			response.setStatus(400);
			response.getWriter().write("{\"success\":false,"
									  + "\"error\":\"empty cart\"}");
			return;
		}
		
		CartItem found = null;
		for (CartItem item : items) {
			if (item.getMenuId() == menuId) {
					found = item;
					break;	
			}
		} 
		
		if (found == null) {
			response.setStatus(404);
			response.getWriter().write("{\"success\":false,"
									  + "\"error\":\"Item not in cart\"}");
			return;
		}
		
		if (newQuantity <= 0) {
			items.remove(found);
		} else {
			found.setQuantity(newQuantity);
		}
		
		session.setAttribute("cartItems", items);
		
		
		double subTotal = 0;
		for (CartItem item : items) {
			subTotal += item.getItemTotal();
		}
		double deliveryFee = 0;
		if	(!items.isEmpty() && subTotal <= 500) {
			deliveryFee = 40;
		}
		double gst 		   = subTotal * 0.05;
		double total 	   = subTotal + deliveryFee + gst;
		
		String jsonOut = "{\"success\":true,\"count\":"+ items.size() +",\"subTotal\":\""+ String.format("%.2f",subTotal) +"\",\"deliveryFee\":\""+ String.format("%.2f",deliveryFee) +"\",\"gst\":\""+ String.format("%.2f",gst) +"\",\"total\":\""+ String.format("%.2f",total) +"\"}";
		response.getWriter().write(jsonOut);
		
	}

}
