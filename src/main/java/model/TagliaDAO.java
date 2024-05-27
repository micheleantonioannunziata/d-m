package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TagliaDAO {
    public List<Taglia> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<Taglia> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select distinct taglia, tipologia from taglie");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Taglia t = new Taglia();
                t.setTaglia(rs.getString(1));
                t.setTipologia(rs.getString(2));

                result.add(t);
            }

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Taglia> doRetrieveByTipologia(String tipologia) {
        try (Connection con = ConPool.getConnection()) {
            List<Taglia> list = new ArrayList<>();
            PreparedStatement ps = con.prepareStatement(
                    "select distinct * from taglie " +
                            " where tipologia = " +"?");
            ps.setString(1, tipologia);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Taglia t = new Taglia();
                t.setTaglia(rs.getString(1));
                t.setTipologia(rs.getString(2));
                t.setDescrizione(rs.getString(3));

                list.add(t);
            }

            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
