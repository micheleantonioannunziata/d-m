package model;

import java.sql.*;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.Map;

public class Helper {
    public static Map<String,String> doRetrieveColumnDataType(String tabella){
        Map<String,String> columnTypes = new LinkedHashMap<>();

        try (Connection con = ConPool.getConnection()) {
            PreparedStatement ps = con.prepareStatement("describe " + tabella);
            ResultSet resultSet = ps.executeQuery();

            while (resultSet.next()) {
                String columnName = resultSet.getString("Field");
                String columnType = resultSet.getString("Type");

                if (resultSet.getString("Key").equalsIgnoreCase("pri"))
                    columnName += " - pk";
                if (resultSet.getString("Key").equalsIgnoreCase("mul"))
                    columnName += " - fk";

                columnTypes.put(columnName, columnType);
            }

        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return columnTypes;
    }
}
