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

}
