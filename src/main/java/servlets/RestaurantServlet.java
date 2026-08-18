package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import dao.RestaurantDAO;
import dao.impl.RestaurantDAOImpl;
import entity.Restaurant;


@WebServlet("/restaurants")
public class RestaurantServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    private RestaurantDAO restaurentDAO;

	public void init() throws ServletException {
		restaurentDAO = new RestaurantDAOImpl();
		System.out.println("RestaurantServlet initialized with RestaurantDAO.");
	}
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Retrieve filter and sort parameters from the request
			String search = request.getParameter("search");
			String cuisine = request.getParameter("cuisine");
			String sortBy = request.getParameter("sortBy");
			String category = request.getParameter("category");
			
			// Fetch all restaurants from the database
			List<Restaurant> allRestaurants = restaurentDAO.getAllRestaurants();
			// Create a copy of the list to apply filters and sorting
			List<Restaurant> filterRestaurants = new ArrayList<>(allRestaurants);
			
			// APPLY SEARCH FILTER IF PROVIDED
			if (search != null && !search.trim().isEmpty()) {
                final String searchLower = search.toLowerCase().trim();
                filterRestaurants = filterRestaurants.stream()
                    .filter(r -> r.getName().toLowerCase().contains(searchLower) ||
                                 r.getCuisineType().toLowerCase().contains(searchLower))
                    			  .collect(Collectors.toList());
            }
			
			// APPLY CUISINE FILTER IF SELECTED
			if (cuisine != null && !cuisine.trim().isEmpty() && !cuisine.equalsIgnoreCase("All")) {
				final String cusineLower = cuisine.toLowerCase().trim();
				filterRestaurants = filterRestaurants.stream()
						.filter(r -> r.getCuisineType().toLowerCase().contains(cusineLower))
						.collect(Collectors.toList());
			}
			
			// APPLY SORTING BASED ON USER SELECTION
			if (sortBy != null && !sortBy.trim().isEmpty()) {
				switch (sortBy) {
				case "rating":
					filterRestaurants.sort((a, b) -> Double.compare(b.getRating().doubleValue(), a.getRating().doubleValue()));
					break;
				case "delivery":
					filterRestaurants.sort((a,b) -> Integer.compare(a.getDeliveryTime(), b.getDeliveryTime()));
					break;
				case "name":
					filterRestaurants.sort((a,b) ->  a.getName().compareToIgnoreCase(b.getName()));
					break;
				}
			}
			
			else {
				// Default sorting by rating
				filterRestaurants.sort((a, b) -> Double.compare(b.getRating().doubleValue(), a.getRating().doubleValue()));
			}
			
			// GET UNIQUE CUISINE TYPES 
			List<String> cuisineType = allRestaurants.stream()
					.map(Restaurant::getCuisineType).distinct()
					.sorted().collect(Collectors.toList());
			
			// Set attributes for the request to be used in JSP
			request.setAttribute("restaurants", filterRestaurants);
            request.setAttribute("cuisineTypes", cuisineType);
            request.setAttribute("totalCount", filterRestaurants.size());
            request.setAttribute("searchQuery", search);
            request.setAttribute("selectedCuisine", cuisine);
            request.setAttribute("selectedSort", sortBy);
            request.setAttribute("selectedCategory", category);
			
            System.out.println("Showing " + filterRestaurants.size() + " restaurants");
            
            // Forward the request to the JSP page for rendering
            request.getRequestDispatcher("/restaurants.jsp").forward(request, response);
            
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Failed to load restaurants");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
