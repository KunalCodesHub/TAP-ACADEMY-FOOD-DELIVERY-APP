<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entity.Menu, entity.Restaurant" %>
<%@ page import="java.util.List, java.util.Map" %>
<%
    /* Get attributes from MenuServlet */
    Restaurant restaurant     = (Restaurant) request.getAttribute("restaurant");
    List<Menu> allMenuItems   = (List<Menu>) request.getAttribute("allMenuItems");
    Map<String, List<Menu>> categorizedMenu 
                              = (Map<String, List<Menu>>) request.getAttribute("categorizedMenu");
    Integer totalItems            = (Integer) request.getAttribute("totalItems");
    int availableCount        = (Integer) request.getAttribute("availableCount");

    String search        = (String) request.getAttribute("search");
    String categoryFilter     = (String) request.getAttribute("categoryFilter");
    String sortBy             = (String) request.getAttribute("sortBy");

    /* Null guards */
    if (search    == null) search    = "";
    if (categoryFilter == null) categoryFilter = "all";
    if (sortBy         == null) sortBy         = "";

    /* Context path for URLs  */
    String ctx = request.getContextPath();

    /* Restaurant details  */
    int    restId      = restaurant.getRestaurantId();
    String restName    = restaurant.getName();
    String restCuisine = restaurant.getCuisineType();
    String restAddr    = restaurant.getAddress();
    double restRating  = (restaurant.getRating()).doubleValue();
    String restTime    = String.valueOf(restaurant.getDeliveryTime());
    String restImg     = restaurant.getImagePath();
