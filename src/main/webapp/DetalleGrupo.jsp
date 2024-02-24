<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ page import="java.util.*, java.sql.*"%>
<%@ page import="es.accenture.emisora.Grupo"%>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Detalle</title>

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
	
	String grupoId = request.getParameter("id");
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	Connection conexionDB = DriverManager.getConnection("jdbc:mysql://localhost:3306/musicadb2", "cravagli", "52973571");

	String query = "SELECT grupoId,nombre,origen,creacion,genero FROM grupos WHERE grupoId = ?";

	PreparedStatement statement = null;
	ResultSet resultSet = null;

	try {
		statement = conexionDB.prepareStatement(query);
		statement.setInt(1, Integer.parseInt(grupoId));
		resultSet = statement.executeQuery();
		Grupo grupo = new Grupo();

		if (resultSet != null) {

			while (resultSet.next()) {
				grupo.setId(resultSet.getInt("grupoId"));
				grupo.setNombre(resultSet.getString("nombre"));
				grupo.setOrigen(resultSet.getString("origen"));
				grupo.setCreacion(resultSet.getInt("creacion"));
				grupo.setGenero(resultSet.getString("genero"));
			}
		}

		resultSet.close();
		statement.close();
		conexionDB.close();

		pageContext.setAttribute("detalleGrupo", grupo);

	} catch (Exception e) {
		System.out.println("Ha ocurrido un error al ejecutar consulta/obtener resultado");
	}
	%>


	<h1>Detalle</h1>

	<div class="contenido">
		<table>
			<tbody>
				<tr>
					<td>Id del grupo:</td>
					<td>${detalleGrupo.id}</td>
				</tr>
				<tr>
					<td>Nombre del grupo:</td>
					<td>${detalleGrupo.nombre}</td>
				</tr>
				<tr>
					<td>Año de creacion del grupo:</td>
					<td>${detalleGrupo.creacion}</td>
				</tr>
				<tr>
					<td>Lugar de origen del grupo:</td>
					<td>${detalleGrupo.origen}</td>
				</tr>
				<tr>
					<td>Genero musical del grupo:</td>
					<td>${detalleGrupo.genero}</td>
				</tr>
			</tbody>
		</table>
	</div>

	<p>
		<a href="GruposMusicales.jsp">Volver atr&aacute;s</a>
	</p>
</body>
</html>