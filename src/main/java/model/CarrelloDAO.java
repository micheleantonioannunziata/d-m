package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CarrelloDAO {
    public void doSave(Carrello carrello) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into carrello (utente, prodotto, taglia, quantita) " +
                            "values (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, carrello.getIdUtente());
            ps.setInt(2, carrello.getIdProdotto());
            ps.setString(3, carrello.getTaglia());
            ps.setInt(4, carrello.getQuantita());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int doDeleteByUtente(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("delete from carrello where utente = ?");
            ps.setInt(1, id);
            ps.executeUpdate();

            return id;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Carrello> doRetrieveByUtente(int id){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select prodotto, taglia, quantita from carrello\n " +
                            "where utente = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            List<Carrello> carrelloList = new ArrayList<>();
            while (rs.next()) {
                Carrello c = new Carrello();
                c.setIdUtente(id);
                c.setIdProdotto(rs.getInt(1));
                c.setTaglia(rs.getString(2));
                c.setQuantita(rs.getInt(3));
                carrelloList.add(c);
            }
            return carrelloList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
