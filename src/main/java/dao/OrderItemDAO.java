package dao;

import entity.OrderItem;
import java.util.List;

public interface OrderItemDAO {
	
    int addOrderItem(OrderItem orderItem); 
    
    OrderItem getOrderItemById(int orderItemId); 
    
    List<OrderItem> getAllOrderItems(); 
    
    List<OrderItem> getOrderItemsByOrderId(int orderId);
    
    int updateOrderItem(OrderItem orderItem);
    
    int deleteOrderItem(int orderItemId); 
    
    int deleteOrderItemsByOrderId(int orderId); 
}
