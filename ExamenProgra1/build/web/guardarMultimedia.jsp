<%@ page import="java.sql.*" %>
<%@ page import="app.dataBase.pckg.DbHelper" %>
<%@ page import="app.dataBase.pckg.Multimedia" %>

<%
    // Obtener parámetros del formulario
    String titulo = request.getParameter("titulo");
    String descripcion = request.getParameter("descripcion");
    String url = request.getParameter("url");
    String tipo = request.getParameter("tipo");

    // esto verifica que los campos esten llenos y que no hay uno relleno le salte la alerta y que no lo deje guardar 
    if (titulo == null || url == null || tipo == null || titulo.trim().isEmpty() || url.trim().isEmpty() || tipo.trim().isEmpty()) {
        out.println("<p>Error: Todos los campos obligatorios deben estar llenos.</p>");
        out.println("<a href='agregarMultimedia.jsp'>Volver</a>");
        return;
    }

    // aqui se crea un objeto para que se guarde en la base de datos con los respectivos campos 
    Multimedia multimedia = new Multimedia(descripcion, url, titulo, tipo);

    // aqui es donde se guarda en la base de datos ya que lo envia el DbHelper
    boolean success = false;
    try {
        DbHelper dbHelper = new DbHelper();
        success = dbHelper.saveMulti(multimedia);
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<p>Error al guardar en la base de datos.</p>");
        out.println("<a href='agregarMultimedia.jsp'>Volver</a>");
        return;
    }

    // aqui se le muestra al usuario si se guardo o no en otra parte y un boton para volver 
    if (success) {
        out.println("<p>¡Multimedia guardada con éxito!</p>");
    } else {
       // out.println("<p>Error al guardar el contenido.</p>");
    }
    out.println("<a href='agregarMultimedia.jsp'>Volver</a>");
%>
