package entity;

import java.math.BigDecimal;

public class OrderItem {
    private int orderItemId; // Primary key
    private int orderId; // Foreign key referencing OrderTable
    private int menuId; // Foreign key referencing Menu
    private int quantity; // Quantity of the menu item ordered
    private BigDecimal itemTotal; // Total price for this order item (quantity * menu item price)

    // Default Constructor
    public OrderItem() {
    }

    // Parameterized Constructor
    public OrderItem(int orderItemId, int orderId, int quantity, BigDecimal itemTotal, int menuId) {
        this.orderItemId = orderItemId;
        this.orderId = orderId;
        this.quantity = quantity;
        this.itemTotal = itemTotal;
        this.menuId = menuId;
    }

    // Getters and Setters
    public int getOrderItemId() {
        return orderItemId;
    }

    public void setOrderItemId(int orderItemId) {
        this.orderItemId = orderItemId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getItemTotal() {
        return itemTotal;
    }

    public void setItemTotal(BigDecimal itemTotal) {
        this.itemTotal = itemTotal;
    }

    public int getMenuId() {
        return menuId;
    }

    public void setMenuId(int menuId) {
        this.menuId = menuId;
    }

    @Override
    public String toString() {
        return "OrderItem [orderItemId=" + orderItemId + ", orderId=" + orderId + ", quantity="
                + quantity + ", itemTotal=" + itemTotal + ", menuId=" + menuId + "]";
    }
}