package dao;

import entity.OrderTable;
import java.util.List;

public interface OrderTableDAO {
	
    int addOrder(OrderTable order);
    
    int updateOrder(OrderTable order);
    
    int updateOrderStatus(int orderId, OrderTable.Status status);
    
    int deleteOrder(int orderId);
    
    List<OrderTable> getAllOrders(); 
    
    List<OrderTable> getOrdersByUserId(int userId); 
    
    List<OrderTable> getOrdersByRestaurantId(int restaurantId); 
    
    List<OrderTable> getOrdersByStatus(OrderTable.Status status);
    
    OrderTable getOrderById(int orderId);
}