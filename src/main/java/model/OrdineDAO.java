package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrdineDAO{

    public Ordine doRetrieveByPrimaryKey(int idOrdine, int idUtente, int idProdotto, String taglia) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select id_ordine, utente, prodotto, taglia, quantita, prezzo from\n" +
                            "ordini where id_ordine = ? and utente = ? and prodotto = ? and taglia = ?");
            ps.setInt(1, idOrdine);
            ps.setInt(2, idUtente);
            ps.setInt(3, idProdotto);
            ps.setString(4, taglia);

            ResultSet rs = ps.executeQuery();
            Ordine o = null;

            if (rs.next()) {
                o = new Ordine();
                o.setIdOrdine(rs.getInt(1));
                o.setIdUtente(rs.getInt(2));
                o.setIdProdotto(rs.getInt(3));
                o.setTaglia(rs.getString(4));
                o.setQuantita(rs.getInt(5));
                o.setPrezzo(rs.getDouble(6));
            }
            return o;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public List<Ordine> doRetrieveByUser(int idUtente) {
        try (Connection con = ConPool.getConnection()) {
            List<Ordine> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select id_ordine, prodotto, taglia, quantita, prezzo from\n" +
                            "ordini where utente = ?");
            ps.setInt(1, idUtente);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt(1));
                o.setIdUtente(idUtente);
                o.setIdProdotto(rs.getInt(2));
                o.setTaglia(rs.getString(3));
                o.setQuantita(rs.getInt(4));
                o.setPrezzo(rs.getDouble(5));

                result.add(o);
            }
            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Ordine ordine) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into ordini (id_ordine, utente, prodotto, taglia, quantità, prezzo) " +
                            "values (?, ?, ?, ?, ?, ?)");
            ps.setInt(1, ordine.getIdOrdine());
            ps.setInt(2, ordine.getIdUtente());
            ps.setInt(3, ordine.getIdProdotto());
            ps.setString(4, ordine.getTaglia());
            ps.setInt(5, ordine.getQuantita());
            ps.setDouble(6, ordine.getPrezzo());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Ordine> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<Ordine> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select * from ordini");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Ordine o = new Ordine();
                o.setIdOrdine(rs.getInt(1));
                o.setIdUtente(rs.getInt(2));
                o.setIdProdotto(rs.getInt(3));
                o.setTaglia(rs.getString(4));
                o.setQuantita(rs.getInt(5));
                o.setPrezzo(rs.getDouble(6));

                result.add(o);
            }

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        }

        public void doDelete(int idOrdine, int idProdotto, int idUtente, String taglia){
            try (Connection con = ConPool.getConnection()) {
                PreparedStatement ps =
                        con.prepareStatement("delete from ordini where ID_Ordine = ? " +
                                "and prodotto = ? and utente = ? and taglia = ?");
                ps.setInt(1,idOrdine);
                ps.setInt(2,idProdotto);
                ps.setInt(3,idUtente);
                ps.setString(4,taglia);
                ps.executeUpdate();
            }
            catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
}
