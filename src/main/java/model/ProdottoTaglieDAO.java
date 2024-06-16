package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProdottoTaglieDAO{
    public List<ProdottoTaglie> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<ProdottoTaglie> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select * from prodottitaglie");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProdottoTaglie p = new ProdottoTaglie();
                p.setIdProdotto(rs.getInt(1));
                p.setTaglia(rs.getString(2));
                p.setQuantita(rs.getInt(3));

                result.add(p);
            }

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public ProdottoTaglie doRetrieveByPrimaryKey(int idProdotto, String taglia) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select * from\n" +
                            "prodottitaglie where prodotto = ? and taglia = ?");
            ps.setInt(1, idProdotto);
            ps.setString(2, taglia);

            ResultSet rs = ps.executeQuery();
            ProdottoTaglie p = null;

            if (rs.next()) {
                p = new ProdottoTaglie();
                p.setIdProdotto(rs.getInt(1));
                p.setTaglia(rs.getString(2));
                p.setQuantita(rs.getInt(3));
            }
            return p;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doDelete(int idProdotto,String taglia){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("delete from prodottitaglie where prodotto = ? and taglia = ?");
            ps.setInt(1,idProdotto);
            ps.setString(2,taglia);
            ps.executeUpdate();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doUpdate(ProdottoTaglie prodottoTaglie, int prodotto, String taglia) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE prodottitaglie SET prodotto=?, taglia=?, quantita=?" +
                            "WHERE prodotto=? and taglia=?");

            ps.setInt(1, prodottoTaglie.getProdotto());
            ps.setString(2, prodottoTaglie.getTaglia());
            ps.setInt(3, prodottoTaglie.getQuantita());
            ps.setInt(4, prodotto);
            ps.setString(5, taglia);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void doSave(ProdottoTaglie prodottoTaglie) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into prodottitaglie (prodotto, taglia, quantita) " +
                            "values (?, ?, ?)");
            ps.setInt(1, prodottoTaglie.getProdotto());
            ps.setString(2, prodottoTaglie.getTaglia());
            ps.setInt(3, prodottoTaglie.getQuantita());


            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
