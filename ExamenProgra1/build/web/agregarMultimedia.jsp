<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Agregar Multimedia</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f8f8;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 400px;
            border-top: 5px solid #007BFF;
            border-bottom: 5px solid #007BFF;
        }

        h1 {
            color: #000;
            font-size: 24px;
            margin-bottom: 20px;
        }

        label {
            display: block;
            text-align: left;
            font-weight: bold;
            margin-top: 10px;
        }

        input, textarea, select {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 2px solid #007BFF;
            border-radius: 5px;
            font-size: 14px;
        }

        textarea {
            resize: none;
            height: 80px;
        }

        .button {
            display: block;
            width: 100%;
            padding: 10px;
            margin-top: 10px;
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

        input[type="submit"] {
            background-color: #000;
            color: white;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #007BFF;
        }
    </style>
</head>
<body>
   <!--esta es la encuesta para rellenar que le pide a uno -->
    <div class="container">
        <h1>Agregar Contenido Multimedia</h1>
        <form action="guardarMultimedia.jsp" method="post">
            <!--titulo -->
            <label for="titulo">Título:</label>
            <input type="text" id="titulo" name="titulo" required>
           <!--/la descripcion que uno quiera-->
            <label for="descripcion">Descripción:</label>
            <textarea id="descripcion" name="descripcion"></textarea>
            <!--donde uno va a poner el link-->
            <label for="url">URL del archivo:</label>
            <input type="text" id="url" name="url" required>
            <!--y aqui se escoge el tipo de archivo si es imagen, video o audio-->
            <label for="tipo">Tipo de archivo:</label>
            <select id="tipo" name="tipo" required>
                <option value="imagen">Imagen</option>
                <option value="video">Video</option>
                <option value="audio">Audio</option>
            </select>
            <!-- este boton lo que hace es guardar lo que se relleno en el formulario y lo envia a la base de datos para que se guarde -->
            <input type="submit" value="Guardar">
        </form>
        <a href="index.html" class="button">Volver al Inicio</a>
    </div>
</body>
</html>
