<%@page import="app.dataBase.pckg.DbHelper"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.net.URL"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Ver Multimedia</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #2c2c2c;
                color: #ddd;
                display: flex;
                flex-direction: column;
                align-items: center;
                justify-content: center;
                margin: 0;
                padding: 20px;
            }

            .container {
                width: 90%;
                max-width: 1200px;
                display: flex;
                flex-wrap: wrap;
                justify-content: center;
                gap: 20px;
            }

            .card {
                background-color: #3a3a3a;
                padding: 20px;
                border-radius: 10px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                text-align: center;
                width: 300px;
                border-top: 5px solid #007BFF;
                border-bottom: 5px solid #007BFF;
            }

            h1 {
                color: #fff;
                font-size: 26px;
                margin-bottom: 20px;
                text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
            }

            .media img {
                max-width: 100%;
                height: 180px;
                object-fit: cover;
                border-radius: 5px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
            }

            .title {
                font-size: 20px;
                font-weight: bold;
                color: #fff;
                margin-bottom: 10px;
            }

            .description {
                font-size: 14px;
                color: #ccc;
                margin-bottom: 10px;
            }

            .btn {
                display: inline-block;
                padding: 10px 15px;
                margin-top: 10px;
                background-color: #007BFF;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                font-size: 14px;
            }

            .btn:hover {
                background-color: #0056b3;
            }

            .button {
                display: block;
                margin: 30px auto;
                padding: 10px 15px;
                text-decoration: none;
                color: white;
                background-color: #000;
                border: 2px solid #007BFF;
                text-align: center;
                font-size: 16px;
                font-weight: bold;
                border-radius: 5px;
                transition: all 0.3s ease;
            }

            .button:hover {
                background-color: #007BFF;
            }

        </style>
    </head>
    <body>

        <h3>Contenidos Multimedia</h3>
        <div class="container">
            <%
                DbHelper dbhelper = new DbHelper();
                ResultSet rs = dbhelper.getmulti();

                try {
                    while (rs.next()) {
                        String titulo = rs.getString("titulo");
                        String descripcion = rs.getString("descripcion");
                        String url = rs.getString("url");
                        String tipo = rs.getString("tipo");
                        String imgPreview = "img/img_placeholder.jpg"; // Imagen por defecto

                        // Extraer dominio de la URL
                        String dominio = "";
                        try {
                            URL urlObj = new URL(url);
                            dominio = urlObj.getHost();
                        } catch (Exception ex) {
                            dominio = "desconocido";
                        }
                        //Guardado de imagen
                        // Determinar imagen de vista previa según el tipo
                        if (url.matches(".*\\.(jpg|jpeg|png|gif|bmp)$")) {
                            imgPreview = url; // Es una imagen, usar directamente
                            //guardado de videos de youtube 
                        } else if (url.contains("youtube.com/watch?v=")) {
                            //aqui es para sacar el ID del video que pongamos 
                            //ejemplo de esto puede ser 
                            //https://www.youtube.com/watch?v=vgZRp6ZmBww
                            //El método url.split("v=")divide la URL en dos partes en donde encuentra el texto v=
                            //en este caso seria parte 1 https://www.youtube.com/watch? y´parte dos vgZRp6ZmBww
                            //luego selecciona el indice [1] selecciona la segunda parte que seria vgZRp6ZmBww
                            //Si hay parámetros adicionales después del ID (como "&t=1m23s"), split("&")[0] se encarga de extraer solo el ID. 
                            //pero en este caso no tiene entonces el id es vgZRp6ZmBww
                            String videoId = url.split("v=")[1].split("&")[0];
                            //este es para sacar la miniatura del video que uno ponga 
                            imgPreview = "https://img.youtube.com/vi/" + videoId + "/hqdefault.jpg"; //saca la miniatura

                        } else if (url.contains("youtu.be/")) {
                            // Para URLs cortas de YouTube, como https://youtu.be/vgZRp6ZmBww
                            // url.split("youtu.be/") divide la url en dos partes la primera antes de youtu.be/ y la segunda con el ID del video.
                            // split("\\?")[0] hace que si hay parámetros adicionales en la URL solo se toma el ID del video.
                            String videoId = url.split("youtu.be/")[1].split("\\?")[0];
                            imgPreview = "https://img.youtube.com/vi/" + videoId + "/hqdefault.jpg"; //saca la miniatura
                        } else {
                            // Usar favicon del sitio para cuando no encentra la imagen ponga la googlen, 
                            //es útil cuando no se tiene una imagen específica o si la URL proporcionada o es un archivo de imagen directo  
                            imgPreview = "https://www.google.com/s2/favicons?sz=128&domain=" + dominio;
                        }
            %>
            <div class="card">
                <div class="title"><%= titulo%></div>
                <div class="description"><%= (descripcion != null ? descripcion : "Sin descripción")%></div>
                <div class="media">
                    <img src="<%= imgPreview%>" alt="Vista previa">
                </div>
                <a href="<%= url%>" class="btn" target="_blank">Ver Contenido</a>
            </div>
            <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p>Error al recuperar los contenidos.</p>");
                } finally {
                    if (rs != null) {
                        try {
                            if (rs.getStatement() != null && rs.getStatement().getConnection() != null) {
                                DbHelper.close(rs.getStatement().getConnection(), rs.getStatement(), rs);
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                }
            %>
        </div>
        <a href="index.html" class="button">Volver al Inicio</a>
</html>

