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
            p.setTaglieQuantita(this.doRetrieveTaglieQuantitaById(p.getId_Prodotto()));

            list.add(p);
        }
    }

    public Prodotto doRetrieveById(int id) {
        Prodotto p = doRetrieveByIdWithoutMap(id);
        p.setTaglieQuantita(this.doRetrieveTaglieQuantitaById(p.getId_Prodotto()));
        return p;
    }

    public Prodotto doRetrieveByIdWithoutMap(int id) {
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
                    "select distinct prodotti.* from prodotti join prodottitaglie on id_prodotto = prodotto" +
                            " where " + field + " = ?");
            ps.setString(1, criteria);

            this.copyResultIntoList(ps.executeQuery(), list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveByAll(String taglia, String squadra, String tipologia,
                                          String produttore, String collezione, String rangePrice) {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> result = new ArrayList<>();
            String baseQuery = "select distinct prodotti.* from prodotti left join prodottitaglie " +
                    "on id_prodotto = prodotto where 1=1";
            List<String> criteria = new ArrayList<>();

            if (!tipologia.isEmpty() && !tipologia.equalsIgnoreCase("all")) {
                baseQuery += " AND tipologia = ?";
                criteria.add(tipologia);
            }
            if (!taglia.isEmpty() && !taglia.equalsIgnoreCase("all")) {
                baseQuery += " AND taglia = ?";
                criteria.add(taglia);
            }
            if (!squadra.isEmpty() && !squadra.equalsIgnoreCase("all")) {
                baseQuery += " AND squadra = ?";
                criteria.add(squadra);
            }
            if (!produttore.isEmpty() && !produttore.equalsIgnoreCase("all")) {
                baseQuery += " AND produttore = ?";
                criteria.add(produttore);
            }
            if (!collezione.isEmpty() && !collezione.equalsIgnoreCase("all")) {
                baseQuery += " AND collezione = ?";
                criteria.add(collezione);
            }
            if (!rangePrice.isEmpty() && !rangePrice.equalsIgnoreCase("all")) {
                String[] prices;
                if (rangePrice.contains(" - ")) {
                    prices = rangePrice.split(" - ");
                    baseQuery += "and prezzo between ? and ?";
                    criteria.add(prices[0]);
                    criteria.add(prices[1]);
                }

                else if (rangePrice.contains("+")) {
                    prices = rangePrice.split(" + ");
                    baseQuery += "and prezzo >= ?";
                    criteria.add(prices[0]);
                }
            }

            PreparedStatement ps = con.prepareStatement(baseQuery);

            for (int i = 0; i < criteria.size(); i++)
                ps.setString(i + 1, criteria.get(i));

            this.copyResultIntoList(ps.executeQuery(), result);

            return result;
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

    public List<String> doRetrieveColumnByCriteria(String column, String field, String criteria) {
        try (Connection con = ConPool.getConnection()) {
            List<String> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement(
                    "select distinct " + column + " from prodotti" +
                            " where " + field + " = ?");
            ps.setString(1, criteria);

            ResultSet rs = ps.executeQuery();

            while (rs.next())
                list.add(rs.getString(1));

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement("select * from prodotti");
            ResultSet rs = ps.executeQuery();

            copyResultIntoList(rs, list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveAllBean() {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement("select distinct prodotti.* from prodotti join " +
                    "prodottitaglie on id_prodotto = prodotto");
            ResultSet rs = ps.executeQuery();

            copyResultIntoList(rs, list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Prodotto> doRetrieveBySearch(String string) {
        try (Connection con = ConPool.getConnection()) {
            List<Prodotto> list = new ArrayList<>();

            String[] words = string.split(" ");

            StringBuilder searchPattern = new StringBuilder("%");

            if (!string.isEmpty())
                for (String word: words)
                    searchPattern.append(word).append("%");

            String query = "select distinct prodotti.* from prodotti left join prodottitaglie on id_prodotto = prodotto " +
                    "where nome like ";

            query += "'" + searchPattern + "'";

            PreparedStatement ps = con.prepareStatement(query);

            copyResultIntoList(ps.executeQuery(), list);

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Map<String, Integer> doRetrieveTaglieQuantitaById(int idProdotto) {
        try (Connection con = ConPool.getConnection()) {
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

    public int doSave(Prodotto prodotto) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into prodotti (nome, prezzo, tipologia, squadra, produttore, collezione) " +
                            "values (?, ?, ?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, prodotto.getNome());
            ps.setDouble(2, prodotto.getPrezzo());
            ps.setString(3, prodotto.getTipologia());
            ps.setString(4, prodotto.getSquadra());
            ps.setString(5, prodotto.getProduttore());
            ps.setString(6, prodotto.getCollezione());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doUpdate(Prodotto prodotto, int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE prodotti SET nome=?, prezzo=?, tipologia=?, squadra=?, produttore=?, collezione=? WHERE id_prodotto=?");

            ps.setString(1, prodotto.getNome());
            ps.setDouble(2, prodotto.getPrezzo());
            ps.setString(3, prodotto.getTipologia());
            ps.setString(4, prodotto.getSquadra());
            ps.setString(5, prodotto.getProduttore());
            ps.setString(6, prodotto.getCollezione());
            ps.setInt(7, id); // id da passare come parametro

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public int doDelete(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("delete from prodotti where id_prodotto = ?");
            ps.setInt(1, id);
            ps.executeUpdate();

            return id;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void setUrlImmagineByid(int id, String url) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("update prodotti set urlImmagine = ? where id_prodotto = ?");
            ps.setString(1, url);
            ps.setInt(2, id);

            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}