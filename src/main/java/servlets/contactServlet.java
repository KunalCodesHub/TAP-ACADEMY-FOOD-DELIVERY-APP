package servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet("/contact")
public class contactServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// call contact jsp
		request.getRequestDispatcher("/contact.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String name    = request.getParameter("name");
		String email   = request.getParameter("email");
		String subject = request.getParameter("subject");
		String message = request.getParameter("message");
		
		if (name == null || email == null || subject == null || message == null
		 || name.trim().isEmpty() || email.trim().isEmpty() || subject.trim().isEmpty() || message.trim().isEmpty()) {
			request.setAttribute("errorMsg", "Please fill in all fields before submitting.");
			request.getRequestDispatcher("/contact.jsp").forward(request, response);
			return;
		}
		
		System.out.println("=== Contact Form Submission ===");
        System.out.println("Name:    " + name);
        System.out.println("Email:   " + email);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);
        System.out.println("================================");
        
        request.setAttribute("successMsg", "Thanks "+ name +"! Your message has been received. We'll get back to you soon.");
        request.getRequestDispatcher("/contact.jsp").forward(request, response);
		
	}

}
