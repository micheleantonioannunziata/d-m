package controller.master;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Utente;

import java.io.IOException;

@WebFilter(filterName = "/AccessControlFilter", urlPatterns = "/*")
public class AccessControlFilter  extends HttpFilter implements Filter {

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) req;
        HttpServletResponse httpServletResponse = (HttpServletResponse) res;

        Utente utente = (Utente) httpServletRequest.getSession().getAttribute("utente");

        String path = httpServletRequest.getServletPath();

        if ((path.contains("login.jsp") || path.contains("signup.jsp")) && utente != null) {
            httpServletResponse.sendRedirect("redirectToUserArea");
            return;
        }

        if (path.contains("userArea.jsp") && utente != null) {
            httpServletResponse.sendRedirect("index.jsp");
            return;
        }



        chain.doFilter(req, res);
    }
}
