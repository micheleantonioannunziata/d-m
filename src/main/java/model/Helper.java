package model;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

public class Helper {
    public Map<String,String> doRetrieveColumnType(String tabella){
        Map<String,String> columnTypes = new HashMap<>();
        try (Connection con = ConPool.getConnection()) {
            DatabaseMetaData databaseMetaData = con.getMetaData();
            ResultSet resultSet = databaseMetaData.getColumns(con.getCatalog(), con.getSchema(), tabella, null);

            while (resultSet.next()) {
                String columnName = resultSet.getString("COLUMN_NAME");
                String columnType = resultSet.getString("TYPE_NAME");
                columnTypes.put(columnName, columnType);
            }

        }
        catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return columnTypes;
    }
}
