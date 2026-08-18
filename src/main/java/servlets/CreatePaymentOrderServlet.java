package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import entity.CartItem;
import entity.User;


@WebServlet("/createPaymentOrder")
public class CreatePaymentOrderServlet extends HttpServlet {

	private final String KEY_ID = "KEY_ID";
	private final String KEY_SECRET = "KEY_SECRET";
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.err.println("inside create payment order servlet");
		HttpSession session = request.getSession(false);
		User user = (session != null) ? (User)session.getAttribute("loggedInUser") : null;
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		if (user == null) {
			// UNAUTHORIZE ACCESS
			response.setStatus(401);
			response.getWriter().write("{"
									 + "\"success\":false,"
									 + "\"error\":\"not logged in\""
									 + "}");
			return;
		}
		
		List<CartItem> items = (List<CartItem>) session.getAttribute("cartItems");
		if (items == null || items.isEmpty()) {
			response.setStatus(400);
			response.getWriter().write("{"
									  +"\"suuccess\":false,"
									  +"\"error\":\"cart empty\""
									  +"}");
			return;
		}
		double total = 0;
		for (CartItem item : items) {
			total += item.getItemTotal();
		}
		int amountInPaisa = (int) Math.round(total * 100);
		
		/* Build JSON request body (amount, currency, receipt) */
		Map<String, Object> payload = new HashMap<>();
		payload.put("amount", amountInPaisa);
		payload.put("currency", "INR");
		payload.put("receipt", "receipt_" + System.currentTimeMillis());
		
		Gson gson = new Gson();
		String jsonBody = gson.toJson(payload);
		
		String auth = KEY_ID + ":" + KEY_SECRET;
		String encodedAuth = Base64.getEncoder().encodeToString(auth.getBytes());
		String authHeader = "Basic " + encodedAuth;
		
		try {
			// Create URL object pointing to Razorpay orders endpoint.
			URL url = new URL("https://api.razorpay.com/v1/orders");
			// Open HttpURLConnection from that URL.
			HttpURLConnection connect = (HttpURLConnection) url.openConnection();
			// Set request properties.
			connect.setRequestMethod("POST");
			connect.setRequestProperty("Authorization", authHeader);
			connect.setRequestProperty("Content-Type", "application/json");
			connect.setDoOutput(true); // we are sending a body
			
			//Write JSON body to the connection output stream
			try (OutputStream os = connect.getOutputStream()) {
				os.write(jsonBody.getBytes("UTF-8"));
			} 
			
			//Read the response from input stream into a String.
			BufferedReader br = new BufferedReader(new InputStreamReader(connect.getInputStream()));
			StringBuffer sb = new StringBuffer();
			String  line;
			while((line = br.readLine()) != null) {
				sb.append(line);
			}
			br.close();
			String responseBody = sb.toString();
			
			// get the razorpay orderId
			Map<String, Object> resMap = gson.fromJson(responseBody, Map.class);
			String razorpayOrderId = (String)resMap.get("id");
			
			Map<String, Object> browserResponse = new HashMap<>();
			browserResponse.put("success", true);
			browserResponse.put("orderId", razorpayOrderId);
			browserResponse.put("amount", amountInPaisa);
			browserResponse.put("keyId", KEY_ID);
			
			response.getWriter().write(gson.toJson(browserResponse));
		} catch (Exception ex) {
			System.err.println(ex.getMessage());
		    response.setStatus(500);
		    response.getWriter().write("{\"success\":false,\"error\":\"Payment order creation failed\"}");
		}
		
	}

}
 