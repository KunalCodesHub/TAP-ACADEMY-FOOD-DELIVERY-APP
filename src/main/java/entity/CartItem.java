package entity;


public class CartItem {
	/* FIELDS */
	private int    menuId;
	private String itemName;
	private double price;
	private int    quantity = 1; // New cart items start with a quantity of 1 by default.
	private String imagePath;
	private int    restaurantId;
	private double itemTotal;
	
	/* CONSTRUCTORS */
	public CartItem() {
		super();
	}
	public CartItem(int menuId, String itemName, double price, int quantity, 
					String imagePath, int restaurantId,double itemTotal) {
		this.menuId = menuId;
		setItemName(itemName);
		setPrice(price);
		setQuantity(quantity);
		this.imagePath = imagePath;
		this.restaurantId = restaurantId;
		this.itemTotal = itemTotal;
	}
	
	/* GETTERS & SETTERS */
	public int getMenuId() {
		return menuId;
	}
	public void setMenuId(int menuId) {
		this.menuId = menuId;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		// ItemName should not be null or empty
		if (itemName != null && !itemName.trim().isEmpty()) {	
			this.itemName = itemName;
		} else {
			throw new IllegalArgumentException("Name can't be: " + itemName);
		}
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		// Price can't be -ve
		if (price > 0) {
			this.price = price;
		} else {
			throw new IllegalArgumentException("Price must be positive, got: " + price);
		}
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		// quantity 0 would render an empty 0 row and mis-count items
		if (quantity >= 1) {
			this.quantity = quantity;
		} else {
			throw new IllegalArgumentException("Quantity can't be zero or -ve");
		}
	}
	public String getImagePath() {
		return imagePath;
	}
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}
	public int getRestaurantId() {
		return restaurantId;
	}
	public void setRestaurantId(int restaurantId) {
		this.restaurantId = restaurantId;
	}
	public double getItemTotal() {
		return itemTotal;
	}
	public void setItemTotal(double itemTotal) {
		this.itemTotal = itemTotal;
	}
	@Override
	public String toString() {
		return "CartItem [menuId=" + menuId + ", itemName=" + itemName + ", price=" + price + ", quantity=" + quantity
				+ ", imagePath=" + imagePath + ", restaurantId=" + restaurantId + ", itemTotal=" + itemTotal + "]\n";
	}

}



