package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Helper;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet(name = "InsertDataServlet",value="/insert-data")
public class InsertDataServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tabella = req.getParameter("tabella");
        Helper helper = new Helper();
        Map<String,String> colonne = helper.doRetrieveColumnType(tabella);
        for(Map.Entry<String, String> entry : colonne.entrySet()){

        }
    }
}
