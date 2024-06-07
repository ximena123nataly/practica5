<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.emergentes.entidades.Estudiante"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    List<Estudiante> e = (List<Estudiante>) request.getAttribute("estudiantes");
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Estudiantes</title>
    
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background-color: #e0f2f1 /* Color de fondo celeste claro */
        }
        .container {
            display: flex;
            justify-content: center;
            align-items: flex-start; 
            min-height: 100vh;
            padding: 20px; 
        }
        .content {
            text-align: center;
        }
        table {
            border: 2px solid #007bff; 
            border-collapse: collapse; 
            width: 100%; 
        }
        th, td {
            border: 2px solid #007bff; 
            padding: 8px; 
            text-align: left; 
        }
        th {
            background-color: #007bff; 
            color: white; 
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="content">
            <h1>Listado de Seguimiento</h1>
            <p><a href="MainController?action=add">Nuevo</a></p>
            <table>
                <tr>
                    <th>Id</th>
                    <th>Nombre</th>
                    <th>Apellidos</th>
                    <th>Email</th>
                    <th>Nacimiento</th>
                    <th></th>
                    <th></th>
                </tr>

                <% for (Estudiante item : e) {%>
                <tr>
                    <td><%= item.getId()%></td>
                    <td><%= item.getNombre()%></td>
                    <td><%= item.getApellidos()%></td>
                    <td><%= item.getEmail()%></td> 

                    <%
                        SimpleDateFormat formateador = new SimpleDateFormat("dd-MM-yyyy");
                        String fechaFormateada = formateador.format(item.getFechaNacimiento());
                    %>

                    <td><%= fechaFormateada %></td>

                    <td>
                        <a href="MainController?action=edit&id=<%= item.getId()%>">Editar</a>
                    </td>
                    <td>
                        <a href="MainController?action=delete&id=<%= item.getId()%>">Eliminar</a>
                    </td>
                </tr>
                <% } %>
            </table>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
