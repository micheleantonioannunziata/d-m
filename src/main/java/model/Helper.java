package model;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class Helper {

    // metodo che restuisce un map che rappresenta le colonne della tabella passata
    // chiave: colonna, valore: tipo
    public static Map<String,String> doRetrieveColumnDataType(String tabella) {
        //hasmap che mantiene l'ordine di inserimento
        Map<String, String> columnTypes = new LinkedHashMap<>();

        try (Connection con = ConPool.getConnection()) {

            // effettua query describe (resituisce info relative alla tabella)
            PreparedStatement ps = con.prepareStatement("describe " + tabella);
            //ogni colonna avrà una tupla contenente le sue informazioni
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                String columnName = resultSet.getString("Field");
                String columnType = resultSet.getString("Type");

                String defaultValue = resultSet.getString("Default");

                // formatta
                if (resultSet.getString("Key").equalsIgnoreCase("pri"))
                    columnName += " - pk";
                if (resultSet.getString("Key").equalsIgnoreCase("mul"))
                    columnName += " - fk";
                if (resultSet.getString("Extra").equalsIgnoreCase("auto_increment"))
                    columnName += " auto";
                if (defaultValue != null)
                    columnName += " default " + defaultValue;

                // inserisci
                columnTypes.put(columnName, columnType);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return columnTypes;
    }
}
