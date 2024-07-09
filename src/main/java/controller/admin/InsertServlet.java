package controller.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Helper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "InsertServlet",value = "/insert-servlet")
public class InsertServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // ottieni tabella
        String tabella = req.getParameter("tabella");

        // ottieni colonne (con tipi dati associati) della tabella
        Map<String,String> columnDataType = Helper.doRetrieveColumnDataType(tabella);

        // setta attributi nella request
        req.setAttribute("colonneTipi", columnDataType);
        req.setAttribute("tabella", tabella);

        // ridirotta
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/adminArea/insertPage.jsp");
        dispatcher.forward(req,resp);
    }
}
