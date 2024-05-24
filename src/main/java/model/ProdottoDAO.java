package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProdottoDAO {

    // metodo di appoggio che copia in list il contenuto di rs
    public void copyResultIntoList(ResultSet rs, List<Prodotto> list) throws SQLException {
        while (rs.next()) {
            Prodotto p = new Prodotto();
            p.setId(rs.getInt(1));
            p.setNome(rs.getString(2));
            p.setPrezzo(rs.getDouble(3));
            p.setTipologia(rs.getString(4));
            p.setSquadra(rs.getString(5));
            p.setProduttore(rs.getString(6));
            p.setCollezione(rs.getString(7));
            p.setUrlImmagine(rs.getString(8));

            // prendi tutte le taglie (e le quantità associate) del prodotto
            p.setTaglieQuantita(this.doRetrieveTaglieQuantitaById(p.getId()));

            list.add(p);
        }
    }
    public Prodotto doRetrieveById(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select * from\n" +
                            "prodotti where id_prodotto = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Prodotto p = new Prodotto();
                p.setId(rs.getInt(1));
                p.setNome(rs.getString(2));
                p.setPrezzo(rs.getDouble(3));
                p.setTipologia(rs.getString(4));
                p.setSquadra(rs.getString(5));
                p.setProduttore(rs.getString(6));
                p.setCollezione(rs.getString(7));
                p.setUrlImmagine(rs.getString(8));
                p.setTaglieQuantita(this.doRetrieveTaglieQuantitaById(p.getId()));
                return p;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // field è l'attributo della tabella, criteria è il valore che deve assumere
    public List<Prodotto> doRetrieveByCriteria(String field, String criteria) {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement(
                    "select prodotti.* from prodotti join prodottitaglie on id_prodotto = prodotto" +
                            " where " + field + " = ?");
            ps.setString(1, criteria);

            this.copyResultIntoList(ps.executeQuery(), list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveByAll(String taglia, String squadra, String tipologia,
                                          String produttore, String collezione) {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement(
                    "select prodotti.* from prodotti join prodottitaglie on id_prodotto = prodotto" +
                            " where taglia = ? and squadra = ? and tipologia = ? and produttore = ? and collezione = ?");
            ps.setString(1, taglia);
            ps.setString(2, squadra);
            ps.setString(3, tipologia);
            ps.setString(4, produttore);
            ps.setString(5, collezione);

            this.copyResultIntoList(ps.executeQuery(), list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveByRangePrice(double from, double to) {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement(
                    "select * from prodotti where prezzo between ? and ?");
            ps.setDouble(1, from);
            ps.setDouble(2, to);

            this.copyResultIntoList(ps.executeQuery(), list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()){
            List<Prodotto> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement("select distinct prodotti.* from prodotti join prodottitaglie " +
                    "on id_prodotto = prodotto");
            ResultSet rs = ps.executeQuery();

            copyResultIntoList(rs, list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Map<String, Integer> doRetrieveTaglieQuantitaById(int idProdotto) {
        try (Connection con = ConPool.getConnection()){
            Map<String, Integer> result = new HashMap<>();
            PreparedStatement ps = con.prepareStatement("select taglia, quantita from prodotti join prodottitaglie " +
                    "on id_prodotto = prodotto where id_prodotto = ?");
            ps.setInt(1, idProdotto);
            ResultSet rs = ps.executeQuery();

            while (rs.next())
                result.put(rs.getString(1), rs.getInt(2));

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Prodotto prodotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into utenti (nome, prezzo, tipologia, squadra) " +
                            "values (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, prodotto.getNome());
            ps.setDouble(2, prodotto.getPrezzo());
            ps.setString(3, prodotto.getTipologia());
            ps.setString(4, prodotto.getSquadra());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int id = rs.getInt(1);
            prodotto.setId(id);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
