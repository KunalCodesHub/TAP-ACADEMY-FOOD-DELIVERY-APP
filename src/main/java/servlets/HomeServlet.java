package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;
import java.util.List;

import dao.MenuDAO;
import dao.RestaurantDAO;
import dao.impl.MenuDAOImpl;
import dao.impl.RestaurantDAOImpl;
import entity.Menu;
import entity.Restaurant;

/**
 * HomeServlet - Handles requests for the landing page (Home)
 * URL Mapping: /home
 * 
 * Responsibilities:
 * 1. Fetch top-rated restaurants from database
 * 2. Fetch popular menu items
 * 3. Forward data to index.jsp
 */
@WebServlet("/home")
public class HomeServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	private RestaurantDAO restaurentDAO;
	private MenuDAO menuDAO;
	
	// Initialize DAO when servlet is first created 
	public void init() throws ServletException {
		restaurentDAO = new RestaurantDAOImpl();
		menuDAO = new MenuDAOImpl();
		System.out.println("HomeServlet initialized with RestaurantDAO and MenuDAO.");
	}
	
	// Handle GET requests to /home 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		try {
			// fetch top-rated restaurants 
			List<Restaurant> topRestaurants  = restaurentDAO.getAllRestaurants();
			topRestaurants.sort((a, b) -> Double.compare(b.getRating().doubleValue(), a.getRating().doubleValue()));
			// Limit to top 6 restaurants (highest rated)
			if (topRestaurants != null && topRestaurants.size() > 6) {
				topRestaurants = topRestaurants.subList(0, 6);
			}
			
			// fetch popular menu items 
			List<Menu> popularItems = menuDAO.getAllMenus();
			
			// Limit to 8 popular items
			if(popularItems != null && popularItems.size() > 8) {
				popularItems = popularItems.subList(0, 8);
			}
			
			// set data in request
			request.setAttribute("topRestaurants", topRestaurants);
			request.setAttribute("popularItems", popularItems);
			
			// Log for debugging
			System.out.println("Restaurents lodaded: " + ((topRestaurants != null) ? topRestaurants.size() : 0));
			System.out.println("Menu items loaded: "+((popularItems != null) ? popularItems.size() : 0));
			
			// Forward to jsp
			request.getRequestDispatcher("/index.jsp").forward(request, response);
			
		} catch (Exception e) {
			System.err.println("Error in HomeServlet: " + e.getMessage());
			e.printStackTrace();
			
			// Redirect to error page
			request.setAttribute("errorMessage", "Failed to load home page data");
			request.getRequestDispatcher("/error.jsp").forward(request, response);
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}

}
