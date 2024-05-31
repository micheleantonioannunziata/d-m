package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Helper;
import model.Prodotto;
import model.ProdottoDAO;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "InsertDataServlet",value="/insert-data")
public class InsertDataServlet extends HttpServlet {
    public String getElementAt(Enumeration<String> enumeration, int index) {
        int currentIndex = 0;

        while (enumeration.hasMoreElements()) {
            String element = enumeration.nextElement();
            if (currentIndex == index) {
                return element;
            }
            currentIndex++;
        }
        return null;
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tabella = req.getParameter("tabella");
        Enumeration<String> colonne = req.getParameterNames();

        List<String> paramNames = new ArrayList<>();
        while (colonne.hasMoreElements()) {
            String paramName = colonne.nextElement();
            paramNames.add(paramName);
            System.out.println(paramName);
        }

        switch (tabella.toLowerCase()) {
            case "prodotti" -> {
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                Prodotto p = new Prodotto();

                for (int i = 1; i <= 7; i++) {
                    System.out.println("parametro: " + req.getParameter(paramNames.get(i)));
                }

                // Parto da 1 perché il primo è tabella
                p.setNome(req.getParameter(paramNames.get(1)));
                p.setPrezzo(Double.parseDouble(req.getParameter(paramNames.get(2))));
                p.setTipologia(req.getParameter(paramNames.get(3)));
                p.setSquadra(req.getParameter(paramNames.get(4)));
                p.setProduttore(req.getParameter(paramNames.get(5)));
                p.setCollezione(req.getParameter(paramNames.get(6)));
                p.setUrlImmagine(req.getParameter(paramNames.get(7)));

                prodottoDAO.doSave(p);
            }
        }

        RequestDispatcher dispatcher = req.getRequestDispatcher("admin-servlet");
        dispatcher.forward(req, resp);
    }

    // Metodo per ottenere l'elemento all'indice specificato di una lista
    public static String getElementAt(List<String> list, int index) {
        if (index >= 0 && index < list.size()) {
            return list.get(index);
        } else {
            return null;
        }
    }

}
