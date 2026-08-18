import java.time.LocalDateTime;

import dao.impl.MenuDAOImpl;
import dao.impl.UserDAOImpl;
import entity.User;

public class Test {
	public static void main(String[] args) {
//		UserDAOImpl userDAO = new UserDAOImpl();
//		User user = new User();
		
//		user.setUsername("testy");
//		user.setPassword("password1");
//		user.setEmail("testy.test2@gamil.com");
//		user.setAddress("1234-Street New York London");
//		user.setRole(User.Role.ADMIN);
		
		MenuDAOImpl menu = new MenuDAOImpl();
		System.out.println(menu.getAllMenus());
		
	}
}
