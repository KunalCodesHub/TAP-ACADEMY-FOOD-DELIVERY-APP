package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import dao.MenuDAO;
import dao.RestaurantDAO;
import dao.impl.MenuDAOImpl;
import dao.impl.RestaurantDAOImpl;
import entity.Menu;
import entity.Restaurant;


@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MenuDAO menuDAO; //
	private RestaurantDAO restaurentDAO;
	
	@Override
	public void init() throws ServletException {
		menuDAO = new MenuDAOImpl();
		restaurentDAO = new RestaurantDAOImpl();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// GET RESTAURANT-ID FROM QUERY PARAMETER
		String restaurantIdParam = request.getParameter("id");
		int restaurantId = 0;
		try {
			if (restaurantIdParam != null && !restaurantIdParam.trim().isEmpty()) {
				restaurantId = Integer.parseInt(restaurantIdParam);
				System.out.println(restaurantId);
			} else {
				System.out.println(restaurantIdParam);
			}
		} catch (NumberFormatException e) {
			// if invalid ID provided -> redirect to restaurants
			response.sendRedirect(request.getContextPath() + "/restaurants");
			return;
		}
		
		// if no ID provided -> redirect to restaurants
		if (restaurantId <= 0) {
			response.sendRedirect(request.getContextPath() + "/restaurants");
			return;
		}
		
		// GET RESTAURANT DETAILS
		Restaurant restaurant = restaurentDAO.getRestaurantById(restaurantId);
		
		// if restaurant not found -> redirect to with error
		if (restaurant == null) {
			response.sendRedirect(request.getContextPath() + "/restaurants?error=notfound");
			return;
		}
		
		// FETCH ALL THE MENU ITEMS FROM THE RESTAURANT
		List<Menu> allMenuItems = menuDAO.getAllMenus();
		
		
		
		// GET OPTIONAL SEARCH/FILTER PARAMETERS
		String search =(String) request.getParameter("search");
		System.out.println("Search: " + search);
		String categoryFilter = request.getParameter("category");
		System.out.println("Categroy: " + categoryFilter);
		String sortBy = request.getParameter("sort");
		System.out.println("Sorting: " + sortBy);
		
		if (search == null) {
			search = "";
		}
		
		// FILTER AND SORT THE MENU LIST
		List<Menu> filteredItems = filterAndSort(allMenuItems, search, categoryFilter, sortBy);
		
		// GROUP ITEM BY CATEGORY FOR DISPLAY
		Map<String,List<Menu>> categorizedMenu = groupByCategory(filteredItems);
		
		// CALCULTAE TOTLA AVLABLE ITEMS
		long avilableItmesCount = allMenuItems.stream().filter(m -> m.isAvailable()).count();
			
		
		
		// ── 8. Set attributes and forward to JSP ─────────────────────
        request.setAttribute("restaurant",      restaurant);
        request.setAttribute("allMenuItems",    filteredItems);
        request.setAttribute("categorizedMenu", categorizedMenu);
        request.setAttribute("totalItems",      allMenuItems.size());
        request.setAttribute("availableCount",  (int) avilableItmesCount);
        request.setAttribute("search",     search);
        request.setAttribute("categoryFilter",  categoryFilter);
        request.setAttribute("sortBy",          sortBy);

        request.getRequestDispatcher("/menu.jsp")
               .forward(request, response);
	}
	
	// Filter + Sort
	private List<Menu> filterAndSort(List<Menu> items, String search, String category, String sort) {
		List<Menu> result = new ArrayList<>();
		
		for (Menu item : items) {
			boolean mathchesSearch = true;
			boolean matchesCategory = true;
			
			// Search filter (ItemName or Description)
			if (search != null && !search.trim().isEmpty()) {
				String q = search.trim().toLowerCase();
				mathchesSearch = ((item.getItemName() != null && item.getItemName().toLowerCase().contains(q)) || (item.getDescription() != null && item.getDescription().toLowerCase().contains(q)));
			}
			
			// Category filter (derived from ImagePath)
			if (category != null && !category.trim().isEmpty() && !category.equalsIgnoreCase("all")) {
				String cat = extractCategory(item.getImagePath());
				matchesCategory = cat.equalsIgnoreCase(category.trim());
			}
			
			if (matchesCategory && mathchesSearch) {
				result.add(item);
			}
		}
			
		
		// SORT
		if (sort != null) {
			System.out.println(sort);
			switch (sort) {
				case "price_asc" : result.sort((a, b) -> Double.compare((a.getPrice()).doubleValue(), (b.getPrice()).doubleValue()));
				break;
				case "price_desc" : result.sort((a, b) -> Double.compare((b.getPrice()).doubleValue(), (a.getPrice()).doubleValue()));
				break;
				case "name_asc" : result.sort((a, b) -> a.getItemName().compareToIgnoreCase(b.getItemName()));
				break;
				case "name_desc" : result.sort((a, b) -> b.getItemName().compareToIgnoreCase(a.getItemName()));
				break;
				default:
					break;
			}
		}
		
		return result;
	}
	
	private Map<String,List<Menu>> groupByCategory(List<Menu> items) {
		Map<String,List<Menu>> map = new LinkedHashMap<String, List<Menu>>();
		
		// predefined category order
		String[] order = {"breakfast", "lunch_dinner", "deserts", "drinks"};
        for (String cat : order) {
            map.put(cat, new ArrayList<>());
        }
        
        for (Menu item : items) {
            String cat = extractCategory(item.getImagePath());
            // If category not pre-defined, add it dynamically
            if (!map.containsKey(cat)) {
                map.put(cat, new ArrayList<>());
            }
            map.get(cat).add(item);
        }
        
     // Remove empty categories so JSP doesn't render empty sections
        map.entrySet().removeIf(e -> e.getValue().isEmpty());
        return map;
	}

	// Extract category from ImagePath
	private String extractCategory(String imagePath) {
		if(imagePath == null || imagePath.trim().isEmpty()) {
			return "other";
		}
		try {
			String[] parts = imagePath.replace("\\", "/").split("/");
			if (parts.length >= 3) {
				return parts[2];
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "other";
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
