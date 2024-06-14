package model;

import java.sql.*;

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
}
