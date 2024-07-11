package controller.common;

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
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@WebServlet(name = "showFilterServlet", value = "/showFilter-servlet")
public class ShowFilterServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // ottieni tipologia dalla richiesta
        String tipologia = request.getParameter("tipologia");

        ProdottoDAO prodottoDAO = new ProdottoDAO();
        TagliaDAO tagliaDAO = new TagliaDAO();

        // prendi taglie, produttori e collezioni di quella tipologia

        List<Taglia> taglieFiltrate;
        List<String> produttoriFiltrati, collezioniFiltrate;

        if (tipologia.equalsIgnoreCase("all")) {
            taglieFiltrate = tagliaDAO.doRetrieveAll();
            produttoriFiltrati = prodottoDAO.doRetrieveColumnByCriteria("produttore", "1", "1");
            collezioniFiltrate = prodottoDAO.doRetrieveColumnByCriteria("collezione", "1", "1");
        } else {
            taglieFiltrate = tagliaDAO.doRetrieveByTipologia(tipologia);
            produttoriFiltrati = prodottoDAO.doRetrieveColumnByCriteria("produttore", "tipologia", tipologia);
            collezioniFiltrate = prodottoDAO.doRetrieveColumnByCriteria("collezione", "tipologia", tipologia);
        }

        taglieFiltrate.sort(Comparator.comparing(Taglia::getTaglia));
        produttoriFiltrati.sort(String::compareToIgnoreCase);
        collezioniFiltrate.sort(String::compareToIgnoreCase);

        Taglia all = new Taglia();
        all.setTaglia("All");
        taglieFiltrate.add(0, all);

        produttoriFiltrati.add(0, "All");
        collezioniFiltrate.add(0, "All");

        // prepara per scrivere nella response
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONObject result = new JSONObject();
        JSONArray taglie = new JSONArray(),
                collezioni = new JSONArray(), produttori = new JSONArray();

        // formatta le taglie in array json
        for (Taglia t : taglieFiltrate) {
            JSONObject object = new JSONObject();
            object.put("taglia", t.getTaglia());
            taglie.add(object);
        }

        // formatta collezioni in array json
        for (String c: collezioniFiltrate) {
            JSONObject object = new JSONObject();
            object.put("nome", c);
            collezioni.add(object);
        }

        // formatta prodttori in array json
        for (String p: produttoriFiltrati) {
            JSONObject object = new JSONObject();
            object.put("nome", p);
            produttori.add(object);
        }

        // poni tutto in un oggetto
        result.put("taglie", taglie);
        result.put("collezioni", collezioni);
        result.put("produttori", produttori);

        // scrivi nella risposta l'oggettone json
        out.print(result);
        out.flush();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }


}
