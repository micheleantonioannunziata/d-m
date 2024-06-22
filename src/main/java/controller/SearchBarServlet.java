package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;
import model.Taglia;
import model.TagliaDAO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "searchBarServlet", value = "/searchBar-servlet")
public class SearchBarServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String queryString = request.getParameter("queryString");
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        String redirect = request.getParameter("redirect");

        List<Prodotto> prodottiCercati = prodottoDAO.doRetrieveBySearch(queryString);


        if(redirect != null && redirect.equalsIgnoreCase("true")) {
            request.setAttribute("prodottiCercati", prodottiCercati);


            RequestDispatcher dispatcher = request.getRequestDispatcher("gridItemByFilter.jsp");
            dispatcher.forward(request, response);
        }

        else {

            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            JSONArray result = new JSONArray();


            for (Prodotto prodotto : prodottiCercati) {
                JSONObject object = new JSONObject();
                object.put("id", prodotto.getId_Prodotto());
                object.put("nome", prodotto.getNome());
                object.put("prezzo", prodotto.getPrezzo());
                object.put("urlImmagine", prodotto.getUrlImmagine());
                result.add(object);
            }

            out.print(result);
            out.flush();
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }


}

