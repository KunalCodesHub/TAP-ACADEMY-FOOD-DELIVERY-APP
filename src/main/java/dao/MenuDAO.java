package dao;

import entity.Menu;
import java.util.List;

public interface MenuDAO {
	
    int addMenu(Menu menu); 
    
    Menu getMenuById(int menuId); 
    
    List<Menu> getAllMenus();
    
    List<Menu> getMenusByRestaurantId(int restaurantId); 
    
    List<Menu> getAvailableMenusByRestaurantId(int restaurantId);
    
    int updateMenu(Menu menu); 
    
    int deleteMenu(int menuId); 
}
