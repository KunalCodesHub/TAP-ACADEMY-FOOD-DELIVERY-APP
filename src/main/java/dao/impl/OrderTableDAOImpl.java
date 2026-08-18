package dao.impl;

import dao.OrderTableDAO;
import entity.OrderTable;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderTableDAOImpl implements OrderTableDAO {

    @Override
    public int addOrder(OrderTable order) {
        String sql = "INSERT INTO ordertable (UserID, OrderDate, TotalAmount, Status, PaymentMethod, RestaurantID, DeliveryAddress) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate() != null ? order.getOrderDate() : java.time.LocalDateTime.now()));
            ps.setBigDecimal(3, order.getTotalAmount());
            ps.setString(4, order.getStatus().name());
            ps.setString(5, order.getPaymentMethod().name());
            ps.setInt(6, order.getRestaurantId());
            ps.setString(7, order.getDeliveryAddress());

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
    public OrderTable getOrderById(int orderId) {
        String sql = "SELECT * FROM ordertable WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return extractOrderFromResultSet(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<OrderTable> getAllOrders() {
        List<OrderTable> orders = new ArrayList<>();
        String sql = "SELECT * FROM ordertable";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<OrderTable> getOrdersByUserId(int userId) {
        List<OrderTable> orders = new ArrayList<>();
        String sql = "SELECT * FROM ordertable WHERE UserID = ? ORDER BY OrderDate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<OrderTable> getOrdersByRestaurantId(int restaurantId) {
        List<OrderTable> orders = new ArrayList<>();
        String sql = "SELECT * FROM ordertable WHERE RestaurantID = ? ORDER BY OrderDate DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, restaurantId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public List<OrderTable> getOrdersByStatus(OrderTable.Status status) {
        List<OrderTable> orders = new ArrayList<>();
        String sql = "SELECT * FROM ordertable WHERE Status = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.name());
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                orders.add(extractOrderFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    @Override
    public int updateOrder(OrderTable order) {
        String sql = "UPDATE ordertable SET UserID = ?, OrderDate = ?, TotalAmount = ?, Status = ?, PaymentMethod = ?, RestaurantID = ? WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, order.getUserId());
            ps.setTimestamp(2, Timestamp.valueOf(order.getOrderDate()));
            ps.setBigDecimal(3, order.getTotalAmount());
            ps.setString(4, order.getStatus().name());
            ps.setString(5, order.getPaymentMethod().name());
            ps.setInt(6, order.getRestaurantId());
            ps.setInt(7, order.getOrderId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int updateOrderStatus(int orderId, OrderTable.Status status) {
        String sql = "UPDATE ordertable SET Status = ? WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status.name());
            ps.setInt(2, orderId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteOrder(int orderId) {
        String sql = "DELETE FROM ordertable WHERE OrderID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    private OrderTable extractOrderFromResultSet(ResultSet rs) throws SQLException {
        OrderTable order = new OrderTable();
        order.setOrderId(rs.getInt("OrderID"));
        order.setUserId(rs.getInt("UserID"));

        Timestamp orderDate = rs.getTimestamp("OrderDate");
        if (orderDate != null) {
            order.setOrderDate(orderDate.toLocalDateTime());
        }

        order.setTotalAmount(rs.getBigDecimal("TotalAmount"));
        order.setStatus(OrderTable.Status.valueOf(rs.getString("Status")));
        order.setPaymentMethod(OrderTable.PaymentMethod.valueOf(rs.getString("PaymentMethod")));
        order.setRestaurantId(rs.getInt("RestaurantID"));
        order.setDeliveryAddress(rs.getString("DeliveryAddress"));
        return order;
    }
}