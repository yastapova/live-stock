package org.o7planning.tutorial.servlet.other;
 
import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.o7planning.tutorial.beans.Constants;
 
@WebServlet("/other/forwardDemo")
public class ForwardDemoServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;
 
   @Override
   protected void doGet(HttpServletRequest request,
           HttpServletResponse response) throws ServletException, IOException {
       // Get parameter on URL      
       // http://localhost:8080/ServletTutorial/other/forwardDemo?forward=true        
       String forward = request.getParameter("forward");
 
       if ("true".equals(forward)) {
           System.out.println("Forward to ShowMeServlet");
 
           // Send data to next page (page forward to)
           request.setAttribute(Constants.ATTRIBUTE_USER_NAME_KEY,
                   "Hi, I'm Tom come from Walt Disney !");
 
           RequestDispatcher dispatcher = request.getServletContext()
                   .getRequestDispatcher("/other/showMe");
           dispatcher.forward(request, response);
 
           return;
       }
       ServletOutputStream out = response.getOutputStream();
       out.println("<h3>Text of ForwardDemoServlet</h3>");
       out.println("- servletPath=" + request.getServletPath());
   }
 
   @Override
   protected void doPost(HttpServletRequest request,
           HttpServletResponse response) throws ServletException, IOException {
       this.doGet(request, response);
   }
 
}