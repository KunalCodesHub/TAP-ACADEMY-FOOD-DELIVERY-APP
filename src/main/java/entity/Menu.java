package entity;

import java.math.BigDecimal;

public class Menu {
    private int menuId; // Primary key
    private int restaurantId; // Foreign key to Restaurant
    private String itemName; // Name of the menu item
    private String description; // Description of the menu item
    private BigDecimal price; // Price of the menu item
    private boolean isAvailable; // Availability status of the menu item
    private String imagePath;// Path to the image file
    private int isVeg;

    // Default Constructor
    public Menu() {
    }

    // Parameterized Constructor
    public Menu(int menuId, int restaurantId, String itemName, String description,
                BigDecimal price, boolean isAvailable, String imagePath, int isVeg) {
        this.menuId = menuId;
        this.restaurantId = restaurantId;
        this.itemName = itemName;
        this.description = description;
        this.price = price;
        this.isAvailable = isAvailable;
        this.imagePath = imagePath;
        this.isVeg = isVeg;
    }

    

	// Getters and Setters
    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean isAvailable) {
        this.isAvailable = isAvailable;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }
    
    public int getIsVeg() {
		return isVeg;
	}

	public void setIsVeg(int isVeg) {
		this.isVeg = isVeg;
	}

    @Override
    public String toString() {
        return "Menu [menuId=" + menuId + ", restaurantId=" + restaurantId + ", itemName="
                + itemName + ", description=" + description + ", price=" + price
                + ", isAvailable=" + isAvailable + ", imagePath=" + imagePath + ",isVeg=" + isVeg +"]\n";
    }
}