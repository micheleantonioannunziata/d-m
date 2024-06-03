package controller;

import java.io.*;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import model.Ordine;
import model.OrdineDAO;
import model.Utente;
import model.UtenteDAO;
import org.json.simple.JSONObject;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {

    /*  doGet non ajax
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UtenteDAO service = new UtenteDAO();
        String errorMessage = "";
        JSONObject object = new JSONObject();

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean exists = service.existsByUsername(username);


        if (!exists)    errorMessage = "no user";
        else {
            Utente utente = service.doRetrieveByUsernamePassword(username, password);

            if (utente == null) errorMessage = "wrong password";
            else    request.getSession().setAttribute("utente", utente);
        }


        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        object.put("errorMessage", errorMessage);

        out.println(object);
        out.flush();
    } */

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        UtenteDAO service = new UtenteDAO();
        String address = "";

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        boolean exists = service.existsByUsername(username);

        if (!exists) {
            request.setAttribute("error", "no user");
            address = "login.jsp";
        }
        else {
            Utente utente = service.doRetrieveByUsernamePassword(username, password);
            if (utente == null) {
                request.setAttribute("error", "password wrong");
                address = "login.jsp";
            }
            else {
                // aggiungi bean
                request.getSession().setAttribute("utente", utente);
                address = "userArea.jsp";
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher(address);
        dispatcher.forward(request, response);
    }


    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        doGet(request, response);
    }

    public void destroy() {
    }
}