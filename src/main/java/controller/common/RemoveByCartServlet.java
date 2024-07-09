package controller.common;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Prodotto;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

@WebServlet(name = "RemoveByCart", value = "/removeByCart-servlet")
public class RemoveByCartServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Prodotto> carrello = (List<Prodotto>) req.getSession().getAttribute("carrello");

        // ottieni info dalla richiesta
        int id = Integer.parseInt(req.getParameter("idProdotto"));
        String taglia = req.getParameter("taglia");

        // se c'è qualcosa nel carrello
        if (carrello != null && !carrello.isEmpty()) {
            boolean flag = false;

            for (Prodotto p : carrello) {

                // rimuovi taglia del prodotto indicato
                for (Map.Entry<String, Integer> entry : p.getTaglieQuantita().entrySet()) {
                    if (p.getId_Prodotto() == id && taglia.equalsIgnoreCase(entry.getKey())) {
                        p.getTaglieQuantita().remove(entry.getKey());
                        flag = true;
                        break;
                    }

                    // se non ci sono più taglie per quel prodotto
                    if (flag && p.getTaglieQuantita().isEmpty()) {
                        // rimuovilo dal carrello
                        carrello.remove(p);
                        break;
                    }
                }
            }
        }

        // aggiorna carrello in sessione
        req.getSession().setAttribute("carrello", carrello);

        /* invio dati con ajax
        JSONArray prodotti = new JSONArray();

        resp.setContentType("application/json");
        PrintWriter out = resp.getWriter();

        for (Prodotto prodotto : carrello) {
            JSONObject object = new JSONObject();
            object.put("id", prodotto.getId_Prodotto());
            object.put("nome", prodotto.getNome());
            object.put("prezzo", prodotto.getPrezzo());
            object.put("urlImmagine", prodotto.getUrlImmagine());

            JSONArray array = new JSONArray();
            for(Map.Entry<String,Integer> entry : prodotto.getTaglieQuantita().entrySet()){
                JSONObject object1 = new JSONObject();
                object1.put("taglia",entry.getKey());
                object1.put("quantita",entry.getValue());
                array.add(object1);
            }

            object.put("taglieQuantita", array);
            prodotti.add(object);
        }

        out.print(prodotti);
        out.flush();*/

        // ridirotta
        RequestDispatcher dispatcher = req.getRequestDispatcher("myCart.jsp");
        dispatcher.forward(req, resp);
    }
}
