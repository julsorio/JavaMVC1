package es.accenture.emisora;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

/**
 * @author Andrea Ravagli Castillo
 */
public class ModeloGrupo {
	private DataSource poolConexiones;
	
	public ModeloGrupo(DataSource poolConexiones) {
		this.poolConexiones = poolConexiones;
	}
	
	/**
	 * metodo que realiza la consulta a la tabla grupos
	 * @return lista de grupos
	 * @throws Exception
	 */
	public List<Grupo> getGrupos() throws Exception {
		List<Grupo> listaGrupos = new ArrayList<>();
		Connection miConexion = null;
		Statement miStatement = null;
		ResultSet resultado = null;
		
		String query = "SELECT grupoId,nombre,origen,creacion,genero FROM GRUPOS";
		
		try {
			miConexion = poolConexiones.getConnection();
			miStatement = miConexion.createStatement();
			resultado = miStatement.executeQuery(query);
			
			if (resultado != null) {

				while (resultado.next()) {
					Grupo grupo = new Grupo();
					grupo.setId(resultado.getInt("grupoId"));
					grupo.setNombre(resultado.getString("nombre"));
					grupo.setOrigen(resultado.getString("origen"));
					grupo.setCreacion(resultado.getInt("creacion"));
					grupo.setGenero(resultado.getString("genero"));

					listaGrupos.add(grupo);
				}
			}

			resultado.close();
			miStatement.close();
			
		} catch (Exception e) {
			System.out.println("Ha ocurrido un error al realizar la consulta " + e.getMessage());
			e.printStackTrace();
		}
		
		return listaGrupos;
	}
	
	/**
	 * metodo que se encarga de obtener el detalle del grupo de acuerdo al id
	 * @param idGrupo
	 * @return grupo
	 * @throws Exception
	 */
	public Grupo getGrupo(int idGrupo) throws Exception {
		Grupo grupoEncontrado = null;
		Connection miConexion = null;
		PreparedStatement  miStatement = null;
		ResultSet resultado = null;
		
		String query = "SELECT grupoId,nombre,origen,creacion,genero FROM grupos WHERE grupoId = ?";
		
		try {
			miConexion = poolConexiones.getConnection();
			miStatement = miConexion.prepareStatement(query);
			miStatement.setInt(1, idGrupo);
			resultado = miStatement.executeQuery();
			
			if (resultado != null) {

				while (resultado.next()) {
					grupoEncontrado = new Grupo();
					grupoEncontrado.setId(resultado.getInt("grupoId"));
					grupoEncontrado.setNombre(resultado.getString("nombre"));
					grupoEncontrado.setOrigen(resultado.getString("origen"));
					grupoEncontrado.setCreacion(resultado.getInt("creacion"));
					grupoEncontrado.setGenero(resultado.getString("genero"));

				}
			} else {
				System.out.println("No hay resultados para el grupo con id " + idGrupo);
			}

			resultado.close();
			miStatement.close();
			
		} catch (Exception e) {
			System.out.println("Ha ocurrido un error al realizar la consulta " + e.getMessage());
			e.printStackTrace();
		}
		
		return grupoEncontrado;
	}
}
