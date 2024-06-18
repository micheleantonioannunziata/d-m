package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.util.Map;

@WebServlet(name = "UpdateServlet", value = "/update-servlet")
public class UpdateServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tabella = request.getParameter("tabella");
        Map<String,String> columnDataType = Helper.doRetrieveColumnDataType(tabella); //prendo i nomi delle colonne

        request.setAttribute("colonneTipi", columnDataType);
        request.setAttribute("tabella", tabella);

        switch (tabella.toLowerCase()) {
            case "squadre" -> {
                String id = request.getParameter("idSquadra");

                SquadraDAO squadraDAO = new SquadraDAO();
                request.setAttribute("bean", squadraDAO.doRetrieveByNome(id));
            }
            case "utenti" -> {
                int id = Integer.parseInt(request.getParameter("idUtente"));

                UtenteDAO utenteDAO = new UtenteDAO();
                request.setAttribute("bean", utenteDAO.doRetrieveById(id));
            }
            case "ordini" -> {
                int idOrdine = Integer.parseInt(request.getParameter("idOrdine"));
                int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));
                int idUtente = Integer.parseInt(request.getParameter("idUtente"));
                String taglia = request.getParameter("taglia");

                OrdineDAO ordineDAO = new OrdineDAO();
                request.setAttribute("bean", ordineDAO.doRetrieveByPrimaryKey(idOrdine, idUtente, idProdotto, taglia));
            }
            case "prodotti" -> {
                int id = Integer.parseInt(request.getParameter("idProdotto"));

                ProdottoDAO prodottoDAO = new ProdottoDAO();
                request.setAttribute("bean", prodottoDAO.doRetrieveById(id));
            }
            case "taglie" -> {
                String taglia = request.getParameter("idTaglia");

                TagliaDAO tagliaDAO = new TagliaDAO();
                request.setAttribute("bean", tagliaDAO.doRetrieveTaglia(taglia));
            }
            case "prodottitaglie" -> {
                String taglia = request.getParameter("taglia");
                int idProdotto = Integer.parseInt(request.getParameter("idProdotto"));

                ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();
                request.setAttribute("bean", prodottoTaglieDAO.doRetrieveByPrimaryKey(idProdotto, taglia));
            }
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("updatePage.jsp");
        dispatcher.forward(request, response);
    }
}
