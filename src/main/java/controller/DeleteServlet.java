package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;

@WebServlet("/delete-servlet")
public class DeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String delete = req.getParameter("deletePar");

        switch (delete.toLowerCase()) {
            case "squadre" -> {
                String id = req.getParameter("idSquadra");
                SquadraDAO squadraDAO = new SquadraDAO();
                squadraDAO.doDelete(id);
                getServletContext().setAttribute("squadre", squadraDAO.doRetrieveAll());
            }
            case "utenti" -> {
                int id = Integer.parseInt(req.getParameter("idUtente"));
                UtenteDAO utenteDAO = new UtenteDAO();
                utenteDAO.doDelete(id);
            }
            case "ordini" -> {
                int idOrdine = Integer.parseInt(req.getParameter("idOrdine"));
                int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
                int idUtente = Integer.parseInt(req.getParameter("idUtente"));
                String taglia = req.getParameter("taglia");
                OrdineDAO ordineDAO = new OrdineDAO();
                ordineDAO.doDelete(idOrdine,idProdotto,idUtente,taglia);
            }
            case "prodotti" -> {
                int id = Integer.parseInt(req.getParameter("idProdotto"));
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                prodottoDAO.doDelete(id);
            }
            case "taglie" -> {
                String id = req.getParameter("idTaglia");
                TagliaDAO tagliaDAO = new TagliaDAO();
                tagliaDAO.doDelete(id);
                getServletContext().setAttribute("taglie", tagliaDAO.doRetrieveAll());
            }
            case "prodottitaglie" -> {
                String taglia = req.getParameter("taglia");
                int idProdotto = Integer.parseInt(req.getParameter("idProdotto"));
                ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();
                prodottoTaglieDAO.doDelete(idProdotto, taglia);
            }
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("admin-servlet");
        dispatcher.forward(req,resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req,resp);
    }
}
