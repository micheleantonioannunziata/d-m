package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TagliaDAO{
    public List<Taglia> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<Taglia> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select distinct taglia, tipologia, descrizione from taglie");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Taglia t = new Taglia();
                t.setTaglia(rs.getString(1));
                t.setTipologia(rs.getString(2));
                t.setDescrizione(rs.getString(3));

                result.add(t);
            }

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Taglia doRetrieveTaglia(String taglia) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "select * from taglie " +
                            " where taglia = ?");
            ps.setString(1, taglia);

            ResultSet rs = ps.executeQuery();
            Taglia t = null;

            if (rs.next()) {
                t = new Taglia();
                t.setTaglia(rs.getString(1));
                t.setTipologia(rs.getString(2));
                t.setDescrizione(rs.getString(3));
            }

            return t;
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

    public void doSave(Taglia taglia) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into taglie (taglia, tipologia, descrizione) values (?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, taglia.getTaglia());
            ps.setString(2, taglia.getTipologia());
            if (!taglia.getDescrizione().equals("null"))
                ps.setString(3, taglia.getDescrizione());
            else ps.setNull(3, java.sql.Types.VARCHAR);
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doUpdate(Taglia taglia, String t) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE taglie SET taglia=?, tipologia=?, descrizione=? WHERE taglia=?");

            ps.setString(1, taglia.getTaglia());
            ps.setString(2, taglia.getTipologia());
            ps.setString(3, taglia.getDescrizione());
            ps.setString(4, t);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String doDelete(String taglia){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("delete from taglie where taglia = ?");
            ps.setString(1,taglia);
            ps.executeUpdate();

            return taglia;
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
