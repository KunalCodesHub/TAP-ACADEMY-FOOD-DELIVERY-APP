package dao.impl;

import dao.RestaurantDAO;
import entity.Restaurant;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAOImpl implements RestaurantDAO {

    @Override
    public int addRestaurant(Restaurant restaurant) {
        String sql = "INSERT INTO Restaurant (Name, CuisineType, DeliveryTime, Address, Rating, IsActive, ImagePath) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setInt(3, restaurant.getDeliveryTime());
            ps.setString(4, restaurant.getAddress());
            ps.setBigDecimal(5, restaurant.getRating());
            ps.setBoolean(6, restaurant.isActive());
            ps.setString(7, restaurant.getImagePath());

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public Restaurant getRestaurantById(int restaurantId) {
        String sql = "SELECT * FROM Restaurant WHERE RestaurantID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractRestaurantFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM Restaurant WHERE IsActive = 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                restaurants.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public List<Restaurant> getActiveRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM Restaurant WHERE IsActive = true";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                restaurants.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public List<Restaurant> getRestaurantsByCuisineType(String cuisineType) {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM Restaurant WHERE IsActive = 1 AND CuisineType = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, cuisineType);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                restaurants.add(extractRestaurantFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return restaurants;
    }

    @Override
    public int updateRestaurant(Restaurant restaurant) {
        String sql = "UPDATE Restaurant SET Name = ?, CuisineType = ?, DeliveryTime = ?, Address = ?, Rating = ?, IsActive = ?, ImagePath = ? WHERE RestaurantID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, restaurant.getName());
            ps.setString(2, restaurant.getCuisineType());
            ps.setInt(3, restaurant.getDeliveryTime());
            ps.setString(4, restaurant.getAddress());
            ps.setBigDecimal(5, restaurant.getRating());
            ps.setBoolean(6, restaurant.isActive());
            ps.setString(7, restaurant.getImagePath());
            ps.setInt(8, restaurant.getRestaurantId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteRestaurant(int restaurantId) {
        String sql = "DELETE FROM Restaurant WHERE RestaurantID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Restaurant extractRestaurantFromResultSet(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurantId(rs.getInt("RestaurantID"));
        restaurant.setName(rs.getString("Name"));
        restaurant.setCuisineType(rs.getString("CuisineType"));
        restaurant.setDeliveryTime(rs.getInt("DeliveryTime"));
        restaurant.setAddress(rs.getString("Address"));
        restaurant.setRating(rs.getBigDecimal("Rating"));
        restaurant.setActive(rs.getBoolean("IsActive"));
        restaurant.setImagePath(rs.getString("ImagePath"));
        return restaurant;
    }
}