<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="java.util.*, java.sql.*" %>
<%@ page import="es.accenture.emisora.Grupo" %>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Grupos Musicales</title>

<style>
h1 {
	text-align: center;
}

table {
	border: 1px solid;
	width: 100%
}

table thead {
	background-color: #a18f79;
	text-align: center;
}

table tbody tr:nth-child(odd) {
	background-color: #c9bdac;
}

table tbody tr:nth-child(even) {
	background-color: #e4ded4;
}

table tbody td {
	text-align: center;
}

.contenido {
	margin: auto;
	padding: 10px;
	width: 60%;
}

</style>

</head>
<body>

<%
Class.forName("com.mysql.cj.jdbc.Driver");
Connection conexionDB = DriverManager.getConnection("jdbc:mysql://localhost:3306/musicadb2", "cravagli", "52973571");
List<Grupo> lista = new ArrayList<>();


String query = "SELECT grupoId,nombre,origen,creacion,genero FROM grupos";

Statement statement = null;
ResultSet resultSet = null;

try {
	statement = conexionDB.createStatement();
	resultSet = statement.executeQuery(query);

	if (resultSet != null) {

		while (resultSet.next()) {
			Grupo grupo = new Grupo();
			grupo.setId(resultSet.getInt("grupoId"));
			grupo.setNombre(resultSet.getString("nombre"));
			grupo.setOrigen(resultSet.getString("origen"));
			grupo.setCreacion(resultSet.getInt("creacion"));
			grupo.setGenero(resultSet.getString("genero"));

			lista.add(grupo);
		}
	}

	resultSet.close();
	statement.close();
	conexionDB.close();
	
	pageContext.setAttribute("gruposMusicales", lista);
	
} catch (Exception e) {
	System.out.println("Ha ocurrido un error al ejecutar consulta/obtener resultado");
}
%>

<body>
	<h1>Grupos Musicales</h1>

	<div class="contenido">
		<table>
		<thead>
			<tr>
				<th>Id</th>
				<th>Nombre</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${gruposMusicales}" var="grupo">
				<tr>
					<td>${grupo.id}</td>
					<td>${grupo.nombre}</td>
					<td><a href="DetalleGrupo.jsp?id=${grupo.id}">Ver m&aacute;s</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>

</body>

</body>
</html>