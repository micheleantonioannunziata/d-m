package controller.common;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import model.ProdottoDAO;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet(name = "updateCardsServlet", value = "/updateCards-servlet")
public class UpdateCardsServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ottieni tutte le info
        String taglia = request.getParameter("taglia");
        String squadra = request.getParameter("squadra");
        String tipologia = request.getParameter("tipologia");
        String produttore = request.getParameter("produttore");
        String collezione = request.getParameter("collezione");

        String rangePrice = request.getParameter("prezzo");

        ProdottoDAO prodottoDAO = new ProdottoDAO();

        // prendi dati dal db
        List<Prodotto> prodottiFiltrati = prodottoDAO.doRetrieveByAll(taglia, squadra, tipologia, produttore, collezione, rangePrice);

        JSONArray prodotti = new JSONArray();

        // formatta in json
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        for (Prodotto prodotto : prodottiFiltrati) {
            JSONObject object = new JSONObject();
            object.put("id", prodotto.getId_Prodotto());
            object.put("nome", prodotto.getNome());
            object.put("prezzo", prodotto.getPrezzo());
            object.put("urlImmagine", prodotto.getUrlImmagine());
            prodotti.add(object);
        }

        // scrivi nella risposta
        out.print(prodotti);
        out.flush();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
