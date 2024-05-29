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

    public void doDelete(int idProdotto,String taglia){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("DELETE FROM squadre WHERE prodotto = ? and taglia = ?");
            ps.setInt(1,idProdotto);
            ps.setString(2,taglia);
            ps.executeUpdate();
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
