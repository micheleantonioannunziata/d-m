package controller.common;

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
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "searchBarServlet", value = "/searchBar-servlet")
public class SearchBarServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // ottieni query string
        String queryString = request.getParameter("queryString");

        ProdottoDAO prodottoDAO = new ProdottoDAO();

        // ottieni flag
        String redirect = request.getParameter("redirect");

        // effettua query
        List<Prodotto> prodottiCercati = prodottoDAO.doRetrieveBySearch(queryString);

        // ordina prodotti in base al nome
        prodottiCercati.sort(Comparator.comparing(Prodotto::getNome));

        // se si arriva tramite il form - da una pagina diversa dai filtri
        if(redirect != null && redirect.equalsIgnoreCase("true")) {

            // metti nella richiesta
            request.setAttribute("prodottiCercati", prodottiCercati);

            // ridirotta
            RequestDispatcher dispatcher = request.getRequestDispatcher("gridItemByFilter.jsp");
            dispatcher.forward(request, response);
        }

        // se si arriva tramite input con chiamata ajax dalla pagina dei filtri
        else {

            // bisogna scrivere l'oggett json nella risposta
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();

            // formatta in un array json
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

