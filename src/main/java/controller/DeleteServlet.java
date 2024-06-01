package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;

@WebServlet(name = "deleteServlet", value = "/delete-servlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tabella = request.getParameter("tabella");

        switch (tabella.toLowerCase()) {
            case "squadre" -> {
                String id = request.getParameter("idSquadra");

                SquadraDAO squadraDAO = new SquadraDAO();
                squadraDAO.doDelete(id);
                getServletContext().setAttribute("squadre", squadraDAO.doRetrieveAll());
            }
            case "utenti" -> {
                int id = Integer.parseInt(request.getParameter("idUtente"));

                UtenteDAO utenteDAO = new UtenteDAO();
                utenteDAO.doDelete(id);
            }
            case "ordini" -> {
                int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
                int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
                int idUtente = Integer.parseInt(request.getParameter("idUtente"));
                String taglia = request.getParameter("taglia");

                OrdineDAO ordineDAO = new OrdineDAO();
                ordineDAO.doDelete(idOrdine, idProdotto, idUtente, taglia);
            }
            case "prodotti" -> {
                int id = Integer.parseInt(request.getParameter("idProdotto"));

                ProdottoDAO prodottoDAO = new ProdottoDAO();
                prodottoDAO.doDelete(id);
            }
            case "taglie" -> {
                String id = request.getParameter("idTaglia");

                TagliaDAO tagliaDAO = new TagliaDAO();
                tagliaDAO.doDelete(id);
                getServletContext().setAttribute("taglie", tagliaDAO.doRetrieveAll());
            }
            case "prodottitaglie" -> {
                String taglia = request.getParameter("taglia");
                int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));

                ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();
                prodottoTaglieDAO.doDelete(idProdotto, taglia);
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("admin-servlet");
        dispatcher.forward(request, response);
    }
}
