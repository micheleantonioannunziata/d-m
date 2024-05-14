package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "filterServlet", value = "/filter-servlet")
public class FilterServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taglia = request.getParameter("taglia");
        String squadra = request.getParameter("squadra");
        String tipologia = request.getParameter("tipologia");
        String produttore = request.getParameter("produttore");
        String collezione = request.getParameter("collezione");

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodottiFiltrati = prodottoDAO.doRetrieveByAll(taglia, squadra, tipologia, produttore, collezione);

        request.setAttribute("prodottiFiltrati", prodottiFiltrati);

        RequestDispatcher dispatcher = request.getRequestDispatcher("gridItemByFilter.jsp");
        dispatcher.forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }


}
