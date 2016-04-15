package org.o7planning.tutorial.servlet.other;
 
import java.io.IOException;
 
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
@WebServlet("/other/redirectDemo")
public class RedirectDemoServlet extends HttpServlet {
 
   private static final long serialVersionUID = 1L;
 
   @Override
   protected void doGet(HttpServletRequest request,
           HttpServletResponse response) throws ServletException, IOException {
       // Get parameter on the URL
       // http://localhost:8080/ServletTutorial/other/redirectDemo?redirect=true
       String redirect = request.getParameter("redirect");
 
       if ("true".equals(redirect)) {
           System.out.println("Redirect to ShowMeServlet");
           // ContextPath always be "" or "/contextPath".    
 
           String contextPath = request.getContextPath();
      
           // ==> /ServletTutorial/other/showMe
           response.sendRedirect(contextPath + "/other/showMe");
           return;
       }
 
       ServletOutputStream out = response.getOutputStream();
       out.println("<h3>Text of RedirectDemoServlet</h3>");
       out.println("- servletPath=" + request.getServletPath());
   }
 
   @Override
   protected void doPost(HttpServletRequest request,
           HttpServletResponse response) throws ServletException, IOException {
       this.doGet(request, response);
   }
 
}