%>


    <!-- HEADER JSP INCLUDE -->
    <%@ include file="includes/header.jsp" %>
	<!-- Add restaurants page CSS -->
	<link rel="stylesheet" href="<%= request.getContextPath() %>/css/menu.css">

    <!-- RESTAURANT HERO BANNER-->
    <section class="restaurant-hero">
        <div class="container">

            <!-- Breadcrumb -->
            <div class="hero-breadcrumb">
                <a href="<%= ctx %>/home">
                    <i class="bi bi-house-fill"></i> Home
                </a>
                <span class="separator">›</span>
                <a href="<%= ctx %>/restaurants">Restaurants</a>
                <span class="separator">›</span>
                <span class="current"><%= restName %></span>
            </div>

            <!-- Restaurant Info -->
            <div class="restaurant-info-block">

                <!-- Restaurant Image -->
                <img src="<%= ctx %>/<%= restImg %>"
                     alt="<%= restName %>"
                     class="restaurant-avatar"
                     onerror="this.onerror=null;
                              this.src='<%= request.getContextPath() %>/IMG/menu/default.png';">

                <!-- Details -->
                <div class="restaurant-meta">
                    <h1><%= restName %></h1>
                    <span class="cuisine-badge">
                        <i class="bi bi-tag-fill"></i> <%= restCuisine %>
                    </span>

                    <div class="restaurant-stats">
                        <!-- Rating -->
                        <div class="stat-item">
                            <i class="bi bi-star-fill rating-stars"></i>
                            <span class="stat-value"><%= restRating %></span>
                            <span>Rating</span>
                        </div>

                        <!-- Delivery Time -->
                        <div class="stat-item">
                            <i class="bi bi-clock-fill" style="color:#0dcaf0"></i>
                            <span class="stat-value"><%= restTime %></span>
                        </div>

                        <!-- Menu count -->
                        <div class="stat-item">
                            <i class="bi bi-grid-fill" style="color:rgb(192, 192, 192)"></i>
                            <span class="stat-value"><%= totalItems %></span>
                            <span>Items</span>
                        </div>

                        <!-- Address -->
                        <div class="stat-item">
                            <i class="bi bi-geo-alt-fill" style="color:rgb(0, 255, 0)"></i>
                            <span><%= restAddr %></span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

    <!-- FILTER BAR -->
    <div class="filter-bar">
        <div class="container">
            <form class="filter-form" method="GET"
                  action="<%= request.getContextPath() %>/menu" id="filterForm">

                <!-- Hidden restaurant ID -->
                <input type="hidden" name="id" value="<%= restId %>">
                <!-- Hidden Category -->
				<input type="hidden" name="category" value="<%= categoryFilter %>" id="hiddenCategory">
                <!-- Search input -->
                <div class="search-wrapper">
                    <i class="bi bi-search search-icon"></i>
                    <input type="text"
                           name="search"
                           class="search-input"
                           placeholder="Search menu items..."
                           value="<%= search %>"
                           id="searchInput">
                </div>

                <!-- Category pills -->
                <div class="category-pills">
                    <!-- All -->
                    <a href="<%= ctx %>/menu?id=<%= restId %>&category=all&sort=<%= sortBy %>"
                       class="category-pill <%= categoryFilter.equals("all") ? "active" : "" %>">
                        <i class="bi bi-grid-fill"></i> All
                    </a>
                    <!-- Breakfast -->
                    <a href="<%= ctx %>/menu?id=<%= restId %>&category=breakfast&sort=<%= sortBy %>"
                       class="category-pill <%= categoryFilter.equals("breakfast") ? "active" : "" %>">
                        <i class="bi bi-sun-fill"></i> Breakfast
                    </a>
                    <!-- Lunch & Dinner -->
                    <a href="<%= ctx %>/menu?id=<%= restId %>&category=lunch_dinner&sort=<%= sortBy %>"
                       class="category-pill <%= categoryFilter.equals("lunch_dinner") ? "active" : "" %>">
                        <i class="bi bi-egg-fried"></i> Lunch & Dinner
                    </a>
                    <!-- Desserts -->
                    <a href="<%= ctx %>/menu?id=<%= restId %>&category=deserts&sort=<%= sortBy %>"
                       class="category-pill <%= categoryFilter.equals("deserts") ? "active" : "" %>">
                        <i class="bi bi-cake2-fill"></i> Desserts
                    </a>
                    <!-- Drinks -->
                    <a href="<%= ctx %>/menu?id=<%= restId %>&category=drinks&sort=<%= sortBy %>"
                       class="category-pill <%= categoryFilter.equals("drinks") ? "active" : "" %>">
                        <i class="bi bi-cup-straw"></i> Drinks
                    </a>
                </div>

                <!-- Sort select -->
                <select name="sort"
                        class="sort-select"
                        onchange="document.getElementById('filterForm').submit()">
                    <option value=""           <%= sortBy.equals("")           ? "selected" : "" %>>Default Order</option>
                    <option value="price_asc"  <%= sortBy.equals("price_asc")  ? "selected" : "" %>>Price: Low to High</option>
                    <option value="price_desc" <%= sortBy.equals("price_desc") ? "selected" : "" %>>Price: High to Low</option>
                    <option value="name_asc"   <%= sortBy.equals("name_asc")   ? "selected" : "" %>>Name: A to Z</option>
                    <option value="name_desc"  <%= sortBy.equals("name_desc")  ? "selected" : "" %>>Name: Z to A</option>
                </select>

                <!-- Hidden submit for search -->
                <button type="submit" style="display:none">Search</button>

            </form>
        </div>
    </div>

    <!-- ══════════════════════════════════════════════════════
         MAIN CONTENT
    ═══════════════════════════════════════════════════════ -->
    <div class="menu-content">
        <div class="container">
            <div class="row g-4">

                <!-- ── Menu Items Column (left 8) ── -->
                <div class="col-lg-8">

                    <!-- Results info -->
                    <div class="results-info">
                        <div class="results-count">
                            Showing <span><%= allMenuItems.size() %></span>
                            item<%= allMenuItems.size() != 1 ? "s" : "" %>
                            <% if (!search.isEmpty()) { %>
                                for "<span><%= search %></span>"
                            <% } %>
                            <% if (!categoryFilter.equals("all")) { %>
                                in <span><%= categoryFilter.replace("_", " ") %></span>
                            <% } %>
                        </div>
                    </div>

                    <!-- ───────────────────────────────────────────
                         NO ITEMS FOUND STATE
                    ─────────────────────────────────────────────── -->
                    <% if (allMenuItems == null || allMenuItems.isEmpty()) { %>
                        <div class="empty-menu-state">
                            <i class="bi bi-search empty-icon"></i>
                            <h3>No Items Found</h3>
                            <p>
                                <% if (!search.isEmpty()) { %>
                                    No menu items match "<strong><%= search %></strong>".
                                    Try a different search term.
                                <% } else { %>
                                    No menu items available in this category.
                                <% } %>
                            </p>
                            <a href="<%= ctx %>/menu?restaurantId=<%= restId %>"
                               class="btn btn-danger">
                                <i class="bi bi-arrow-left me-2"></i> View All Items
                            </a>
                        </div>

                    <% } else { %>

                        <!-- ─────────────────────────────────────────
                             RENDER ITEMS: GROUPED BY CATEGORY
                        ────────────────────────────────────────────── -->
                        <%
                            /* Iterate over each category section */
                            for (Map.Entry<String, List<Menu>> entry
                                    : categorizedMenu.entrySet()) {

                                String categoryName  = entry.getKey();
                                List<Menu> catItems  = entry.getValue();

                                if (catItems.isEmpty()) continue;

                                /* ── Category display name & icon ── */
                                String catDisplayName;
                                String catIcon;

                                switch (categoryName) {
                                    case "breakfast":
                                        catDisplayName = "Breakfast";
                                        catIcon = "bi-sun-fill";
                                        break;
                                    case "lunch_dinner":
                                        catDisplayName = "Lunch & Dinner";
                                        catIcon = "bi-egg-fried";
                                        break;
                                    case "deserts":
                                        catDisplayName = "Desserts";
                                        catIcon = "bi-cake2-fill";
                                        break;
                                    case "drinks":
                                        catDisplayName = "Drinks";
                                        catIcon = "bi-cup-straw";
                                        break;
                                    default:
                                        catDisplayName = categoryName
                                                .replace("_", " ");
                                        catIcon = "bi-grid-fill";
                                }
                        %>

                        <!-- Category Section -->
                        <div class="category-section"
                             id="cat-<%= categoryName %>">

                            <!-- Category Header -->
                            <div class="category-header">
                                <div class="category-icon-wrap">
                                    <i class="bi <%= catIcon %>"
                                       style="color:#dc3545"></i>
                                </div>
                                <h2><%= catDisplayName %></h2>
                                <span class="category-count-badge">
                                    <%= catItems.size() %> items
                                </span>
                            </div>

                            <!-- Items Grid -->
                            <div class="row g-3">
                            <%
                            	double Subtotal = 0.0;
                                for (Menu item : catItems) {
                                    int    menuId       = item.getMenuId();
                                    String itemName     = item.getItemName();
                                    String itemDesc     = item.getDescription() != null
                                                          ? item.getDescription()
                                                          : "Delicious item from " + restName;
                                    double itemPrice    = (item.getPrice()).doubleValue();
                                    boolean isAvailable = item.isAvailable();
                                    int 	isVeg 		= item.getIsVeg();
                                    String itemImg      = item.getImagePath();
                                    String encodedName  = itemName
                                                          .replace("'", "\\'")
                                                          .replace("\"", "&quot;");
                            %>
                                <div class="col-sm-6 col-md-4">
                                    <div class="menu-card <%= isAvailable ? "" : "unavailable" %>">

                                        <!-- Card Image -->
                                        <div class="menu-card-img-wrap">
                                            <img src="<%= ctx %>/<%= itemImg %>"
                                                 alt="<%= itemName %>"
                                                 onerror="this.onerror=null;
                                                          this.src='<%= request.getContextPath() %>/IMG/menu/default.png';">

                                            <!-- Availability Badge -->
                                            <span class="availability-badge
                                                <%= isAvailable ? "available" : "unavailable" %>">
                                                <%= isAvailable ? "Available" : "Unavailable" %>
                                            </span>
											<!-- Veg/Non-Veg indicator -->
                                            <% if (isVeg == 1) { System.out.println(isVeg); %>
                                            <div class="veg-indicator veg" title="Vegetarian"></div>
                                            <% } else { System.out.println(isVeg);%>
                                            <div class="veg-indicator nonveg" title="Non-Vegetarian"></div>
                                            <% } %>
                                        </div>

                                        <!-- Card Body -->
                                        <div class="menu-card-body">
                                            <div class="item-name text-dark">
                                                <%= itemName %>
                                            </div>
                                            <div class="item-description">
                                                <%= itemDesc %>
                                            </div>

                                            <!-- Price + Add to Cart -->
                                            <div class="card-footer-row">
                                                <div class="item-price">
                                                    <span class="rupee">₹</span><%= String.format("%.0f", itemPrice) %>
                                                </div>

                                                <% if (isAvailable) { %>
                                                    <button class="btn-add-cart"
                                                            onclick="addToCart(
                                                                <%= menuId %>,
                                                                '<%= encodedName %>',
                                                                <%= itemPrice %>,
                                                                '<%= ctx %>/<%= itemImg %>'
                                                            )"
                                                            title="Add to Cart">
                                                        <i class="bi bi-plus-lg"></i> Add
                                                    </button>
                                                <% } else { %>
                                                    <button class="btn-add-cart"
                                                            disabled
                                                            title="Not available">
                                                        <i class="bi bi-x-circle"></i> N/A
                                                    </button>
                                                <% } %>
                                            </div>
                                        </div>

                                    </div><!-- /.menu-card -->
                                </div><!-- /.col -->

                            <% } /* end for each item */ %>
                            </div><!-- /.row (items grid) -->

                        </div><!-- /.category-section -->

                        <% } /* end for each category */ %>

                    <% } /* end if items exist */ %>

                </div><!-- /.col-lg-8 (menu items) -->

                <!-- ── Cart Sidebar Column (right 4) ── -->
                <div class="col-lg-4">
                    <div class="cart-sidebar" id="cartSidebar">

                        <!-- Cart Header -->
                        <div class="cart-sidebar-header">
                            <h5>
                                <i class="bi bi-cart3"></i>
                                Your Order
                            </h5>
                            <div class="cart-count-badge" id="cartCountBadge">0</div>
                        </div>

                        <!-- Cart Items Container -->
                        <div id="cartItemsContainer">
                            <!-- Empty State (default) -->
                            <div class="cart-empty-state" id="cartEmptyState">
                                <i class="bi bi-cart-x"></i>
                                <p>Your cart is empty.<br>Add items to get started!</p>
                            </div>
                            <!-- Items will be injected here by JS -->
                        </div>

                        <!-- Cart Total (hidden when empty) -->
                        <div id="cartTotalSection"
                             class="cart-total-section"
                             style="display:none">

                            <div class="cart-total-row">
                                <span>Subtotal</span>
                                <span id="cartSubtotal">₹0</span>
                            </div>
                            
                            <div class="cart-total-row grand-total">
                                <span>Total</span>
                                <span class="total-amount" id="cartGrandTotal">₹0</span>
                            </div>

                            <!-- Checkout Button -->
                            <button type="button"
                            		class="btn-checkout"
                            		id="checkoutBtn"
                            		onclick="proceedToCheckout()">
                            	<i class="bi bi-bag-check-fill"></i>
                                Proceed to Checkout
                            </button>

                            <!-- Clear Cart -->
                            <button class="btn-clear-cart" onclick="clearCart()">
                                <i class="bi bi-trash"></i> Clear Cart
                            </button>

                        </div>

                    </div><!-- /.cart-sidebar -->
                </div><!-- /.col-lg-4 -->

            </div><!-- /.row -->
        </div><!-- /.container -->
    </div><!-- /.menu-content -->

    <!-- ══════════════════════════════════════════════════════
         MOBILE: Floating Cart Button
    ═══════════════════════════════════════════════════════ -->
    <button class="mobile-cart-btn"
            id="mobileCartBtn"
            data-bs-toggle="offcanvas"
            data-bs-target="#mobileCartOffcanvas">
        <i class="bi bi-cart3"></i>
        <span>View Cart</span>
        <span class="cart-badge" id="mobileBadge">0</span>
    </button>

    <!-- ══════════════════════════════════════════════════════
         MOBILE: Offcanvas Cart
    ═══════════════════════════════════════════════════════ -->
    <div class="offcanvas offcanvas-bottom"
         tabindex="-1"
         id="mobileCartOffcanvas"
         style="background:#1d1d1d; color:#fff; border-radius:20px 20px 0 0; max-height:70vh">
        <div class="offcanvas-header border-bottom"
             style="border-color:rgba(255,255,255,0.1)!important">
            <h5 class="offcanvas-title">
                <i class="bi bi-cart3 text-danger"></i>
                Your Order (<span id="mobileCartCount">0</span> items)
            </h5>
            <button type="button"
                    class="btn-close btn-close-white"
                    data-bs-dismiss="offcanvas"></button>
        </div>
        <div class="offcanvas-body">
            <div id="mobileCartItemsContainer">
                <div class="cart-empty-state">
                    <i class="bi bi-cart-x"></i>
                    <p>Cart is empty</p>
                </div>
            </div>
            <div id="mobileCartTotalSection" style="display:none">
                <div class="cart-total-row grand-total mt-3">
                    <span>Total</span>
                    <span class="total-amount" id="mobileCartTotal">₹0</span>
                </div>
                <a href="<%= ctx %>/cart"
                   class="btn-checkout mt-2"
                   onclick="saveCartToSession()">
                    <i class="bi bi-bag-check-fill"></i>
                    Proceed to Checkout
                </a>
            </div>
        </div>
    </div>

    <!-- ══════════════════════════════════════════════════════
         TOAST NOTIFICATION CONTAINER
    ═══════════════════════════════════════════════════════ -->
    <div class="toast-container-custom" id="toastContainer"></div>

    <!-- ══════════════════════════════════════════════════════
         FOOTER
    ═══════════════════════════════════════════════════════ -->
    <%@ include file="includes/footer.jsp" %>

    <!-- ══════════════════════════════════════════════════════
         SCRIPTS
    ═══════════════════════════════════════════════════════ -->
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <script>
    /* ═══════════════════════════════════════════════════════
       CART MANAGEMENT (localStorage-based)
       - Works without login for now
       - Will connect to session in CartServlet later
    ═══════════════════════════════════════════════════════ */

    /* Restaurant context (from JSP) */
    const RESTAURANT_ID   = <%= restId %>;
    const RESTAURANT_NAME = '<%= restName.replace("'", "\\'") %>';
    const CTX_PATH        = '<%= ctx %>';

    /* ── Load cart from localStorage ─── */
    function loadCart() {
        try {
            const raw = localStorage.getItem('foodCart_' + RESTAURANT_ID);
            return raw ? JSON.parse(raw) : [];
        } catch (e) {
            return [];
        }
    }
    
    /* ── Proceed To Checkout ── */
    async function proceedToCheckout() {
		console.log("proceedToCheckout called");
		// TODO: read cart from localStorage into a const named "cart"
		const cart = loadCart();
		// TODO: if cart is empty, alert the user and return
	    if (cart.length === 0) {
			Swal.fire({
				icon: 'warning',
				title: 'Empty Cart',
				text: 'Please add some delicious items before checking out!',
				background:'#19181a',
				color: '#ffffff',
				confirmButtonColor: '#dc3545'
			});
			return;
		}
	    const items = cart.map(item => ({
	        menuId : Number(item.menuId),
	        itemName : item.name,
	        price : Number(item.price),
	        quantity : Number(item.quantity),
	        imagePath : item.imgPath,
	        restaurantId : Number(RESTAURANT_ID),
	        itemTotal : Number(item.price) * Number(item.quantity)
	    }));

		console.log("Transformed items:", items);

		const response = await fetch(CTX_PATH + "/cart", {
		  method: "POST",
		  headers: {
		    "Content-Type": "application/json",
		  },
		  body: JSON.stringify(items),
		});

		console.log("Response Status: ", response.status);
		console.log("Response OK?: ", response.ok);

		const data = await response.json();
		console.log("Server Response data: " , data);
		
		if(data.success === true && data.count >= 1) {
			window.location.href = CTX_PATH + "/cart";
		} else if (response.status === 401) {
		    Swal.fire({
		        icon: 'warning',
		        title: 'Login Required',
		        text: 'Please login to proceed with checkout',
		        background: '#19181a',
		        color: '#ffffff',
		        confirmButtonColor: '#dc3545',
		        confirmButtonText: 'Login Now'
		    }).then(() => {
		        window.location.href = CTX_PATH + "/login?redirect=" + encodeURIComponent(window.location.href);
		    });
		}
	}

    /* ── Save cart to localStorage ──── */
    function saveCart(cart) {
        localStorage.setItem('foodCart_' + RESTAURANT_ID,
                             JSON.stringify(cart));
        /* Also save restaurant context */
        localStorage.setItem('cartRestaurantId',   RESTAURANT_ID);
        localStorage.setItem('cartRestaurantName', RESTAURANT_NAME);
    }

    /* ═══════════════════════════════════════════════════
    Add item to cart (WITH DEBUG LOGS)
 ═══════════════════════════════════════════════════ */
 function addToCart(menuId, itemName, price, imgPath) {
     
     /* ⭐ DEBUG: Log what we received ⭐ */
     console.log('═══ addToCart called ═══');
     console.log('menuId:',   menuId, typeof menuId);
     console.log('itemName:', itemName, typeof itemName);
     console.log('price:',    price, typeof price);
     console.log('imgPath:',  imgPath);
     console.log('═════════════════════════');
     
     /* Safety checks */
     if (!itemName || itemName === 'undefined') {
         console.error('❌ itemName is missing!');
         alert('Error: Item name is missing! Check console.');
         return;
     }
     
     if (!price || isNaN(price)) {
         console.error('❌ price is invalid!');
         alert('Error: Price is invalid! Check console.');
         return;
     }
     
     let cart = loadCart();

     /* Check if item already exists */
     const existing = cart.find(item => item.menuId === menuId);

     if (existing) {
         existing.quantity++;
     } else {
         cart.push({
             menuId:   parseInt(menuId),
             name:     String(itemName),
             price:    parseFloat(price),
             imgPath:  imgPath || '',
             quantity: 1
         });
     }

     console.log('✅ Cart after add:', cart);
     
     saveCart(cart);
     renderCart();
     showToast(itemName + ' added to cart!');
 }

    /* ── Update quantity ─────────────── */
    function updateQty(menuId, delta) {
        let cart = loadCart();
        const idx = cart.findIndex(item => item.menuId === menuId);

        if (idx !== -1) {
            cart[idx].quantity += delta;
            if (cart[idx].quantity <= 0) {
                cart.splice(idx, 1); /* Remove if qty reaches 0 */
            }
        }

        saveCart(cart);
        renderCart();
    }

    /* ── Remove item ─────────────────── */
    function removeCartItem(menuId) {
        let cart = loadCart().filter(item => item.menuId !== menuId);
        saveCart(cart);
        renderCart();
    }

    /* ── Clear entire cart ───────────── */
    function clearCart() {
        localStorage.removeItem('foodCart_' + RESTAURANT_ID);
        renderCart();
        showToast("Cart cleared!");
    }

    /* ── Render cart sidebar ─────────── */
