<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.emergentes.entidades.Estudiante"%>
<%
    Estudiante e = (Estudiante) request.getAttribute("estudiante");
    int id = 0;
    if (e.getId() == null) {
        id = 0;
    } else {
        id = e.getId();
    }

    String fechaFormateada = null;
    if (e.getFechaNacimiento() != null) {
        SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        fechaFormateada = formateador.format(e.getFechaNacimiento());
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Agregar / Editar Estudiante</title>
    <style>
        body {
            background-color: #e0f2f1;
            display: flex;
            justify-content: center;
            align-items: flex-start;
            min-height: 100vh;
            padding-top: 20px;
        }
        .container {
            text-align: center;
            max-width: 600px;
            width: 100%;
            padding: 20px;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
        }
        td {
            padding: 8px;
        }
        input[type="text"], input[type="date"], input[type="submit"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }
        input[type="submit"] {
            background-color: #007bff;
            color: white;
            cursor: pointer;
        }
        input[type="submit"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Nuevo Registro</h1>
        <form action="MainController" method="POST">
            <input type="hidden" name="id" value="<%= id%>" />
            <table>
                <tr>
                    <td>Nombre: </td>
                    <td><input type="text" name="nombre" value="<%= e.getNombre() != null ? e.getNombre() : ""%>" /></td>
                </tr>
                <tr>
                    <td>Apellidos: </td>
                    <td><input type="text" name="apellidos" value="<%= e.getApellidos() != null ? e.getApellidos() : ""%>" /></td>
                </tr>
                <tr>
                    <td>Email: </td>
                    <td><input type="text" name="email" value="<%= e.getEmail() != null ? e.getEmail() : ""%>" /></td>
                </tr>
                <tr>
                    <td>Fecha Nacimiento:  </td>
                    <td><input type="date" name="fechaNacimiento" value="<%= fechaFormateada != null ? fechaFormateada : ""%>" /></td>
                </tr>
                <tr>
                    <td></td>
                    <td><input type="submit" value="<%= id == 0 ? "Guardar" : "Editar"%>" /></td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
