package dao.impl;

import dao.MenuDAO;
import entity.Menu;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAOImpl implements MenuDAO {

    @Override
    public int addMenu(Menu menu) {
        String sql = "INSERT INTO Menu (RestaurantID, ItemName, Description, Price, IsAvailable, ImagePath, isVeg) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getDescription());
            ps.setBigDecimal(4, menu.getPrice());
            ps.setBoolean(5, menu.isAvailable());
            ps.setString(6, menu.getImagePath());
            ps.setInt(7, menu.getIsVeg());

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
    public Menu getMenuById(int menuId) {
        String sql = "SELECT * FROM Menu WHERE MenuID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, menuId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractMenuFromResultSet(rs);
            }
        } catch (SQLException e) {
        	System.err.println("MenuDAOImpl.getMenuById: " + e.getMessage());
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Menu> getAllMenus() {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM Menu WHERE IsAvailable = 1 ORDER BY MenuID";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                menus.add(extractMenuFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public List<Menu> getMenusByRestaurantId(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM Menu WHERE RestaurantID = ? ORDER BY ItemName ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                menus.add(extractMenuFromResultSet(rs));
            }
        } catch (SQLException e) {
        	System.err.println("MenuDAOImpl.getMenuByRestaurantId: " + e.getMessage());
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public List<Menu> getAvailableMenusByRestaurantId(int restaurantId) {
        List<Menu> menus = new ArrayList<>();
        String sql = "SELECT * FROM Menu WHERE RestaurantID = ? AND IsAvailable = true";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                menus.add(extractMenuFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return menus;
    }

    @Override
    public int updateMenu(Menu menu) {
        String sql = "UPDATE Menu SET RestaurantID = ?, ItemName = ?, Description = ?, Price = ?, IsAvailable = ?, ImagePath = ?, isVeg = ? WHERE MenuID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, menu.getRestaurantId());
            ps.setString(2, menu.getItemName());
            ps.setString(3, menu.getDescription());
            ps.setBigDecimal(4, menu.getPrice());
            ps.setBoolean(5, menu.isAvailable());
            ps.setString(6, menu.getImagePath());
            ps.setInt(7, menu.getIsVeg());
            ps.setInt(8, menu.getMenuId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteMenu(int menuId) {
        String sql = "DELETE FROM Menu WHERE MenuID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, menuId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private Menu extractMenuFromResultSet(ResultSet rs) throws SQLException {
        Menu menu = new Menu();
        menu.setMenuId(rs.getInt("MenuID"));
        menu.setRestaurantId(rs.getInt("RestaurantID"));
        menu.setItemName(rs.getString("ItemName"));
        menu.setDescription(rs.getString("Description"));
        menu.setPrice(rs.getBigDecimal("Price"));
        menu.setAvailable(rs.getBoolean("IsAvailable"));
        menu.setImagePath(rs.getString("ImagePath"));
        menu.setIsVeg(rs.getInt("isVeg"));
        return menu;
    }
}