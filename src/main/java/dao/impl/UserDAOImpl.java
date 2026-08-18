package dao.impl;

import dao.UserDAO;
import entity.User;
import util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {

    @Override
    public boolean registerUser(User user) {
        String sql = "INSERT INTO User (Username, Password, Email, Address, Role, CreatedDate) VALUES (?, ?, ?, ?, ?, NOW())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        	conn.setAutoCommit(false); // Start transaction
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getRole() != null ? user.getRole() : "CUSTOMER");
            
            
            int rowsAffected = ps.executeUpdate();
            conn.commit(); // Commit transaction
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
        	System.err.println("registerUser error: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public User getUserById(int userId) {
        String sql = "SELECT * FROM User WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
            	if (rs.next()) {
            	    return extractUserFromResultSet(rs);
            	}
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Check if user-name is exist
    @Override
    public boolean isUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM User WHERE Username = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, username.trim());
            try (ResultSet rs = ps.executeQuery()) {
            	
            	if (rs.next()) {
            		return rs.getInt(1) > 0;
            	}
            }

        } catch (SQLException e) {
            System.err.println("isUsernameExists error: " + e.getMessage());
        }
        return false;
    }

    // Check if email exists
    @Override
    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM User WHERE Email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            
            try (ResultSet rs = ps.executeQuery()) {
            	
            	if (rs.next()) {
            		return rs.getInt(1) > 0;
            	}
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM User ORDER BY UserID ASC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {
        	
            while (rs.next()) {
                users.add(extractUserFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public int updateUser(User user) {
        String sql = "UPDATE User SET Username = ?, Password = ?, Email = ?, Address = ?, Role = ?, LastLoginDate = ? WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getAddress());
            ps.setString(5, user.getRole());
            ps.setTimestamp(6, user.getLastLoginDate() != null ? Timestamp.valueOf(user.getLastLoginDate()) : null);
            ps.setInt(7, user.getUserId());

            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public int deleteUser(int userId) {
        String sql = "DELETE FROM User WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Login - Authenticate user by username/email + password
    @Override
    public User validateUser(String usernameOrEmail, String password) {
        String sql = "SELECT * FROM User WHERE (Username = ? OR Email = ?) AND Password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, usernameOrEmail.trim());
            ps.setString(2, usernameOrEmail.trim());
            ps.setString(3, password);
            
            try(ResultSet rs = ps.executeQuery()) {
            	if (rs.next()) {
            		User user =  extractUserFromResultSet(rs);
            		
            		// User last login
            		updateLastLoginDate(user.getUserId());
            		
            		System.out.println("Login successful: " + user.getUsername());
            		return user;
            	}
            }

        } catch (SQLException e) {
        	System.err.println("Login error: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("Login failed for: " + usernameOrEmail);
        return null;
    }

    // Update last login date
    @Override
    public boolean updateLastLoginDate(int userId) {
        String sql = "UPDATE User SET LastLoginDate = NOW() WHERE UserID = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("updateLastLogin error: " + e.getMessage());
        }
        return false;
    }

    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("UserID"));
        user.setUsername(rs.getString("Username"));
        user.setPassword(rs.getString("Password"));
        user.setEmail(rs.getString("Email"));
        user.setAddress(rs.getString("Address"));
        user.setRole(User.Role.valueOf(rs.getString("Role")));

        Timestamp createdDate = rs.getTimestamp("CreatedDate");
        if (createdDate != null) {
            user.setCreatedDate(createdDate.toLocalDateTime());
        }

        Timestamp lastLoginDate = rs.getTimestamp("LastLoginDate");
        if (lastLoginDate != null) {
            user.setLastLoginDate(lastLoginDate.toLocalDateTime());
        }

        return user;
    }
}
