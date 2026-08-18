<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="entity.Restaurant" %>
<%@ page import="dao.RestaurantDAO" %>
<%@ page import="dao.impl.RestaurantDAOImpl" %>

<%
    // Get data from servlet OR fetch directly (fallback)
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
    List<String> cuisineTypes = (List<String>) request.getAttribute("cuisineTypes");
    Integer totalCount = (Integer) request.getAttribute("totalCount");
    String searchQuery = (String) request.getAttribute("searchQuery");
    String selectedCuisine = (String) request.getAttribute("selectedCuisine");
    String selectedSort = (String) request.getAttribute("selectedSort");
    
    // Fallback: If accessed directly, fetch from DB
    if (restaurants == null) {
        RestaurantDAO restaurantDAO = new RestaurantDAOImpl();
        restaurants = restaurantDAO.getAllRestaurants();
        totalCount = restaurants.size();
        
        // Get unique cuisine types
        cuisineTypes = new java.util.ArrayList<>();
        for (Restaurant r : restaurants) {
            if (!cuisineTypes.contains(r.getCuisineType())) {
                cuisineTypes.add(r.getCuisineType());
            }
        }
        java.util.Collections.sort(cuisineTypes);
    }
    
    // Handle null values for form
    if (searchQuery == null) searchQuery = "";
    if (selectedCuisine == null) selectedCuisine = "all";
    if (selectedSort == null) selectedSort = "rating";
%>

<!-- Include Header -->
<%@ include file="/includes/header.jsp" %>
<!-- Add restaurants page CSS -->
<link rel="stylesheet" href="<%= request.getContextPath() %>/css/restaurants.css">

<!-- PAGE HEADER -->
<section class="page-header">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-md-8">
                <h1 class="page-title">
                    <i class="bi bi-shop"></i> All Restaurants
                </h1>
                <p class="page-subtitle">Discover the best restaurants in your area</p>
            </div>
            <div class="col-md-4 text-md-end">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb justify-content-md-end">
                        <li class="breadcrumb-item">
                            <a href="<%= request.getContextPath() %>/index.jsp">Home</a>
                        </li>
                        <li class="breadcrumb-item active">Restaurants</li>
                    </ol>
                </nav>
            </div>
        </div>
    </div>
</section>

<!-- FILTERS & SEARCH SECTION -->
<section class="filters-section">
	<div class="container">
		<form action="<%= request.getContextPath() %>/restaurants" method="get" id="filterForm">
			<div class="filter-box">
				<div class="row g-3 aligh-items-end">
				 	<!-- Search -->
				 	<div class="col-lg-4 col-md-6">
				 		<label class="filter-label">
							<i class="bi bi-search"></i> Search
				 		</label>
				 		<input type="text"
				 			   name="search"
				 			   class="form-control filter-input border-danger"
				 			   placeholder="Search restaurants..."
				 			   value="<%= searchQuery %>"/>
				 	</div>
				 	
				 	<!-- Cuisine Filter -->
				 	<div class="col-lg-3 col-md-6">
				 		<label class="filter-label"> 
				 			<i class="bi bi-tag"></i> Cuisine Type 
				 		</label>
				 	
					 	<select name="cuisine" class="from-select filter-input">
					 		<option value="all" <%= selectedCuisine.equalsIgnoreCase("all") ? "selected" : "" %>>
					 			All Cuisines
					 		</option>
					 		<%
					 			if (cuisineTypes != null) {
					 				for (String cuisine : cuisineTypes) {
					 		%>
					 		<option value="<%= cuisine %>" <%= selectedCuisine.equalsIgnoreCase(cuisine) ? "selected" : " "%>>
					 			<%= cuisine %>
					 		</option>
					 		<%
					 				}
					 			}
					 		%>
					 	</select>
				 	</div>
				 	
				 	<!-- Sort By -->
				 	<div>
				 		<label>Sort By</label>
				 		<select name="sortBy" class="form-select filter-input">
				 			<option value="rating" <%= selectedSort.equals("rating") ? "selected" : "" %>>
				 				Rating (High to Low)
				 			</option>
				 			<option value="delivery" <%= selectedSort.equals("delivery") ? "selected" : "" %>>
				 				Delivery Time (Fastest)
				 			</option>
				 			<option value="name" <%= selectedSort.equals("name") ? "selected" : "" %>>
				 				Name (A-Z)
				 			</option>
				 		</select>
				 	</div>
				</div> 
			</div>
		</form>
		
		<!-- Reset Button -->
		<% if(!searchQuery.isEmpty() || !searchQuery.equalsIgnoreCase("all") || !searchQuery.equalsIgnoreCase("rating") ) %>
		<div class="text-center mt-3">
			<a href="<%= request.getContextPath() %>/restaurants" class="btn btn-outline-warning round-border">
				<i class="bi bi-x-circle"></i> Clear All Filters
			</a>
		</div>
	</div>
</section>

