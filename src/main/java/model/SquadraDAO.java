package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SquadraDAO {
    public Squadra doRetrieveByNome(String nome) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select * from\n" +
                            "squadre where nome = ?");
            ps.setString(1, nome);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Squadra s = new Squadra();
                s.setNome(rs.getString(1));
                s.setUrlImmagine(rs.getString(2));
                return s;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Squadra> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<Squadra> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select * from squadre");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Squadra s = new Squadra();
                s.setNome(rs.getString(1));
                s.setUrlImmagine(rs.getString(2));

                result.add(s);
            }

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Squadra squadra) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into squadre (nome, urlImmagine) values (?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, squadra.getNome());
            ps.setString(2, squadra.getUrlImmagine());
            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public String doDelete(String nome){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("DELETE FROM squadre WHERE Nome = ?");
            ps.setString(1,nome);
            ps.executeUpdate();

            return nome;
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
