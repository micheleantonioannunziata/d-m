package controller;

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

        int id = Integer.parseInt(req.getParameter("idProdotto"));
        String taglia = req.getParameter("taglia");

        // se c'è qualcosa nel carrello
        if (carrello != null && !carrello.isEmpty()) {
            boolean flag = false;

            // rimuovilo
            for (Prodotto p : carrello) {
                for (Map.Entry<String, Integer> entry : p.getTaglieQuantita().entrySet()) //rimuovo la taglia del prodotto selezionato
                    if (p.getId_Prodotto() == id && taglia.equalsIgnoreCase(entry.getKey())) {
                        p.getTaglieQuantita().remove(entry.getKey());
                        flag = true;
                        break;
                    }
                if (flag) { //se non ci sono più taglie di quel prodotto -> rimuovo prodotto dal carrello
                    if (p.getTaglieQuantita().isEmpty())
                        carrello.remove(p);
                    break;
                }
            }
        }

        req.getSession().setAttribute("carrello", carrello);

        /*JSONArray prodotti = new JSONArray();

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

        RequestDispatcher dispatcher = req.getRequestDispatcher("myCart.jsp");
        dispatcher.forward(req, resp);
    }
}
