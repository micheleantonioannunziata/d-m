package controller.admin;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.*;

import java.io.File;
import java.io.IOException;
import java.util.*;

@MultipartConfig
@WebServlet(name = "InsertDataServlet",value="/insert-data")
public class InsertDataServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String tabella = req.getParameter("tabella");
        List<String> paramNames = Collections.list(req.getParameterNames());

        switch (tabella.toLowerCase()) {
            case "prodotti" -> {
                ProdottoDAO prodottoDAO = new ProdottoDAO();
                Prodotto p = new Prodotto();

                // parto da 1 perché il primo è tabella
                p.setNome(req.getParameter(paramNames.get(1)));
                p.setPrezzo(Double.parseDouble(req.getParameter(paramNames.get(2))));
                p.setTipologia(req.getParameter(paramNames.get(3)));

                if (!req.getParameter(paramNames.get(4)).equals("null"))
                    p.setSquadra(req.getParameter(paramNames.get(4)));

                p.setProduttore(req.getParameter(paramNames.get(5)));
                p.setCollezione(req.getParameter(paramNames.get(6)));

                int id = prodottoDAO.doSave(p);
                p.setId(id);

                Part filePart = req.getPart("urlimmagine");
                String fileName = filePart.getSubmittedFileName(); // prendi nome del file caricato (serve solo per catturare l'estennsione)
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1); // prendi estansione del file caricato
                String directory = "img/prod/";

                String filePath =
                        getServletContext().getRealPath("/" + directory)
                                + p.getId_Prodotto() + "." + fileExtension;

                filePart.write(filePath); // salva file

                p.setUrlImmagine(directory + p.getId_Prodotto() + "." + fileExtension); // setta url

                prodottoDAO.setUrlImmagineByid(p.getId_Prodotto(), p.getUrlImmagine()); // setta url nel db
            }
            case "squadre" -> {
                SquadraDAO squadraDAO = new SquadraDAO();
                Squadra s = new Squadra();

                // parto da 1 perché il primo è tabella
                s.setNome(req.getParameter(paramNames.get(1)));

                Part filePart = req.getPart("urlimmagine");
                String fileName = filePart.getSubmittedFileName(); // prendi nome del file caricato (serve solo per catturare l'estennsione)
                String fileExtension = fileName.substring(fileName.lastIndexOf(".") + 1); // prendi estansione del file caricato
                String directory = "img/squadre/";

                String filePath =
                        getServletContext().getRealPath("/" + directory)
                        + s.getNome() + "." + fileExtension;

                filePart.write(filePath); // salva file

                s.setUrlImmagine(directory + s.getNome() + "." + fileExtension); // setta url

                squadraDAO.doSave(s);

                // aggiorna servletContext
                List<Squadra> squadre = (List<Squadra>) getServletContext().getAttribute("squadre");
                squadre.add(s);
                getServletContext().setAttribute("squadre", squadre);
            }
            case "taglie" -> {
                TagliaDAO tagliaDAO = new TagliaDAO();
                Taglia t = new Taglia();

                // parto da 1 perché il primo è tabella
                t.setTaglia(req.getParameter(paramNames.get(1)));
                t.setTipologia(req.getParameter(paramNames.get(2)));
                if (!req.getParameter(paramNames.get(3)).isEmpty())
                    t.setDescrizione(req.getParameter(paramNames.get(3)));

                tagliaDAO.doSave(t);

                // aggiorna servletContext
                List<Taglia> taglie = (List<Taglia>) getServletContext().getAttribute("taglie");
                taglie.add(t);
                getServletContext().setAttribute("taglie", taglie);
            }

            case "utenti" -> {
                Utente u = new Utente();
                UtenteDAO utenteDAO = new UtenteDAO();

                // parto da 1 perché il primo è tabella
                u.setUsername(req.getParameter(paramNames.get(1)));
                u.setEmail(req.getParameter(paramNames.get(2)));
                u.setPassword(req.getParameter(paramNames.get(3)));

                if(req.getParameter("isAdmin") != null) // se admin è stato selezionato
                    u.setAdmin(req.getParameter("isAdmin").equalsIgnoreCase("on"));
                else u.setAdmin(false);

                utenteDAO.doSave(u);
            }
            case "prodottitaglie" -> {
                ProdottoTaglie prodottoTaglie = new ProdottoTaglie();
                ProdottoTaglieDAO prodottoTaglieDAO = new ProdottoTaglieDAO();

                prodottoTaglie.setIdProdotto(Integer.parseInt(req.getParameter(paramNames.get(1))));
                prodottoTaglie.setTaglia(req.getParameter(paramNames.get(2)));
                prodottoTaglie.setQuantita(Integer.parseInt(req.getParameter(paramNames.get(3))));

                prodottoTaglieDAO.doSave(prodottoTaglie);
            }
            case "ordini" -> {
                Ordine o = new Ordine();
                OrdineDAO ordineDAO = new OrdineDAO();

                // parto da 1 perché il primo è tabella
                o.setIdOrdine(Integer.parseInt(req.getParameter(paramNames.get(1))));
                o.setIdUtente(Integer.parseInt(req.getParameter(paramNames.get(2))));
                o.setIdProdotto(Integer.parseInt(req.getParameter(paramNames.get(3))));
                o.setTaglia(req.getParameter(paramNames.get(4)));
                o.setQuantita(Integer.parseInt(req.getParameter(paramNames.get(5))));

                ordineDAO.doSave(o);
            }

        }

        resp.sendRedirect("admin-servlet");
    }

}
