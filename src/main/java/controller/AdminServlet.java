package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminServlet", value = "/admin-servlet")
public class AdminServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ottieni bean
        Utente u = (Utente) request.getSession().getAttribute("utente");

        // se è un utente amministratore ok
        if (u.isAdmin()) doPost(request, response);

        // altrimenti non è ok
        else response.sendRedirect("index.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ottieni tutti i dati del db per ciascuna tabella
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        List<Prodotto> prodotti = prodottoDAO.doRetrieveAll();

        UtenteDAO utenteDAO = new UtenteDAO();
        List<Utente> utenti  = utenteDAO.doRetrieveAll();

        OrdineDAO ordineDAO = new OrdineDAO();
        List<Ordine> ordini = ordineDAO.doRetrieveAll();

        ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();
        List<ProdottoTaglie> prodottiTaglie = prodottoTaglieDAO.doRetrieveAll();

        // setta nella richiesta
        request.setAttribute("prodotti", prodotti);
        request.setAttribute("utenti", utenti);
        request.setAttribute("ordini", ordini);
        request.setAttribute("prodottitaglie", prodottiTaglie);

        // setta nella richiesta tutte le colonne (con i tipi associati) di ciascuna tabella
        request.setAttribute("columnDataTypeSquadre", Helper.doRetrieveColumnDataType("squadre"));
        request.setAttribute("columnDataTypeProdotti", Helper.doRetrieveColumnDataType("prodotti"));
        request.setAttribute("columnDataTypeProdottiTaglie", Helper.doRetrieveColumnDataType("prodottitaglie"));
        request.setAttribute("columnDataTypeOrdini", Helper.doRetrieveColumnDataType("ordini"));
        request.setAttribute("columnDataTypeUtenti", Helper.doRetrieveColumnDataType("utenti"));
        request.setAttribute("columnDataTypeTaglie", Helper.doRetrieveColumnDataType("taglie"));

        // ridirotta
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/adminArea/adminPage.jsp");
        dispatcher.forward(request, response);
    }
}