/* ═══════════════════════════════════════════════════
   Render cart - DOM MANIPULATION (BULLETPROOF)
═══════════════════════════════════════════════════ */
function renderCart() {
    const cart = loadCart();
    console.log('🛒 Rendering cart:', cart);
    
    const total = cart.reduce((sum, i) => sum + (Number(i.price) * Number(i.quantity)), 0);
    const count = cart.reduce((sum, i) => sum + Number(i.quantity), 0);

    const emptyState   = document.getElementById('cartEmptyState');
    const totalSection = document.getElementById('cartTotalSection');
    const container    = document.getElementById('cartItemsContainer');
    const badge        = document.getElementById('cartCountBadge');

    /* Update badges */
    if (badge) badge.textContent = count;
    
    const navBadge = document.querySelector('.navbar .badge');
    if (navBadge) navBadge.textContent = count;

    const mobBadge = document.getElementById('mobileBadge');
    const mobCount = document.getElementById('mobileCartCount');
    if (mobBadge) mobBadge.textContent = count;
    if (mobCount) mobCount.textContent = count;

    /* Remove old rows */
    container.querySelectorAll('.cart-item-row').forEach(r => r.remove());

    if (cart.length === 0) {
        emptyState.style.display   = 'block';
        totalSection.style.display = 'none';
        
        const mc = document.getElementById('mobileCartItemsContainer');
        if (mc) mc.innerHTML = '<div class="cart-empty-state"><i class="bi bi-cart-x"></i><p>Cart is empty</p></div>';
        
        const mt = document.getElementById('mobileCartTotalSection');
        if (mt) mt.style.display = 'none';
        
    } else {
        emptyState.style.display   = 'none';
        totalSection.style.display = 'block';

        /* ⭐ BUILD EACH ROW USING DIRECT DOM METHODS ⭐ */
        cart.forEach(function(item) {
            
            /* Safe values with fallbacks */
            const safeName  = String(item.name || 'Unknown Item');
            const safePrice = Number(item.price) || 0;
            const safeQty   = Number(item.quantity) || 1;
            const safeId    = Number(item.menuId) || 0;
            const itemTotal = (safePrice * safeQty).toFixed(0);
            
            console.log('Building row for:', safeName, 'ID:', safeId, 'Price:', safePrice);

            /* Main row */
            const row = document.createElement('div');
            row.className = 'cart-item-row';
            row.style.display = 'flex';
            row.style.alignItems = 'center';
            row.style.gap = '8px';
            row.style.padding = '12px 0';
            row.style.borderBottom = '1px solid rgba(255,255,255,0.08)';

            /* ─── LEFT: Name + Price per unit ─── */
            const nameDiv = document.createElement('div');
            nameDiv.className = 'cart-item-name';
            nameDiv.style.flex = '1';
            nameDiv.style.minWidth = '0';
            nameDiv.style.color = '#ffffff';
            nameDiv.style.fontSize = '0.85rem';
            nameDiv.style.fontWeight = '600';
            nameDiv.style.lineHeight = '1.3';
            nameDiv.title = safeName;
            
            /* Add name as TEXT NODE (safest method) */
            nameDiv.appendChild(document.createTextNode(safeName));
            
            /* Add price per unit as separate div */
            const priceSmall = document.createElement('div');
            priceSmall.style.color = '#8a9bb5';
            priceSmall.style.fontSize = '0.7rem';
            priceSmall.style.fontWeight = '400';
            priceSmall.style.marginTop = '3px';
            priceSmall.textContent = '₹' + safePrice + ' each';
            nameDiv.appendChild(priceSmall);
            
            row.appendChild(nameDiv);

            /* ─── MIDDLE: Quantity Controls ─── */
            const qtyDiv = document.createElement('div');
            qtyDiv.className = 'cart-qty-controls';
            qtyDiv.style.display = 'flex';
            qtyDiv.style.alignItems = 'center';
            qtyDiv.style.gap = '5px';
            qtyDiv.style.flexShrink = '0';
            
            /* Minus button */
            const minusBtn = document.createElement('button');
            minusBtn.type = 'button';
            minusBtn.className = 'qty-btn';
            minusBtn.textContent = '−';
            minusBtn.style.cssText = 'width:26px;height:26px;border-radius:5px;border:1px solid rgba(220,53,69,0.5);background:rgba(220,53,69,0.15);color:#ff6b7a;cursor:pointer;font-weight:700;padding:0;display:flex;align-items:center;justify-content:center;';
            /* Use function to capture ID correctly */
            minusBtn.addEventListener('click', function() {
                updateQty(safeId, -1);
            });
            qtyDiv.appendChild(minusBtn);
            
            /* Quantity display */
            const qtySpan = document.createElement('span');
            qtySpan.className = 'qty-display';
            qtySpan.textContent = String(safeQty);
            qtySpan.style.color = '#ffffff';
            qtySpan.style.fontSize = '0.85rem';
            qtySpan.style.fontWeight = '700';
            qtySpan.style.minWidth = '20px';
            qtySpan.style.textAlign = 'center';
            qtyDiv.appendChild(qtySpan);
            
            /* Plus button */
            const plusBtn = document.createElement('button');
            plusBtn.type = 'button';
            plusBtn.className = 'qty-btn';
            plusBtn.textContent = '+';
            plusBtn.style.cssText = 'width:26px;height:26px;border-radius:5px;border:1px solid rgba(220,53,69,0.5);background:rgba(220,53,69,0.15);color:#ff6b7a;cursor:pointer;font-weight:700;padding:0;display:flex;align-items:center;justify-content:center;';
            plusBtn.addEventListener('click', function() {
                updateQty(safeId, 1);
            });
            qtyDiv.appendChild(plusBtn);
            
            row.appendChild(qtyDiv);

            /* ─── RIGHT: Item Total Price ─── */
            const priceDiv = document.createElement('div');
            priceDiv.className = 'cart-item-price';
            priceDiv.textContent = '₹' + itemTotal;
            priceDiv.style.color = '#dc3545';
            priceDiv.style.fontSize = '0.9rem';
            priceDiv.style.fontWeight = '700';
            priceDiv.style.whiteSpace = 'nowrap';
            priceDiv.style.flexShrink = '0';
            priceDiv.style.minWidth = '50px';
            priceDiv.style.textAlign = 'right';
            row.appendChild(priceDiv);

            /* Append complete row to container */
            container.appendChild(row);
        });

        /* Update totals */
        const subtotalEl   = document.getElementById('cartSubtotal');
        const grandTotalEl = document.getElementById('cartGrandTotal');
        if (subtotalEl)   subtotalEl.textContent   = '₹' + total.toFixed(0);
        if (grandTotalEl) grandTotalEl.textContent = '₹' + total.toFixed(0);

        /* Mobile version */
        const mobContainer = document.getElementById('mobileCartItemsContainer');
        if (mobContainer) {
            mobContainer.innerHTML = '';
            cart.forEach(function(item) {
                const n = String(item.name || 'Unknown');
                const p = Number(item.price) || 0;
                const q = Number(item.quantity) || 1;
                const id = Number(item.menuId) || 0;
                
                const mobRow = document.createElement('div');
                mobRow.style.cssText = 'display:flex;align-items:center;gap:8px;padding:12px 0;border-bottom:1px solid rgba(255,255,255,0.08);';
                
                mobRow.innerHTML = 
                    '<div style="flex:1;color:#fff;font-size:0.85rem;font-weight:600;">' + 
                        n + 
                        '<div style="color:#8a9bb5;font-size:0.7rem;">₹' + p + ' each</div>' +
                    '</div>' +
                    '<div style="display:flex;align-items:center;gap:5px;">' +
                        '<button onclick="updateQty(' + id + ',-1)" style="width:26px;height:26px;border-radius:5px;border:1px solid rgba(220,53,69,0.5);background:rgba(220,53,69,0.15);color:#ff6b7a;cursor:pointer;">−</button>' +
                        '<span style="color:#fff;min-width:20px;text-align:center;font-weight:700;">' + q + '</span>' +
                        '<button onclick="updateQty(' + id + ',1)" style="width:26px;height:26px;border-radius:5px;border:1px solid rgba(220,53,69,0.5);background:rgba(220,53,69,0.15);color:#ff6b7a;cursor:pointer;">+</button>' +
                    '</div>' +
                    '<div style="color:#dc3545;font-weight:700;">₹' + (p*q).toFixed(0) + '</div>';
                
                mobContainer.appendChild(mobRow);
            });
        }
        
        const mobTotalSec = document.getElementById('mobileCartTotalSection');
        if (mobTotalSec) mobTotalSec.style.display = 'block';
        
        const mobTotalAmt = document.getElementById('mobileCartTotal');
        if (mobTotalAmt) mobTotalAmt.textContent = '₹' + total.toFixed(0);
    }
    
    console.log('✅ Cart rendered:', cart.length, 'items | Total: ₹' + total.toFixed(0));
}


    /* ── Show toast notification ─────── */
    function showToast(message) {
        const container = document.getElementById('toastContainer');
        const toast = document.createElement('div');
        toast.className = 'toast-custom';
        toast.innerHTML = '<i class="bi bi-check-circle-fill"></i><span>'+message+'</span>';
        container.appendChild(toast);

        /* Auto-remove after 3 seconds */
        setTimeout(() => {
            if (toast.parentNode) toast.parentNode.removeChild(toast);
        }, 3000);
    }

    /* ── Search: submit form on Enter ── */
    document.getElementById('searchInput')
        .addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                document.getElementById('filterForm').submit();
            }
        });

    /* ── On page load: render cart ──── */
    document.addEventListener('DOMContentLoaded', function() {
        renderCart();
    });

    </script>
 