package model;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UtenteDAO{
    public Utente doRetrieveByUsernamePassword(String username, String password) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select id_utente, username, email, passwordhash, isAdmin from\n" +
                            "utenti where username = ? and passwordhash = SHA1(?)");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setAdmin(rs.getBoolean(5));
                return u;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public Utente doRetrieveById(int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select id_utente, username, email, passwordhash, isAdmin from\n" +
                            "utenti where id_utente = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setAdmin(rs.getBoolean(5));
                return u;
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // funzione che restituisce true o false in base all'esistenza dell'username
    public boolean existsByUsername(String username) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select * from utenti where username = ?");
            ps.setString(1, username);

            ResultSet rs = ps.executeQuery();

            // restituisce true se il risultato della query dà almeno una riga
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean existsByMail(String mail) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("select * from utenti where email = ?");
            ps.setString(1, mail);

            ResultSet rs = ps.executeQuery();

            // restituisce true se il risultato della query dà almeno una riga
            return rs.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doSave(Utente utente) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "insert into utenti (username, email, passwordhash, isadmin) values (?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            ps.setString(1, utente.getUsername());
            ps.setString(2, utente.getEmail());
            ps.setString(3, utente.getPasswordHash());
            ps.setBoolean(4, utente.isAdmin());

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("INSERT error.");
            }
            ResultSet rs = ps.getGeneratedKeys();
            rs.next();
            int id = rs.getInt(1);
            utente.setId(id);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public void doUpdate(Utente utente, int id) {
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE utenti SET id_utente=?, username=?, email=?, passwordhash=?, isAdmin=? WHERE id_utente=?");

            ps.setInt(1, utente.getId_Utente());
            ps.setString(2, utente.getUsername());
            ps.setString(3, utente.getEmail());
            ps.setString(4, utente.getPasswordHash());
            ps.setBoolean(5, utente.isAdmin());
            ps.setInt(6, id);

            if (ps.executeUpdate() != 1) {
                throw new RuntimeException("UPDATE error.");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Utente> doRetrieveAll() {
        try (Connection con = ConPool.getConnection()) {
            List<Utente> result = new ArrayList<>();
            PreparedStatement ps =
                    con.prepareStatement("select * from utenti");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Utente u = new Utente();
                u.setId(rs.getInt(1));
                u.setUsername(rs.getString(2));
                u.setEmail(rs.getString(3));
                u.setPassword(rs.getString(4));
                u.setAdmin(rs.getBoolean(5));

                result.add(u);
            }

            return result;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public int doDelete(int id){
        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps =
                    con.prepareStatement("delete from utenti where id_utente = ?");
            ps.setInt(1,id);
            ps.executeUpdate();

            return id;
        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
