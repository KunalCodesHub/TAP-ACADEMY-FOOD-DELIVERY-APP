package entity;


import java.math.BigDecimal;
import java.time.LocalDateTime;

public class OrderTable {
    private int orderId; // Primary Key
    private int userId; // Foreign Key referencing User
    private int restaurantId; // Foreign Key referencing Restaurant
    private LocalDateTime orderDate; // Date and time when the order was placed
    private BigDecimal totalAmount; // Total amount for the order
    private Status status; // Status of the order (e.g., PENDING, CONFIRMED, DELIVERED)
    private PaymentMethod paymentMethod; // Payment method used for the order (e.g., CASH, CREDIT_CARD, UPI)
    private String deliveryAddress;

    public enum Status {
        PENDING, CONFIRMED, PREPARING, OUT_FOR_DELIVERY, DELIVERED, CANCELLED
    }

    public enum PaymentMethod {
        CASH, ONLINE
    }

    // Default Constructor
    public OrderTable() {
    }

    // Parameterized Constructor
    public OrderTable(int userId, LocalDateTime orderDate, BigDecimal totalAmount,
                      Status status, PaymentMethod paymentMethod, int restaurantId) {
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.paymentMethod = paymentMethod;
        this.restaurantId = restaurantId;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public LocalDateTime getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(LocalDateTime orderDate) {
        this.orderDate = orderDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public PaymentMethod getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(PaymentMethod paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public int getRestaurantId() {
        return restaurantId;
    }

    public void setRestaurantId(int restaurantId) {
        this.restaurantId = restaurantId;
    }
    
    public String getDeliveryAddress() { 
    	return deliveryAddress; 
    }
    
    public void setDeliveryAddress(String deliveryAddress) { 
    	this.deliveryAddress = deliveryAddress; 
    }

    @Override
    public String toString() {
        return "OrderTable [orderId=" + orderId + ", userId=" + userId + ", orderDate=" + orderDate
                + ", totalAmount=" + totalAmount + ", status=" + status + ", paymentMethod="
                + paymentMethod + ", restaurantId=" + restaurantId + ",deliveryAddress="+ deliveryAddress +"]";
    }
}
