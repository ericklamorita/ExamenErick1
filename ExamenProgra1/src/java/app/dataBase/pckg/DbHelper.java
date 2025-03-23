package app.dataBase.pckg;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;


public class DbHelper {
    //para conectar con la base de datos
    Connection conn;
// se incia un constructor para establecer una conexion con la base de datos 
    public DbHelper() throws SQLException {
        try {
            //carga la conexcion con el servidos 
            Class.forName("com.mysql.cj.jdbc.Driver");
            //establece la conexcion con la base de datos           
            conn = DriverManager.getConnection("jdbc:mysql://localhost/medial_db", "root", "Admin$1234");
            //verifica si se conecto 
            if (conn == null) {
                throw new SQLException("No se pudo establecer la conexión con la base de datos.");
            }

        } catch (ClassNotFoundException ex) {
           //maneja error si no se encuentra con la base de datos 
            Logger.getLogger(DbHelper.class.getName()).log(Level.SEVERE, "Error: Driver de MySQL no encontrado.", ex);
            throw new SQLException("Error al cargar el driver MySQL.", ex);

        } catch (SQLException ex) {
            //maneja error si se encuentra con algun error al conectar con la base 
            Logger.getLogger(DbHelper.class.getName()).log(Level.SEVERE, "Error al conectar con la base de datos.", ex);
            throw ex;
        }
    }

    // cierra conexiones de la base de datos
    public static void close(Connection conn, Statement stmt, ResultSet rs) {
        try {
            //ResultSet
            if (rs != null) {
                rs.close();
            }
            //Statement
            if (stmt != null) {
                stmt.close();
            }
            // cerrar su si la conexcion esta abierta
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //aqui se guarda el objeto multimedia en la base de datos
    public boolean saveMulti(Multimedia event) throws SQLException {
        try {
            //aqui prepara para insertar un nuevo multimedia en la tabla multimedia
            PreparedStatement predStatement
                    = conn.prepareStatement("INSERT INTO multimedia ( descripcion, url , titulo, tipo)"
                            + "VALUES ( ?, ?, ?, ?)");
            //aqui se establecen los valores preparedStatement con los datos del servidor
            predStatement.setString(1, event.getDescripcion());
            predStatement.setString(2, event.getUrl());
            predStatement.setString(3, event.getTitulo());
            predStatement.setString(4, event.getTipo());
            predStatement.executeUpdate();
            return true;

        } catch (SQLException ex) {
            //Logger.getLogger(databaseHelper.class.getName()).log(Level.ERROR, null, ex);
            return false;
        }
    }
    
    
    //y aqui se usa este ResultSet para obtener los registros de la tabla multimedia de la base de datos
    public ResultSet getmulti() {
        try {
            PreparedStatement predStatement
                    = conn.prepareStatement("select*from multimedia;");
           
           ResultSet RS = predStatement.executeQuery();
           return RS;
            
        } catch (SQLException ex) {
            //Logger.getLogger(databaseHelper.class.getName()).log(Level.ERROR, null, ex);
            return null;
        }
    }
;

}
