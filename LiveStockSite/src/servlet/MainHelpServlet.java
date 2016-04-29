package servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import general.CustomerAccount;
import general.UserAccount;
import utils.MyUtils;

@WebServlet(urlPatterns = { "/main_help" })
public class MainHelpServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	public MainHelpServlet()
	{
		super();
	}

	@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
		// Forward to main help
        RequestDispatcher dispatcher = this.getServletContext().getRequestDispatcher("/WEF-INF/views/main_help.jsp");
        dispatcher.forward(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
