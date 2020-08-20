package HelloLucene;

import java.io.IOException;
import java.io.File;
import java.util.List;

import com.google.gson.*;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*; 
import javax.servlet.http.*;

public class Suggestions extends HttpServlet {
	private static autoComp ac;
	private static boolean init;
	private static final boolean DEBUG = false;
	
    @Override
    protected void doGet(final HttpServletRequest request, final HttpServletResponse response)
            throws ServletException, IOException {
				
		ServletContext servletContext = getServletContext();
		String contextPath = servletContext.getRealPath(File.separator);
		contextPath += "\\WEB-INF\\";
		
		if(DEBUG)
				System.out.println(contextPath);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
		if(DEBUG)
				System.out.println(init);
		if(!init){
			ac = new autoComp();
			ac.init(contextPath);
			request.setAttribute("0000", ac);
			request.getSession().setAttribute("0000", ac);
			this.getServletConfig().getServletContext().setAttribute("0000", ac);
			init = true;
			if(DEBUG)
				System.out.println("Suggestions.class init complete");
		}

        String term = request.getParameter("term");
        String q = term.toLowerCase();

        List<String> sugList = ac.auto(q, false);
		
		if(DEBUG)
			System.out.println("List in Suggesiotns "+sugList);
		
        response.getWriter().write(new Gson().toJson(sugList));
    }
}