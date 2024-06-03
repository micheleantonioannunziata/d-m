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

@WebServlet(name = "AddToCart", value = "/addToCart-servlet")
public class AddToCart extends HttpServlet {

    boolean productAlreadyInCart(List<Prodotto> carrello, Prodotto p){
        for (Prodotto prodotto: carrello)
            if (prodotto.getId() == p.getId())
                return true;
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Prodotto> carrello = (List<Prodotto>) req.getSession().getAttribute("carrello");

        if (carrello == null)
            carrello = new ArrayList<>();

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        int id = Integer.parseInt(req.getParameter("idProdotto"));
        Prodotto p = prodottoDAO.doRetrieveById(id);

        if (!productAlreadyInCart(carrello, p))
            carrello.add(p);

        req.getSession().setAttribute("carrello", carrello);

        RequestDispatcher dispatcher = req.getRequestDispatcher("myCart.jsp");
        dispatcher.forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
