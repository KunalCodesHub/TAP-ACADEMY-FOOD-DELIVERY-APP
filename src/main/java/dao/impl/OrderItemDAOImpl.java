package dao.impl;

import dao.OrderItemDAO;
import entity.OrderItem;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderItemDAOImpl implements OrderItemDAO {

    @Override
    public int addOrderItem(OrderItem orderItem) {
        String sql = "INSERT INTO OrderItem (OrderID, Quantity, ItemTotal, MenuID) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getQuantity());
            ps.setBigDecimal(3, orderItem.getItemTotal());
            ps.setInt(4, orderItem.getMenuId());

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
    public OrderItem getOrderItemById(int orderItemId) {
        String sql = "SELECT * FROM OrderItem WHERE OrderItemID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderItemId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractOrderItemFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderItem> getAllOrderItems() {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM OrderItem";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    @Override
    public List<OrderItem> getOrderItemsByOrderId(int orderId) {
        List<OrderItem> orderItems = new ArrayList<>();
        String sql = "SELECT * FROM OrderItem WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orderItems.add(extractOrderItemFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderItems;
    }

    @Override
    public int updateOrderItem(OrderItem orderItem) {
        String sql = "UPDATE OrderItem SET OrderID = ?, Quantity = ?, ItemTotal = ?, MenuID = ? WHERE OrderItemID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderItem.getOrderId());
            ps.setInt(2, orderItem.getQuantity());
            ps.setBigDecimal(3, orderItem.getItemTotal());
            ps.setInt(4, orderItem.getMenuId());
            ps.setInt(5, orderItem.getOrderItemId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteOrderItem(int orderItemId) {
        String sql = "DELETE FROM OrderItem WHERE OrderItemID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderItemId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteOrderItemsByOrderId(int orderId) {
        String sql = "DELETE FROM OrderItem WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private OrderItem extractOrderItemFromResultSet(ResultSet rs) throws SQLException {
        OrderItem orderItem = new OrderItem();
        orderItem.setOrderItemId(rs.getInt("OrderItemID"));
        orderItem.setOrderId(rs.getInt("OrderID"));
        orderItem.setQuantity(rs.getInt("Quantity"));
        orderItem.setItemTotal(rs.getBigDecimal("ItemTotal"));
        orderItem.setMenuId(rs.getInt("MenuID"));
        return orderItem;
    }
}