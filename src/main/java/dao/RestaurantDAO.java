package dao;

import entity.Restaurant;
import java.util.List;

public interface RestaurantDAO {
	
    int addRestaurant(Restaurant restaurant);
    
    int updateRestaurant(Restaurant restaurant); 
    
    int deleteRestaurant(int restaurantId);
    
    List<Restaurant> getAllRestaurants(); 
    
    List<Restaurant> getActiveRestaurants(); 
    
    List<Restaurant> getRestaurantsByCuisineType(String cuisineType);
    
    Restaurant getRestaurantById(int restaurantId); 
}