<!-- RESULT INFO -->
<section>
	<div class="container">
		<div class="results-info">
			<div>
				<h4>
					<span class="results-count"><%= totalCount %></span> 
					Restaurant<%= totalCount >= 1 ? "s" : ""%>
				</h4>
				<% if (!searchQuery.isEmpty()) { %>
				<p>
					Search results for: <strong>"<%= searchQuery %>"</strong>
				</p>
				<%	} %>
			</div>
			<div class="view-toggle">
				<button class="btn btn-sm btn-outline-secondary active" id="gridView">
					<i class="bi bi-grid-3x3-gap-fill"></i> Grid
				</button>
				<button class="btn btn-sm btn-warning" id="listView">
					 <i class="bi bi-list-ul"></i> List
				</button>
			</div>
		</div>
	</div>
</section>

<!-- RESTAURANTS GRID -->
<section class="restaurants-section">
    <div class="container">
        <% if (restaurants != null && !restaurants.isEmpty()) { %>
            
            <div class="row g-4" id="restaurantsGrid">
                <% for (Restaurant r : restaurants) { %>
                    <div class="col-md-6 col-lg-4 restaurant-item">
                        <div class="restaurant-card-modern">
                            
                            <!-- Image Section -->
                            <div class="restaurant-image-wrapper">
                                <img src="<%= request.getContextPath() %>/<%= r.getImagePath() %>" 
                                     alt="<%= r.getName() %>"
                                     class="restaurant-img"
                                     onerror="this.onerror=null; this.src='<%= request.getContextPath() %>/IMG/restaurants/default.png';">
                                
                                <!-- Rating Badge -->
                                <span class="rating-badge-modern">
                                    <i class="bi bi-star-fill"></i> <%= r.getRating() %>
                                </span>
                                
                                <!-- Delivery Time Badge -->
                                <span class="delivery-badge">
                                    <i class="bi bi-clock"></i> <%= r.getDeliveryTime() %> mins
                                </span>
                                
                                <!-- Overlay -->
                                <div class="image-overlay">
                                    <a href="<%= request.getContextPath() %>/menu?id=<%= r.getRestaurantId() %>"
                                       class="btn btn-light">
                                        <i class="bi bi-eye"></i> Quick View
                                    </a>
                                </div>
                            </div>
                            
                            <!-- Info Section -->
                            <div class="restaurant-details">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <h4 class="restaurant-name"><%= r.getName() %></h4>
                                    <span class="cuisine-tag">
                                        <%= r.getCuisineType() %>
                                    </span>
                                </div>
                                
                                <p class="restaurant-address">
                                    <i class="bi bi-geo-alt-fill"></i>
                                    <%= r.getAddress().length() > 40 ? 
                                        r.getAddress().substring(0, 40) + "..." : 
                                        r.getAddress() %>
                                </p>
                                
                                <div class="restaurant-meta-info">
                                    <div class="meta-item">
                                        <i class="bi bi-truck"></i>
                                        <span>Free Delivery</span>
                                    </div>
                                    <div class="meta-item">
                                        <i class="bi bi-currency-rupee"></i>
                                        <span>Affordable</span>
                                    </div>
                                </div>
                                
                                <a href="<%= request.getContextPath() %>/menu?id=<%= r.getRestaurantId() %>" 
                                   class="btn btn-danger view-menu-btn round-border">
                                    View Menu <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
            
        <% } else { %>
            
            <!-- No Results Found -->
            <div class="no-results">
                <div class="no-results-icon">
                    <i class="bi bi-search"></i>
                </div>
                <h3>No Restaurants Found</h3>
                <p class="text-muted">
                    <% if (!searchQuery.isEmpty()) { %>
                        We couldn't find any restaurants matching <strong>"<%= searchQuery %>"</strong>
                    <% } else { %>
                        Try changing your filters or search criteria
                    <% } %>
                </p>
                <a href="<%= request.getContextPath() %>/restaurants" class="btn btn-danger mt-3">
                    <i class="bi bi-arrow-left"></i> View All Restaurants
                </a>
            </div>
            
        <% } %>
    </div>
</section>

<!-- CALL TO ACTION -->
<section class="cta-section-small">
    <div class="container">
        <div class="cta-box">
            <div class="row align-items-center">
                <div class="col-md-8">
                    <h3 class="text-white mb-2">Can't Find Your Favorite Restaurant?</h3>
                    <p class="text-white-50 mb-0">Let us know and we'll add it to our platform!</p>
                </div>
                <div class="col-md-4 text-md-end">
                    <a href="#" class="btn btn-warning btn-lg">
                        <i class="bi bi-envelope"></i> Contact Us
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Include Footer -->
<%@ include file="/includes/footer.jsp" %>
<!-- Page Specific JS -->
<script>
    // View Toggle (Grid/List)
    const gridBtn = document.getElementById('gridView');
    const listBtn = document.getElementById('listView');
    const grid = document.getElementById('restaurantsGrid');
    
    if (gridBtn && listBtn && grid) {
        gridBtn.addEventListener('click', function() {
            grid.classList.remove('list-view');
            gridBtn.classList.add('active');
            listBtn.classList.remove('active');
        });
        
        listBtn.addEventListener('click', function() {
            grid.classList.add('list-view');
            listBtn.classList.add('active');
            gridBtn.classList.remove('active');
        });
    }
    
    // Auto-submit form on filter change
    document.querySelectorAll('#filterForm select').forEach(select => {
        select.addEventListener('change', function() {
            document.getElementById('filterForm').submit();
        });
    });
</script>