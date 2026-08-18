package dao;

import entity.User;
import java.util.List;

public interface UserDAO {

    boolean registerUser(User user); 

    boolean isUsernameExists(String username); 

    User validateUser(String username, String password); 

    boolean updateLastLoginDate(int userId);

    boolean isEmailExists(String email); 

    int updateUser(User user);

    int deleteUser(int userId);
    
    List<User> getAllUsers(); 
    
    User getUserById(int userId); 
}