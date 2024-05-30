package controller;

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
        String tabella = req.getParameter("tabella");
        Map<String,String> colonneTipi = Helper.doRetrieveColumnDataType(tabella);

        req.setAttribute("colonneTipi",colonneTipi);
        req.setAttribute("tabella",tabella);

        RequestDispatcher dispatcher = req.getRequestDispatcher("insertPage.jsp");
        dispatcher.forward(req,resp);
    }
}
