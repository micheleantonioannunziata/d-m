package controller;

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
import java.util.List;

@WebServlet(name = "showFilterServlet", value = "/showFilter-servlet")
public class ShowFilterServlet extends HttpServlet {
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipologia = request.getParameter("tipologia");
        ProdottoDAO prodottoDAO = new ProdottoDAO();
        TagliaDAO tagliaDAO = new TagliaDAO();

        // prendi taglie, produttori e collezioni di quella tipologia
        List<Taglia> taglieFiltrate = tagliaDAO.doRetrieveByTipologia(tipologia);
        List<String> produttoriFiltrati = prodottoDAO.doRetrieveColumnByCriteria("produttore", "tipologia", tipologia);
        List<String> collezioneFiltrate = prodottoDAO.doRetrieveColumnByCriteria("collezione", "tipologia", tipologia);


        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        JSONObject result = new JSONObject();
        JSONArray taglie = new JSONArray(),
                collezioni = new JSONArray(), produttori = new JSONArray();

        for (Taglia t : taglieFiltrate) {
            JSONObject object = new JSONObject();
            object.put("taglia", t.getTaglia());
            taglie.add(object);
        }

        for (String c: collezioneFiltrate) {
            JSONObject object = new JSONObject();
            object.put("nome", c);
            collezioni.add(object);
        }

        for (String p: produttoriFiltrati) {
            JSONObject object = new JSONObject();
            object.put("nome", p);
            produttori.add(object);
        }

        // oggetto json con tre array
        result.put("taglie", taglie);
        result.put("collezioni", collezioni);
        result.put("produttori", produttori);

        out.print(result);
        out.flush();
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }


}
